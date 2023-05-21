import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class extends BaseSchema {
  protected tableName = 'pedido_statuses'

  public async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.primary(['pedido_id', 'status_id'])
      table.integer('pedido_id').unsigned().notNullable().references('id').inTable('pedidos')
      table.integer('status_id').unsigned().notNullable().references('id').inTable('statuses')
      table.string('observacao', 150).nullable()
      table.timestamp('created_at').notNullable()
    })
  }

  public async down() {
    this.schema.dropTable(this.tableName)
  }
}
