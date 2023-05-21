import { BaseModel, HasOne, column, hasOne } from '@ioc:Adonis/Lucid/Orm'
import Produto from './Produto'

export default class PedidoProduto extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ columnName: 'pedido_id', serializeAs: null })
  public pedidoId: number

  @column({ columnName: 'produto_id' })
  public produtoId: number

  @column({ columnName: 'valor' })
  public valor: number

  @column({ columnName: 'quantidade' })
  public quantidade: number

  @column({ columnName: 'observacao' })
  public observacao: string | null

  @hasOne(() => Produto, {
    localKey: 'produtoId',
    foreignKey: 'id',
  })
  public produto: HasOne<typeof Produto>
}
