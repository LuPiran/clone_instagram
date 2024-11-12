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

<div align="center"> 
   <table> <tr> 
      <td align="center" style="border: none;"><img src="https://github.com/LuPiran/clone_instagram/blob/main/screenshots/tela_login.png" alt="Tela de Login" width="200"><br><b>Tela de Login</b></td> 
      <td align="center" style="border: none;"><img src="https://github.com/LuPiran/clone_instagram/blob/main/screenshots/tela_cadastro.png" alt="Tela de Registro" width="200"><br><b>Tela de Registro</b></td> 
   </tr> </table> 
</div>

### 🏠 Home

<div align="center"> 
   <table> <tr> 
      <td align="center" style="border: none;"><img src="https://github.com/LuPiran/clone_instagram/blob/main/screenshots/home_page.png" alt="Tela de Login" width="200"><br><b>Home</b></td> 
      <td align="center" style="border: none;"><img src="https://github.com/LuPiran/clone_instagram/blob/main/screenshots/navegacao.png" alt="Tela de Registro" width="200"><br><b>Drawer de Navegação</b></td> 
   </tr> </table> 
</div>

### 📝 Postagens

<div align="center"> 
   <table> <tr> 
      <td align="center" style="border: none;"><img src="https://github.com/LuPiran/clone_instagram/blob/main/screenshots/add_post_page.png" alt="Tela de Login" width="200"><br><b>Nova Postagem</b></td> 
   </tr> </table> 
</div>

### 👤 Perfil
<div align="center"> 
   <table> <tr> 
      <td align="center" style="border: none;"><img src="https://github.com/LuPiran/clone_instagram/blob/main/screenshots/profile_page.png" alt="Tela de Login" width="200"><br><b>Tela de Perfil</b></td>
      <td align="center" style="border: none;"><img src="https://github.com/LuPiran/clone_instagram/blob/main/screenshots/edit_profile.png" alt="Tela de Login" width="200"><br><b>Tela de Editar Perfil</b></td> 
      <td align="center" style="border: none;"><img src="https://github.com/LuPiran/clone_instagram/blob/main/screenshots/amigo_page.png" alt="Tela de Login" width="200"><br><b>Tela de Outro Perfil</b></td> 
   </tr> </table> 
</div>

### 🔍 Busca
<div align="center"> 
   <table> <tr> 
      <td align="center" style="border: none;"><img src="https://github.com/LuPiran/clone_instagram/blob/main/screenshots/search_user.png" alt="Tela de Login" width="200"><br><b>Tela de Busca</b></td>
   </tr> </table> 
</div>

### ⚙️ Configurações
<div align="center"> 
   <table> <tr> 
      <td align="center" style="border: none;"><img src="https://github.com/LuPiran/clone_instagram/blob/main/screenshots/configuracao_escuro.png" alt="Tela de Login" width="200"><br><b>Tela de Configurações Escuro</b></td>
      <td align="center" style="border: none;"><img src="https://github.com/LuPiran/clone_instagram/blob/main/screenshots/configuracao_claro.png" alt="Tela de Login" width="200"><br><b>TTela de Configurações Claro</b></td>
   </tr> </table> 
</div>
Tela de Configurações (Tema Claro/Escuro)
