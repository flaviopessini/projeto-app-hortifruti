import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class extends BaseSchema {
  protected tableName = 'pedido_enderecos'

  public async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.integer('cidade_id').unsigned().notNullable().references('id').inTable('cidades')
      table.string('rua', 100).notNullable()
      table.string('numero', 10).nullable()
      table.string('bairro', 30).notNullable()
      table.string('cep', 20).nullable()
      table.string('ponto_referencia', 100).nullable()
      table.string('complemento', 255).nullable()
    })
  }

  public async down() {
    this.schema.dropTable(this.tableName)
  }
}
