import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class extends BaseSchema {
  protected tableName = 'meios_pagamentos'

  public async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.string('nome', 20).notNullable()
      table.boolean('ativo').notNullable().defaultTo(true)
    })
  }

  public async down() {
    this.schema.dropTable(this.tableName)
  }
}
