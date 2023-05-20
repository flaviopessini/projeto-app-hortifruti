import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class extends BaseSchema {
  protected tableName = 'produtos'

  public async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.string('nome', 100).notNullable().unique()
      table.string('descricao', 255).nullable()
      table.string('imagem', 255).nullable()
      table.decimal('preco', 10, 2).notNullable()
      table.string('unidade', 10).notNullable()
      table.string('posicao').notNullable()
      table.boolean('ativo').notNullable().defaultTo(true)
      table
        .integer('categoria_id')
        .unsigned()
        .notNullable()
        .references('id')
        .inTable('categorias')
        .onDelete('RESTRICT')
      /**
       * Uses timestamptz for PostgreSQL and DATETIME2 for MSSQL
       */
      table.timestamps(true, true)
      table.timestamp('deleted_at').nullable()
    })
  }

  public async down() {
    this.schema.dropTable(this.tableName)
  }
}
