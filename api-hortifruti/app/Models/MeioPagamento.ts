import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'

export default class MeioPagamento extends BaseModel {
  public static table = 'meios_pagamentos'

  @column({ isPrimary: true })
  public id: number

  @column({ columnName: 'nome' })
  public nome: string

  @column({ columnName: 'ativo' })
  public ativo: boolean
}
