import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import User from 'App/Models/User'
import Categoria from 'App/Models/Categoria'
import Estabelecimento from 'App/Models/Estabelecimento'

export default class CategoriaPolicy extends BasePolicy {
  public async isOwner(user: User, categoria: Categoria) {
    const estabelecimento = await Estabelecimento.query().where('user_id', user.id).firstOrFail()
    return categoria.estabelecimentoId === estabelecimento.id
  }
}
