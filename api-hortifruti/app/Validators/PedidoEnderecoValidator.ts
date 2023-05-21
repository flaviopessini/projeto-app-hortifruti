import { schema, CustomMessages, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class PedidoEnderecoValidator {
  constructor(protected ctx: HttpContextContract) {}

  /*
   * Define schema to validate the "shape", "type", "formatting" and "integrity" of data.
   *
   * For example:
   * 1. The username must be of data type string. But then also, it should
   *    not contain special characters or numbers.
   *    ```
   *     schema.string({}, [ rules.alpha() ])
   *    ```
   *
   * 2. The email must be of data type string, formatted as a valid
   *    email. But also, not used by any other user.
   *    ```
   *     schema.string({}, [
   *       rules.email(),
   *       rules.unique({ table: 'users', column: 'email' }),
   *     ])
   *    ```
   */
  public schema = schema.create({
    cidadeId: schema.number([rules.required()]),
    rua: schema.string({ trim: true }, [rules.required(), rules.maxLength(100)]),
    numero: schema.string.nullableAndOptional({ trim: true }, [rules.maxLength(10)]),
    bairro: schema.string({ trim: true }, [rules.required(), rules.maxLength(30)]),
    cep: schema.string.nullableAndOptional({ trim: true }, [rules.maxLength(20)]),
    pontoReferencia: schema.string.nullableAndOptional({ trim: true }, [rules.maxLength(100)]),
    complemento: schema.string.nullableAndOptional({ trim: true }, [rules.maxLength(255)]),
  })

  /**
   * Custom messages for validation failures. You can make use of dot notation `(.)`
   * for targeting nested fields and array expressions `(*)` for targeting all
   * children of an array. For example:
   *
   * {
   *   'profile.username.required': 'Username is required',
   *   'scores.*.number': 'Define scores as valid numbers'
   * }
   *
   */
  public messages: CustomMessages = {}
}
