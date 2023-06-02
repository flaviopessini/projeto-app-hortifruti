import { faker } from '@faker-js/faker'
import BaseSeeder from '@ioc:Adonis/Lucid/Seeder'
import Cidade from 'App/Models/Cidade'
import CidadesEstabelecimento from 'App/Models/CidadesEstabelecimento'
import Estabelecimento from 'App/Models/Estabelecimento'
import Estado from 'App/Models/Estado'
import User from 'App/Models/User'

export default class extends BaseSeeder {
  public async run() {
    const estados = await Estado.createMany([
      {
        nome: 'São Paulo',
        uf: 'SP',
      },
      {
        nome: 'Minas Gerais',
        uf: 'MG',
      },
    ])

    const cidades = await Cidade.createMany([
      {
        nome: 'Catanduva',
        ativo: true,
        estadoId: estados[0].id,
      },
      {
        nome: 'Belo Horizonte',
        ativo: true,
        estadoId: estados[1].id,
      },
    ])

    let estabelecimentos: Estabelecimento[] = []

    for (let index = 0; index < 20; index++) {
      const user = await User.create({
        email: `estabelecimento_${index}@email.com`,
        password: '12345678',
        tipo: 'estabelecimentos',
      })

      const e = await Estabelecimento.create({
        nome: `Estabelecimento ${index}`,
        logo: `https://picsum.photos/id/${index}/200/200`,
        bloqueado: false,
        online: false,
        userId: user.id,
      })

      estabelecimentos.push(e)
    }

    for (let index = 0; index < estabelecimentos.length; index++) {
      await CidadesEstabelecimento.create({
        cidadeId: index > estabelecimentos.length / 2 ? cidades[1].id : cidades[0].id,
        estabelecimentoId: estabelecimentos[index].id,
        custoEntrega: faker.number.float({ min: 15, max: 30 }),
      })
    }
  }
}
