import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Cidade from 'App/Models/Cidade'
import CidadesEstabelecimento from 'App/Models/CidadesEstabelecimento'
import Estabelecimento from 'App/Models/Estabelecimento'
import Pedido from 'App/Models/Pedido'

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
          produtoQuery.whereNull('deleted_at')
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
}
