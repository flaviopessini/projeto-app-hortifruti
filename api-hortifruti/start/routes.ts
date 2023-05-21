/*
|--------------------------------------------------------------------------
| Routes
|--------------------------------------------------------------------------
|
| This file is dedicated for defining HTTP routes. A single file is enough
| for majority of projects, however you can define routes in different
| files and just make sure to import them inside this file. For example
|
| Define routes in following two files
| ├── start/routes/cart.ts
| ├── start/routes/customer.ts
|
| and then import them inside `start/routes.ts` as follows
|
| import './routes/cart'
| import './routes/customer'
|
*/

import Route from '@ioc:Adonis/Core/Route'

// Rota de cadastro para o usuário do tipo cliente
Route.post('/cliente/cadastro', 'ClientesController.store')

// Rota de cidades
Route.get('/cidades', 'CidadesController.index')
Route.get('/cidades/:id/estabelecimentos', 'CidadesController.estabelecimentos')

// Rotas de login para os 3 tipos de usuários
Route.post('/login', 'AuthController.login')
Route.post('/logout', 'AuthController.logout')

// Rotas para usuário autenticado
Route.group(() => {
  // Rota para dados do usuário autenticado
  Route.get('/auth/me', 'AuthController.me')

  Route.resource('/enderecos', 'EnderecosController').only(['store', 'index', 'update', 'destroy'])

  // Rota para editar dados do cliente
  Route.put('/cliente', 'ClientesController.update')
}).middleware('auth')

Route.get('/', async () => {
  return { hello: 'hello world' }
})
