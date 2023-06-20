import { DateTime } from 'luxon'
import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'
import Env from '@ioc:Adonis/Core/Env'

export default class Produto extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ columnName: 'nome' })
  public nome: string

  @column({ columnName: 'descricao' })
  public descricao: string | null

  @column({
    columnName: 'imagem',
    consume: (value) => (value === null ? value : Env.get('API_URL') + value),
  })
  public imagem: string | null

  @column({ columnName: 'preco' })
  public preco: number

  @column({ columnName: 'unidade' })
  public unidade: string

  @column({ columnName: 'posicao' })
  public posicao: number

  @column({ columnName: 'ativo' })
  public ativo: boolean

  @column({ columnName: 'categoria_id' })
  public categoriaId: number

  @column({ columnName: 'ativo' })
  @column.dateTime({ columnName: 'created_at', autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ columnName: 'updated_at', autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @column.dateTime({ columnName: 'deleted_at' })
  public deletedAt: DateTime | null
}
