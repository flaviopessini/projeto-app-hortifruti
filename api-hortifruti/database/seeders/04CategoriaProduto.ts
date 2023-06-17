import BaseSeeder from '@ioc:Adonis/Lucid/Seeder'
import { faker } from '@faker-js/faker'
import Categoria from 'App/Models/Categoria'
import Produto from 'App/Models/Produto'

export default class extends BaseSeeder {
  public async run() {
    for (let index = 1; index < 20; index++) {
      let categoria = await Categoria.create({
        nome: `${faker.commerce.department()}_${index}`,
        descricao: faker.lorem.paragraph(),
        ativo: true,
        posicao: 1,
        estabelecimentoId: index,
      })

      await Produto.createMany([
        {
          nome: faker.commerce.productName(),
          imagem: faker.image.urlLoremFlickr({ category: 'food' }),
          ativo: true,
          categoriaId: categoria.id,
          descricao: '',
          posicao: '1',
          unidade: 'Kg',
          preco: faker.number.float({ min: 2, max: 100 }),
        },
      ])
    }
  }
}
