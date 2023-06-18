import { PathPrefixer } from '@adonisjs/core/build/standalone'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Database from '@ioc:Adonis/Lucid/Database'
import CidadesEstabelecimento from 'App/Models/CidadesEstabelecimento'
import Cliente from 'App/Models/Cliente'
import Endereco from 'App/Models/Endereco'
import Pedido from 'App/Models/Pedido'
import PedidoEndereco from 'App/Models/PedidoEndereco'
import PedidoProduto from 'App/Models/PedidoProduto'
import PedidoStatus from 'App/Models/PedidoStatus'
import Produto from 'App/Models/Produto'
import Status from 'App/Models/Status'
import PedidoValidator from 'App/Validators/PedidoValidator'
import UpdatePedidoValidator from 'App/Validators/UpdatePedidoValidator'
var randomstring = require('randomstring')

export default class PedidosController {
  public async index({ response, auth }: HttpContextContract) {
    const loggedUser = await auth.use('api').authenticate()
    const cliente = await Cliente.findByOrFail('userId', loggedUser.id)
    const pedidos = await Pedido.query()
      .where('clienteId', cliente.id)
      .preload('estabelecimento')
      .preload('pedidoStatus', (statusQuery) => {
        statusQuery.preload('status')
      })
      .orderBy('id', 'desc')

    return response.ok(pedidos)
  }

  public async show({ response, params }: HttpContextContract) {
    const hashId = params.hashId
    const pedido = await Pedido.query()
      .where('hashId', hashId)
      .preload('produtos', (produtosQuery) => {
        produtosQuery.preload('produto')
      })
      .preload('cliente')
      .preload('endereco')
      .preload('estabelecimento')
      .preload('meioPagamento')
      .preload('pedidoStatus', (statusQuery) => {
        statusQuery.preload('status')
      })
      .first()

    if (pedido === null) {
      return response.notFound('Pedido não encontrado')
    }

    return response.ok(pedido)
  }

  public async store({ request, response, auth }: HttpContextContract) {
    const payload = await request.validate(PedidoValidator)
    const loggedUser = await auth.use('api').authenticate()
    const cliente = await Cliente.findByOrFail('userId', loggedUser.id)
    let hashValid: boolean = false
    let hashId: string = ''

    while (!hashValid) {
      hashId = randomstring.generate({
        length: 8,
        charset: 'alphanumeric',
        capitalization: 'uppercase',
      })

      const hash = await Pedido.findBy('hashId', hashId)

      if (hash === null) {
        hashValid = true
      }
    }

    const endereco = await Endereco.findByOrFail('id', payload.enderecoId)

    // Transaction criando pedido
    const trx = await Database.transaction()

    try {
      const pedidoEndereco = await PedidoEndereco.create({
        cidadeId: endereco.cidadeId,
        rua: endereco.rua,
        numero: endereco.numero,
        bairro: endereco.bairro,
        cep: endereco.cep,
        pontoReferencia: endereco.pontoReferencia,
        complemento: endereco.complemento,
      })

      // Busca do custo de entrega e calcular valor total
      const estabelecimentoCidade = await CidadesEstabelecimento.query()
        .where('estabelecimentoId', payload.estabelecimentoId)
        .where('cidadeId', endereco.cidadeId)
        .firstOrFail()

      let valorTotal = 0
      for await (const prod of payload.produtos) {
        const produto = await Produto.findByOrFail('id', prod.produtoId)
        valorTotal += produto.preco * prod.quantidade
      }

      valorTotal = estabelecimentoCidade
        ? valorTotal + parseFloat(estabelecimentoCidade.custoEntrega.toString())
        : valorTotal

      valorTotal = parseFloat(valorTotal.toFixed(2))

      if (payload.trocoPara > 0 && payload.trocoPara < valorTotal) {
        await trx.rollback()
        return response.badRequest(
          'O valor do troco não pode ser menor que o valor total do pedido'
        )
      }

      const pedido = await Pedido.create({
        hashId: hashId,
        clienteId: cliente.id,
        estabelecimentoId: payload.estabelecimentoId,
        meioPagamentoId: payload.meioPagamentoId,
        trocoPara: payload.trocoPara,
        valor: valorTotal,
        pedidoEnderecoId: pedidoEndereco.id,
        custoEntrega: estabelecimentoCidade.custoEntrega,
        observacao: payload.observacao,
      })

      payload.produtos.forEach(async (p) => {
        let produto = await Produto.findByOrFail('id', p.produtoId)
        await PedidoProduto.create({
          pedidoId: pedido.id,
          produtoId: p.produtoId,
          valor: produto.preco,
          quantidade: p.quantidade,
          observacao: p.observacao,
        })
      })

      await PedidoStatus.create({
        pedidoId: pedido.id,
        statusId: 1,
      })

      // Confirma a transaction
      await trx.commit()

      return response.created(pedido)
    } catch (error) {
      console.log(error)

      // Reverte a transaction
      await trx.rollback()
      return response.badRequest('Something in the request is wrong: ' + error)
    }
  }

  public async update({ params, request, response, bouncer }: HttpContextContract) {
    await bouncer.authorize('UserIsEstabelecimento')

    const payload = await request.validate(UpdatePedidoValidator)

    const pedido = await Pedido.query().where('hash_id', params.hashId).firstOrFail()

    await bouncer.with('PedidoPolicy').authorize('canUpdate', pedido)

    const pedidoStatus = await PedidoStatus.query()
      .select('status_id')
      .where('pedido_id', pedido.id)
      .orderBy('status_id', 'desc')
      .firstOrFail()

    if (payload.statusId <= pedidoStatus.statusId) {
      return response.badRequest('O status do pedido não pode ser anterior ao status atual!')
    }

    const status = await Status.findOrFail(payload.statusId)

    await PedidoStatus.create({
      pedidoId: pedido.id,
      statusId: payload.statusId,
    })

    return response.ok(`Pedido #${pedido.hashId} foi ${status.status}`)
  }
}
