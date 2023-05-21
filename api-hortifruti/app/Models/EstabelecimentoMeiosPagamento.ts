import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'

export default class EstabelecimentoMeiosPagamento extends BaseModel {
  @column({ columnName: 'estabelecimento_id', isPrimary: true })
  public estabelecimentroId: number

  @column({ columnName: 'meio_pagamento_id', isPrimary: true })
  public meioPagamentoId: number
}
