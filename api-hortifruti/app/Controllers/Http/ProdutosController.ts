import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import CreateEditProdutoValidator from 'App/Validators/CreateEditProdutoValidator'
import Drive from '@ioc:Adonis/Core/Drive'
import Produto from 'App/Models/Produto'
import { DateTime } from 'luxon'

export default class ProdutosController {
  public async index({ request, response, bouncer }: HttpContextContract) {
    const categoriaId = request.input('categoriaId')
    if (categoriaId !== null && categoriaId !== undefined && categoriaId >= 1) {
      await bouncer.authorize('UserIsEstabelecimento')
      await bouncer.with('ProdutoPolicy').authorize('isOwner', categoriaId)
      // const page = request.input('page', 1)
      // const limit = 15
      const produtos = await Produto.query()
        //.if(request.input('ativo'), (builder) => {
        //  builder.where('ativo', request.input('ativo'))
        //})
        .if(request.input('categoriaId'), (builder) => {
          builder.where('categoria_id', request.input('categoriaId'))
        })
        .whereNull('deleted_at')
      //.paginate(page, limit)

      return response.ok(produtos)
    } else {
      return response.badRequest(`O código da categoria é obrigatório`)
    }
  }

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

  public async removeImagem({ response, bouncer, params }: HttpContextContract) {
    await bouncer.authorize('UserIsEstabelecimento')
    const produto = await Produto.findOrFail(params.id)
    await bouncer.with('ProdutoPolicy').authorize('isOwner', produto.categoriaId)
    if (produto.imagem) {
      const file = produto.imagem.split('/').filter(Boolean).pop()
      if (file?.length) {
        await Drive.delete(file)
      }
      produto.imagem = null
      await produto.save()
    }

    return response.noContent()
  }
}
