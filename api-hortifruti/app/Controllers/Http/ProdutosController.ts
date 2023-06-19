import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import CreateEditProdutoValidator from 'App/Validators/CreateEditProdutoValidator'
import Drive from '@ioc:Adonis/Core/Drive'
import Produto from 'App/Models/Produto'
import { DateTime } from 'luxon'

export default class ProdutosController {
  public async store({ request, response, bouncer }: HttpContextContract) {
    await bouncer.authorize('UserIsEstabelecimento')

    const payload = await request.validate(CreateEditProdutoValidator)
    await bouncer.with('ProdutoPolicy').authorize('isOwner', payload.categoriaId)

    if (payload.imagem) {
      await payload.imagem.moveToDisk('./')
    }

    const produto = await Produto.create({
      nome: payload.nome,
      descricao: payload.descricao,
      imagem: payload.imagem ? await Drive.getUrl(payload.imagem.fileName!) : null,
      ativo: payload.ativo || true,
      posicao: payload.posicao,
      unidade: payload.unidade,
      preco: payload.preco,
      categoriaId: payload.categoriaId,
    })

    return response.created({ produto })
  }

  public async update({ request, response, bouncer, params }: HttpContextContract) {
    await bouncer.authorize('UserIsEstabelecimento')
    const payload = await request.validate(CreateEditProdutoValidator)
    const produto = await Produto.findOrFail(params.id)
    await bouncer.with('ProdutoPolicy').authorize('isOwner', produto.categoriaId)

    if (payload.imagem) {
      // verifica se já existe e apaga a imagem antiga
      if (produto.imagem) {
        const file = produto.imagem.split('/').filter(Boolean).pop()
        if (file?.length) {
          await Drive.delete(file)
        }
      }
      await payload.imagem.moveToDisk('./')
    }

    let tmpProduto = {
      nome: payload.nome,
      descricao: payload.descricao,
      preco: payload.preco,
      unidade: payload.unidade,
      ativo: payload.ativo,
      posicao: payload.posicao,
      categoriaId: payload.categoriaId,
    }

    if (payload.imagem) {
      tmpProduto['imagem'] = await Drive.getUrl(payload.imagem.fileName!)
    }

    produto.merge(tmpProduto)
    await produto.save()

    return response.ok(produto)
  }

  public async destroy({ params, response, bouncer }: HttpContextContract) {
    await bouncer.authorize('UserIsEstabelecimento')
    const produto = await Produto.findOrFail(params.id)
    await bouncer.with('ProdutoPolicy').authorize('isOwner', produto.categoriaId)
    produto.deletedAt = DateTime.local()
    await produto.save()
    return response.noContent()
  }
}
