import Drive from '@ioc:Adonis/Core/Drive'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Cidade from 'App/Models/Cidade'
import CidadesEstabelecimento from 'App/Models/CidadesEstabelecimento'
import Estabelecimento from 'App/Models/Estabelecimento'
import Pedido from 'App/Models/Pedido'
import User from 'App/Models/User'
import UpdateEstabelecimentoValidator from 'App/Validators/UpdateEstabelecimentoValidator'

export default class EstabelecimentosController {
  public async pedidos({ response, auth }: HttpContextContract) {
    const loggedUser = await auth.use('api').authenticate()
    const estabelecimento = await Estabelecimento.findByOrFail('userId', loggedUser.id)
    const pedidos = await Pedido.query()
      .where('estabelecimento_id', estabelecimento.id)
      .preload('cliente')
      .preload('pedidoStatus', (statusQuery) => {
        statusQuery.preload('status')
      })
      .orderBy('id', 'desc')

    return response.ok(pedidos)
  }

  public async show({ params, response }: HttpContextContract) {
    const eId: number = params.id
    //const estabelecimento = await Estabelecimento.findByOrFail('id', eId)
    let listaCidades: any = []
    const cidades = await CidadesEstabelecimento.query().where('estabelecimento_id', eId)
    for await (const i of cidades) {
      const c = await Cidade.findByOrFail('id', i.cidadeId)
      listaCidades.push({
        id: c.id,
        cidade: c.nome,
        custoEntrega: i.custoEntrega,
      })
    }

    const estabelecimentos = await Estabelecimento.query()
      .where('id', eId)
      .preload('categorias', (categoriaQuery) => {
        categoriaQuery.preload('produtos', (produtoQuery) => {
          //produtoQuery.whereNull('deleted_at')
          produtoQuery.where('ativo', 1).orWhereNotNull('deleted_at')
        })
      })
      .preload('meiosPagamentos')
      .firstOrFail()

    return response.ok({
      id: estabelecimentos.id,
      nome: estabelecimentos.nome,
      logo: estabelecimentos.logo,
      bloqueado: estabelecimentos.bloqueado,
      online: estabelecimentos.online,
      cidades: listaCidades,
      meiosPagamentos: estabelecimentos.meiosPagamentos,
      categorias: estabelecimentos.categorias,
    })
  }

  public async update({ auth, bouncer, request, response }: HttpContextContract) {
    await bouncer.authorize('UserIsEstabelecimento')
    const payload = await request.validate(UpdateEstabelecimentoValidator)
    const userAuth = await auth.use('api').authenticate()
    const user = await User.findOrFail(userAuth.id)
    const estabelecimento = await Estabelecimento.findByOrFail('user_id', user.id)
    if (payload.nome !== undefined) {
      estabelecimento.nome = payload.nome
    }
    if (payload.online !== undefined) {
      estabelecimento.online = payload.online
    }
    if (payload.email !== undefined) {
      user.email = payload.email
    }
    if (payload.password !== undefined) {
      user.password = payload.password
    }
    if (payload.logo !== undefined) {
      await payload.logo?.moveToDisk('./')
      estabelecimento.logo = await Drive.getUrl(payload.logo?.fileName!)
    }
    await estabelecimento.save()
    await user.save()
    //return response.ok({ user, estabelecimento })
    const estabelecimentoUpdated = await Estabelecimento.findByOrFail('user_id', user.id)
    const data = {
      estabelecimentoId: estabelecimentoUpdated.id,
      nome: estabelecimentoUpdated.nome,
      logo: estabelecimentoUpdated.logo,
      online: estabelecimentoUpdated.online,
      bloqueado: estabelecimentoUpdated.bloqueado,
      email: user.email,
    }

    return response.ok(data)
  }

  public async removeLogo({ auth, bouncer, response }: HttpContextContract) {
    await bouncer.authorize('UserIsEstabelecimento')
    const userAuth = await auth.use('api').authenticate()
    const estabelecimento = await Estabelecimento.findByOrFail('user_id', userAuth.id)
    if (estabelecimento.logo !== null) {
      const file = estabelecimento.logo.split('/').filter(Boolean).pop()
      if (file?.length) {
        await Drive.delete(file)
      }
      estabelecimento.logo = null
      await estabelecimento.save()
    }

    return response.noContent()
  }
}
