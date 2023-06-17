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

// Rotas de login para os 3 tipos de usuários
Route.post('/login', 'AuthController.login')
Route.post('/logout', 'AuthController.logout')

// Rota de cadastro para o usuário do tipo cliente
// Rota de cidades
Route.get('/cidades', 'CidadesController.index')
Route.get('/cidades/:id/estabelecimentos', 'CidadesController.estabelecimentos')

// Rota publica para buscar informações de um estabelecimento
Route.get('/estabelecimentos/:id', 'EstabelecimentosController.show')

Route.post('/cliente/cadastro', 'ClientesController.store')

// Rotas para usuário autenticado
Route.group(() => {
  // Rota para dados do usuário autenticado
  Route.get('/auth/me', 'AuthController.me')

  // Grupo de rotas para endereço
  Route.resource('/enderecos', 'EnderecosController').only(['store', 'index', 'update', 'destroy'])

  // Rota para pedidos
  Route.post('/pedidos', 'PedidosController.store')
  Route.get('/pedidos', 'PedidosController.index')
  Route.get('/pedidos/:hashId', 'PedidosController.show')

  // Rota de estabelecimento autenticado
  Route.get('/estabelecimento/pedidos', 'EstabelecimentosController.pedidos')

  // Rota para editar dados do cliente
  Route.put('/cliente', 'ClientesController.update')

  // Grupo de rotas para o estabelecimento
  Route.resource('/estabelecimento/categorias', 'CategoriasController').only([
    'store',
    'index',
    'update',
    'destroy',
  ])
}).middleware('auth')

Route.get('/', async () => {
  return { hello: 'hello world' }
})
