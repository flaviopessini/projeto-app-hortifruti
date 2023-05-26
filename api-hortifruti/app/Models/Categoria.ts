import { DateTime } from 'luxon'
import { BaseModel, HasMany, column, hasMany } from '@ioc:Adonis/Lucid/Orm'
import Produto from './Produto'

export default class Categoria extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ columnName: 'nome' })
  public nome: string

  @column({ columnName: 'descricao' })
  public descricao: string | null

  @column({ columnName: 'posicao' })
  public posicao: string

  @column({ columnName: 'ativo' })
  public ativo: boolean

  @column({ columnName: 'estabelecimento_id' })
  public estabelecimentoId: number

  @hasMany(() => Produto, {
    foreignKey: 'categoriaId',
    localKey: 'id',
  })
  public produtos: HasMany<typeof Produto>

  @column.dateTime({ columnName: 'created_at', autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ columnName: 'updated_at', autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @column.dateTime({ columnName: 'deleted_at' })
  public deletedAt: DateTime | null
}
