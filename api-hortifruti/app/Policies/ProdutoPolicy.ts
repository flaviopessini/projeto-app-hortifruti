import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import Categoria from 'App/Models/Categoria'
import Estabelecimento from 'App/Models/Estabelecimento'
import User from 'App/Models/User'

export default class ProdutoPolicy extends BasePolicy {
  public async isOwner(user: User, categoriaId: number) {
    const estabelecimento = await Estabelecimento.query().where('user_id', user.id).firstOrFail()
    const categoria = await Categoria.findOrFail(categoriaId)
    return categoria.estabelecimentoId === estabelecimento.id
  }
}
