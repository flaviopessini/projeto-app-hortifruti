import { DateTime } from 'luxon'
import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'

export default class Estabelecimento extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ columnName: 'user_id' })
  public userId: number

  @column({ columnName: 'nome' })
  public nome: string

  @column({ columnName: 'logo' })
  public logo: string | null

  @column({ columnName: 'bloqueado' })
  public bloqueado: boolean

  @column({ columnName: 'online' })
  public online: boolean

  @column.dateTime({ columnName: 'updated_at', autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
