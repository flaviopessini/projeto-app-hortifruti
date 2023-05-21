import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class extends BaseSchema {
  protected tableName = 'enderecos'

  public async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.integer('cliente_id').unsigned().notNullable().references('id').inTable('clientes')
      table.integer('cidade_id').unsigned().notNullable().references('id').inTable('cidades')
      table.string('rua', 100).notNullable()
      table.string('numero', 10).nullable()
      table.string('bairro', 30).notNullable()
      table.string('cep', 20).nullable()
      table.string('ponto_referencia', 100).nullable()
      table.string('complemento', 255).nullable()

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
