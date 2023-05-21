import { DateTime } from 'luxon'
import { BaseModel, HasOne, ManyToMany, column, hasOne, manyToMany } from '@ioc:Adonis/Lucid/Orm'
import Estado from './Estado'
import Estabelecimento from './Estabelecimento'

export default class Cidade extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ columnName: 'nome' })
  public nome: string

  @column({ columnName: 'estado_id' })
  public estadoId: number

  @column({ columnName: 'ativo' })
  public ativo: boolean

  @hasOne(() => Estado, {
    foreignKey: 'id',
    localKey: 'estadoId',
  })
  public estado: HasOne<typeof Estado>

  @manyToMany(() => Estabelecimento, {
    pivotTable: 'cidades_estabelecimentos',
    localKey: 'id',
    pivotForeignKey: 'cidade_id',
    relatedKey: 'id',
    pivotRelatedForeignKey: 'estabelecimento_id',
  })
  public estabelecimentos: ManyToMany<typeof Estabelecimento>

  @column.dateTime({ columnName: 'created_at', autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ columnName: 'updated_at', autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
