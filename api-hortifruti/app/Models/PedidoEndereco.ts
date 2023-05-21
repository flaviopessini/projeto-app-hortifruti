import { BaseModel, HasOne, column, hasOne } from '@ioc:Adonis/Lucid/Orm'
import Cidade from './Cidade'

export default class PedidoEndereco extends BaseModel {
  @column({ isPrimary: true })
  public id: number

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
}
