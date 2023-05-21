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
import PedidoValidator from 'App/Validators/PedidoValidator'
var randomstring = require('randomstring')

export default class PedidosController {
  public async index({}: HttpContextContract) {}

  public async show({}: HttpContextContract) {}

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

      let valorTotal: number = 0
      for await (const prod of payload.produtos) {
        const produto = await Produto.findByOrFail('id', prod.produtoId)
        valorTotal += produto.preco * prod.quantidade
      }

      valorTotal += estabelecimentoCidade.custoEntrega
      valorTotal = parseFloat(valorTotal.toFixed(2))

      if (payload.trocoPara !== null && payload.trocoPara < valorTotal) {
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
      // Reverte a transaction
      await trx.rollback()
      return response.badRequest('Something in the request is wrong')
    }
  }
}
