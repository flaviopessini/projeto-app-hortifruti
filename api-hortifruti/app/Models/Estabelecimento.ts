import { DateTime } from 'luxon'
import { BaseModel, HasMany, ManyToMany, column, hasMany, manyToMany } from '@ioc:Adonis/Lucid/Orm'
import Categoria from './Categoria'
import MeioPagamento from './MeioPagamento'

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

  @hasMany(() => Categoria, {
    foreignKey: 'estabelecimentoId',
    localKey: 'id',
  })
  public categorias: HasMany<typeof Categoria>

  @manyToMany(() => MeioPagamento, {
    pivotTable: 'estabelecimento_meios_pagamentos',
    localKey: 'id',
    pivotForeignKey: 'estabelecimentoId',
    relatedKey: 'id',
    pivotRelatedForeignKey: 'meioPagamentoId',
  })
  public meiosPagamentos: ManyToMany<typeof MeioPagamento>
}
