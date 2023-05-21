import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class extends BaseSchema {
  protected tableName = 'pedidos'

  public async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.string('hash_id').unique().notNullable()
      table.integer('cliente_id').unsigned().notNullable().references('id').inTable('clientes')
      table
        .integer('estabelecimento_id')
        .unsigned()
        .notNullable()
        .references('id')
        .inTable('estabelecimentos')
      table
        .integer('meio_pagamento_id')
        .unsigned()
        .notNullable()
        .references('id')
        .inTable('meios_pagamentos')
      table
        .integer('pedido_endereco_id')
        .unsigned()
        .notNullable()
        .references('id')
        .inTable('pedido_enderecos')
      table.decimal('valor', 10, 2).notNullable()
      table.decimal('troco_para', 10, 2).notNullable()
      table.decimal('custo_entrega', 10, 2).notNullable()
      table.string('observacao').nullable()
      /**
       * Uses timestamptz for PostgreSQL and DATETIME2 for MSSQL
       */
      table.timestamps(true, true)
    })
  }

  public async down() {
    this.schema.dropTable(this.tableName)
  }
}
