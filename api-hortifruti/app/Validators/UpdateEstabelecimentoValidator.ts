import { schema, CustomMessages, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class UpdateEstabelecimentoValidator {
  constructor(protected ctx: HttpContextContract) {}

  // Referência para pegar o Id do usuário autenticado a partir do contexto.
  public refs = schema.refs({
    user_id: this.ctx.auth.user!.id,
  })

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
    nome: schema.string.optional({ trim: true }, [rules.minLength(3), rules.maxLength(50)]),
    logo: schema.file.nullableAndOptional({ size: '5mb', extnames: ['jpg', 'jpeg', 'png'] }),
    online: schema.boolean.optional(),
    email: schema.string.optional({ trim: true }, [
      rules.email(),
      rules.unique({ table: 'users', column: 'email', whereNot: { id: this.refs.user_id } }),
    ]),
    password: schema.string.optional({ trim: true }, [rules.minLength(8), rules.maxLength(255)]),
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
