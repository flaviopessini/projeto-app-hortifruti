import { DateTime } from 'luxon'
import { BaseModel, HasMany, HasOne, column, hasMany, hasOne } from '@ioc:Adonis/Lucid/Orm'
import Cliente from './Cliente'
import PedidoStatus from './PedidoStatus'
import Estabelecimento from './Estabelecimento'
import PedidoProduto from './PedidoProduto'
import PedidoEndereco from './PedidoEndereco'
import MeioPagamento from './MeioPagamento'

export default class Pedido extends BaseModel {
  @column({ isPrimary: true, serializeAs: null })
  public id: number

  @column({ columnName: 'hash_id' })
  public hashId: string

  @column({ columnName: 'estabelecimento_id' })
  public estabelecimentoId: number

  @column({ columnName: 'cliente_id' })
  public clienteId: number

  @column({ columnName: 'meio_pagamento_id' })
  public meioPagamentoId: number

  @column({ columnName: 'pedido_endereco_id' })
  public pedidoEnderecoId: number

  @column({ columnName: 'valor' })
  public valor: number

  @column({ columnName: 'troco_para' })
  public trocoPara: number

  @column({ columnName: 'custo_entrega' })
  public custoEntrega: number

  @column({ columnName: 'observacao' })
  public observacao: string | null

  @column.dateTime({ columnName: 'created_at', autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ columnName: 'updated_at', autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @hasOne(() => Cliente, {
    localKey: 'clienteId',
    foreignKey: 'id',
  })
  public cliente: HasOne<typeof Cliente>

  @hasMany(() => PedidoStatus, {
    localKey: 'id',
    foreignKey: 'pedidoId',
  })
  public pedidoStatus: HasMany<typeof PedidoStatus>

  @hasOne(() => Estabelecimento, {
    localKey: 'estabelecimentoId',
    foreignKey: 'id',
  })
  public estabelecimento: HasOne<typeof Estabelecimento>

  @hasMany(() => PedidoProduto, {
    foreignKey: 'pedidoId',
    localKey: 'id',
  })
  public produtos: HasMany<typeof PedidoProduto>

  @hasOne(() => PedidoEndereco, {
    localKey: 'pedidoEnderecoId',
    foreignKey: 'id',
  })
  public endereco: HasOne<typeof PedidoEndereco>

  @hasOne(() => MeioPagamento, {
    localKey: 'meioPagamentoId',
    foreignKey: 'id',
  })
  public meioPagamento: HasOne<typeof MeioPagamento>
}
