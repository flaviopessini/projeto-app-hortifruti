import { DateTime } from 'luxon'
import { BaseModel, HasMany, HasOne, column, hasMany, hasOne } from '@ioc:Adonis/Lucid/Orm'
import Cidade from './Cidade'

export default class Endereco extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ columnName: 'cliente_id' })
  public clienteId: number

  @column({ columnName: 'cidade_id' })
  public cidadeId: number

  @column({ columnName: 'rua' })
  public rua: string

  @column({ columnName: 'numero' })
  public numero: string | null

  @column({ columnName: 'bairro' })
  public bairro: string

  @column({ columnName: 'cep' })
  public cep: string | null

  @column({ columnName: 'ponto_referencia' })
  public pontoReferencia: string | null

  @column({ columnName: 'complemento' })
  public complemento: string | null

  @hasOne(() => Cidade, {
    localKey: 'cidadeId',
    foreignKey: 'id',
  })
  public cidade: HasOne<typeof Cidade>

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
