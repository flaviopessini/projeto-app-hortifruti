import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'

export default class CidadesEstabelecimento extends BaseModel {
  @column({ columnName: 'cidade_id', isPrimary: true })
  public cidadeId: number

  @column({ columnName: 'estabelecimento_id', isPrimary: true })
  public estabelecimentoId: number

  @column({ columnName: 'custo_entrega' })
  public custoEntrega: number
}
