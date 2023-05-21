import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'

export default class MeioPagamento extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ columnName: 'nome' })
  public nome: string

  @column({ columnName: 'ativo' })
  public ativo: boolean
}
