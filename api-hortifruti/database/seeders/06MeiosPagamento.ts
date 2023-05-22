import BaseSeeder from '@ioc:Adonis/Lucid/Seeder'
import Estabelecimento from 'App/Models/Estabelecimento'
import EstabelecimentoMeiosPagamento from 'App/Models/EstabelecimentoMeiosPagamento'
import MeioPagamento from 'App/Models/MeioPagamento'

export default class extends BaseSeeder {
  public async run() {
    await MeioPagamento.createMany([
      {
        nome: 'Dinheiro',
        ativo: true,
      },
      {
        nome: 'Cartão Crédito',
        ativo: true,
      },
      {
        nome: 'Cartão Débito',
        ativo: true,
      },
      {
        nome: 'Pix',
        ativo: true,
      },
      {
        nome: 'PicPay',
        ativo: true,
      },
    ])

    const estabelecimentos = await Estabelecimento.all()

    for (const e of estabelecimentos) {
      await EstabelecimentoMeiosPagamento.createMany([
        {
          estabelecimentroId: e.id,
          meioPagamentoId: 1,
        },
        {
          estabelecimentroId: e.id,
          meioPagamentoId: 2,
        },
        {
          estabelecimentroId: e.id,
          meioPagamentoId: 3,
        },
        {
          estabelecimentroId: e.id,
          meioPagamentoId: 4,
        },
        {
          estabelecimentroId: e.id,
          meioPagamentoId: 5,
        },
      ])
    }
  }
}
