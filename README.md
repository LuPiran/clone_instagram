# 📱 Social Media App - Flutter
Este é um aplicativo de mídia social desenvolvido em Flutter que permite aos usuários criar contas, fazer postagens, curtir e comentar em postagens de amigos, seguir amigos, editar perfil e personalizar o tema do aplicativo (claro ou escuro). O projeto utiliza a arquitetura BloC/Cubit para gerenciar o estado e Firebase para autenticação e armazenamento de dados.

## 🌟 Funcionalidades
* 🔑 Cadastro e Login de Usuário: Crie sua conta e faça login no aplicativo.
    * 📝 Postagens:
    * ➕ Criar novos posts.
    * 🗑️ Deletar seus próprios posts.
    * ❤️ Curtir posts de amigos.
    * 💬 Comentar em posts de amigos.
    * ❌ Deletar seus próprios comentários.
* 👥 Amigos:
    * ➕ Seguir outros usuários.
    * 🔔 Ser seguido por outros usuários.
* 👤 Perfil:
    * ✏️ Editar informações do perfil, incluindo foto e biografia.
    * 📋 Exibir lista de seguidores e seguidos.
* 🎨 Tema:
    * 🌞/🌙 Alterne entre tema claro e escuro.
* 📲 Gerenciamento de Estado:
  * Utiliza BloC/Cubit para controle eficiente do estado.
## 🛠️ Tecnologias Utilizadas
* 🖥️ Flutter
* 🛠️ Dart
* 🔥 Firebase:
  * Firebase Authentication: Para gerenciamento de usuários (login/cadastro).
  * Cloud Firestore: Para armazenamento de dados em tempo real.
  * Firebase Storage: Para armazenamento de fotos de perfil e imagens de postagens.
* 🎯 BloC/Cubit: Para gerenciamento de estado.
* 🔌 Provider: Para injeção de dependências.
## 📸 Screenshots do Projeto
### 🔑 Autenticação
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  </head>
  <body>
   <p align="center">
   <div class="row">
      <h4>Tela de Login</h4>
  <img src="./screenshots/tela_login.png" alt="Tela de Login" width="200" />
   <h4>Tela de Registro</h4>
  <img src="./screenshots/tela_cadastro.png" alt="Tela de Cadastro" width="200" />
   </div>
</p>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  </body>
</html>
Tela de Login
Tela de Registro
### 🏠 Home
<img src="link_da_imagem_3" width="250"> <img src="link_da_imagem_4" width="250">

Feed de Postagens
Drawer de Navegação
### 📝 Postagens
<img src="link_da_imagem_5" width="250"> <img src="link_da_imagem_6" width="250">

Criar Nova Postagem
Detalhes de Postagem com Comentários
### 👤 Perfil
<img src="link_da_imagem_7" width="250"> <img src="link_da_imagem_8" width="250">

Tela de Perfil do Usuário
Edição de Perfil
### 🔍 Busca
<img src="link_da_imagem_9" width="250">
Tela de Busca de Usuários
### ⚙️ Configurações
<img src="link_da_imagem_10" width="250">
Tela de Configurações (Tema Claro/Escuro)
