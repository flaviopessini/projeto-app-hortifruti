import { DateTime } from 'luxon'
import { BaseModel, HasOne, column, hasOne } from '@ioc:Adonis/Lucid/Orm'
import Status from './Status'

export default class PedidoStatus extends BaseModel {
  @column({ columnName: 'pedido_id', isPrimary: true, serializeAs: null })
  public pedidoId: number

  @column({ columnName: 'status_id', isPrimary: true })
  public statusId: number

  @column({ columnName: 'observacao' })
  public observacao: string | null

  @column.dateTime({ columnName: 'created_at', autoCreate: true })
  public createdAt: DateTime

  @hasOne(() => Status, {
    localKey: 'statusId',
    foreignKey: 'id',
  })
  public status: HasOne<typeof Status>
}
