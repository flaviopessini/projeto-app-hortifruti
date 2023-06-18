import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import User from 'App/Models/User'
import Pedido from 'App/Models/Pedido'
import Estabelecimento from 'App/Models/Estabelecimento'

export default class PedidoPolicy extends BasePolicy {
  public async canUpdate(user: User, pedido: Pedido) {
    const estabelecimento = await Estabelecimento.query().where('user_id', user.id).firstOrFail()
    return pedido.estabelecimentoId === estabelecimento.id
  }
}
