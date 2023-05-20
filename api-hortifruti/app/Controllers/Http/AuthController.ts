import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Admin from 'App/Models/Admin'
import Cliente from 'App/Models/Cliente'
import Estabelecimento from 'App/Models/Estabelecimento'
import User from 'App/Models/User'

export default class AuthController {
  public async login({ request, response, auth }: HttpContextContract) {
    const email = request.input('email')
    const password = request.input('password')
    try {
      const user = await User.findByOrFail('email', email)
      let expira: any
      switch (user.tipo) {
        case 'clientes':
          expira = '30days'
          break
        case 'estabelecimentos':
          expira = '7days'
          break
        case 'admins':
          expira = '1days'
          break
        default:
          expira = '7days'
          break
      }
      const token = await auth.use('api').attempt(email, password, {
        expiresIn: expira,
        name: user.serialize().email,
      })
      return response.ok(token)
    } catch (error) {
      return response.badRequest('invalid credentials')
    }
  }

  public async logout({ response, auth }: HttpContextContract) {
    try {
      await auth.use('api').revoke()
    } catch (error) {
      return response.unauthorized('No authorization')
    }

    return response.ok({
      revoked: true,
    })
  }

  public async me({ response, auth }: HttpContextContract) {
    //return response.ok(auth.user)
    const loggedUser = await auth.use('api').authenticate()
    let data: any
    switch (loggedUser.tipo) {
      case 'clientes':
        const cliente = await Cliente.findByOrFail('userId', loggedUser.id)
        data = {
          clienteId: cliente.id,
          nome: cliente.nome,
          telefone: cliente.telefone,
          email: loggedUser.email,
        }
        break
      case 'estabelecimentos':
        const estabelecimento = await Estabelecimento.findByOrFail('userId', loggedUser.id)
        data = {
          estabelecimentoId: estabelecimento.id,
          nome: estabelecimento.nome,
          logo: estabelecimento.logo,
          online: estabelecimento.online,
          bloqueado: estabelecimento.bloqueado,
          email: loggedUser.email,
        }
        break
      case 'admins':
        const admin = await Admin.findByOrFail('userId', loggedUser.id)
        data = {
          adminId: admin.id,
          nome: admin.nome,
          email: loggedUser.email,
        }
        break
      default:
        return response.unauthorized('Unauthorized user - type not found')
    }

    return response.ok(data)
  }
}
