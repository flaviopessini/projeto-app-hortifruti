import { DateTime } from 'luxon'
import { BaseModel, HasMany, column, hasMany } from '@ioc:Adonis/Lucid/Orm'
import Endereco from './Endereco'

export default class Cliente extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ columnName: 'user_id' })
  public userId: number

  @column({ columnName: 'nome' })
  public nome: string

  @column({ columnName: 'telefone' })
  public telefone: string

  @hasMany(() => Endereco, {
    localKey: 'id',
    foreignKey: 'clienteId',
  })
  public enderecos: HasMany<typeof Endereco>

  @column.dateTime({ columnName: 'updated_at', autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
