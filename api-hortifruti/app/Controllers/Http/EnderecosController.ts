import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Cliente from 'App/Models/Cliente'
import Endereco from 'App/Models/Endereco'
import CreateEditEnderecoValidator from 'App/Validators/CreateEditEnderecoValidator'

export default class EnderecosController {
  public async index({ response, auth }: HttpContextContract) {
    const loggedUser = await auth.use('api').authenticate()
    const cliente = await Cliente.findByOrFail('userId', loggedUser.id)
    console.log(cliente)

    const getCliente = await Cliente.query()
      .where('id', cliente.id)
      .preload('enderecos', (queryCidade) => {
        queryCidade.preload('cidade', (queryEstado) => {
          queryEstado.preload('estado')
        })
      })
      .firstOrFail()

    return response.ok(getCliente.enderecos)
  }

  public async store({ request, response, auth }: HttpContextContract) {
    const payload = await request.validate(CreateEditEnderecoValidator)
    const loggedUser = await auth.use('api').authenticate()
    const cliente = await Cliente.findByOrFail('user_id', loggedUser.id)
    const endereco = await Endereco.create({
      cidadeId: payload.cidadeId,
      clienteId: cliente.id,
      rua: payload.rua,
      numero: payload.numero,
      bairro: payload.bairro,
      cep: payload.cep,
      pontoReferencia: payload.pontoReferencia,
      complemento: payload.complemento,
    })
    return response.created(endereco)
  }
}
