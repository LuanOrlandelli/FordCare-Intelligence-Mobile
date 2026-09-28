# 🚗 FordCare Intelligence

## Sprint 3 — Mobile Development and IoT

Projeto desenvolvido para o **Challenge Ford 2026 — FIAP**, com foco em pós-venda, relacionamento com clientes e apoio à tomada de decisão.

### 👥 Integrantes

- **Luan Orlandelli Ramos** — RM 554747
- **Jorge Luiz Silva Santos** — RM 554418
- **Arthur Bobadilla Franchi** — RM 555056

---

## 📱 Sobre o FordCare Intelligence

O **FordCare Intelligence** é uma solução desenvolvida para apoiar a gestão do relacionamento com clientes no pós-venda Ford.

A proposta é centralizar informações importantes sobre clientes, leads e indicadores em uma única solução, facilitando o acompanhamento das ações realizadas e utilizando dados e inteligência artificial como apoio à tomada de decisão.

Nesta Sprint 3, o foco do desenvolvimento mobile foi consolidar a aplicação como um produto funcional, integrado ao backend e preparado para distribuição em dispositivos Android.

---

## 🎯 Objetivos da Sprint 3

A entrega foi desenvolvida considerando os principais objetivos propostos para **Mobile Development and IoT**:

- Entregar a versão final da aplicação mobile;
- Disponibilizar os principais fluxos do FordCare Intelligence;
- Consolidar a identidade visual da solução;
- Manter consistência entre componentes, cores, tipografia e experiência do usuário;
- Organizar e documentar o código do projeto;
- Integrar a aplicação mobile ao backend;
- Configurar o projeto para geração do aplicativo Android;
- Gerar o build final em formato **APK utilizando Expo EAS Build**.

---

## ⚙️ Funcionalidades

A aplicação mobile contempla os principais fluxos do FordCare Intelligence.

### 🔐 Autenticação

Permite o acesso do usuário à aplicação através do fluxo de login integrado ao backend.

### 📊 Dashboard

Apresenta uma visão geral das informações e indicadores relevantes da solução.

### 👥 Clientes

Permite consultar os clientes disponíveis na plataforma.

### 🔎 Detalhes do Cliente

Apresenta informações específicas do cliente selecionado para auxiliar no acompanhamento do relacionamento e pós-venda.

### 📋 Leads

Permite visualizar e acompanhar os leads registrados na plataforma.

### ➕ Cadastro de Lead

Disponibiliza um fluxo para criação de novos leads diretamente pelo aplicativo.

### 🤖 IA FordCare

Área dedicada aos recursos inteligentes do FordCare Intelligence, utilizando dados como apoio às análises da solução.

---

## 🛠️ Tecnologias Utilizadas

### Mobile

- React Native
- Expo SDK 57
- Expo Router
- TypeScript
- Axios
- React Native Chart Kit

### Backend

- Java
- Spring Boot
- API REST
- JWT
- RBAC
- Banco de dados

### Infraestrutura e DevOps

- Expo EAS Build
- Render
- Git
- GitHub
- Google Drive para disponibilização do APK final

---

## 🏗️ Arquitetura da Solução

A aplicação mobile se comunica com o backend através de uma API REST utilizando HTTPS.

```text
┌────────────────────────────┐
│    FordCare Intelligence   │
│         Mobile App         │
│    React Native + Expo     │
└──────────────┬─────────────┘
               │
               │ HTTPS / REST
               ▼
┌────────────────────────────┐
│        FordCare API        │
│       Spring Boot          │
│       JWT / RBAC           │
└──────────────┬─────────────┘
               │
               ▼
┌────────────────────────────┐
│       Banco de Dados       │
└────────────────────────────┘
```

---

## 🌐 Integração com o Backend

A aplicação mobile está integrada à API publicada do FordCare Intelligence.

A URL utilizada pela aplicação é:

```text
https://fordcare-intelligence-mobile.onrender.com
```

No ambiente de desenvolvimento, ela é configurada através da variável:

```env
EXPO_PUBLIC_API_URL=https://fordcare-intelligence-mobile.onrender.com
```

A comunicação entre o aplicativo e a API é realizada através do **Axios**.

### ⚠️ Importante — Inicialização da API

A API do FordCare Intelligence está hospedada no **Render**. Dependendo do estado do serviço no momento do teste, a primeira requisição pode levar mais tempo enquanto a instância da aplicação é inicializada.

Caso o aplicativo demore para realizar o login ou carregar informações na primeira tentativa, recomendamos verificar primeiro se a API já está respondendo.

Para isso, abra no navegador:

**https://fordcare-intelligence-mobile.onrender.com**

Se o navegador ainda estiver aguardando uma resposta, aguarde a inicialização do serviço.

Quando o endereço retornar uma resposta do servidor, mesmo que seja uma resposta simples ou uma mensagem informando que não existe uma rota específica para `/`, isso indica que o servidor voltou a responder.

Após isso, retorne ao aplicativo e tente novamente.

> **Observação:** essa demora pode ocorrer principalmente no primeiro acesso após um período sem utilização. Depois que a API estiver ativa, as requisições seguintes tendem a responder normalmente.

---

## 📂 Estrutura Mobile

A aplicação utiliza o **Expo Router** para organização das rotas e navegação.

```text
fordcare-frontend/
│
├── app/
│   ├── _layout.tsx
│   ├── index.tsx
│   ├── login.tsx
│   ├── dashboard.tsx
│   ├── customers.tsx
│   ├── customer-detail.tsx
│   ├── leads.tsx
│   ├── create-lead.tsx
│   └── ai.tsx
│
├── assets/
├── components/
├── services/
├── app.json
├── eas.json
├── package.json
└── README.md
```

---

## ▶️ Executando o Projeto

### Pré-requisitos

Para executar o projeto em ambiente de desenvolvimento é necessário possuir:

- Node.js
- npm
- Git

### 1. Instalar as dependências

Dentro da pasta do frontend:

```bash
npm install
```

### 2. Configurar a API

Crie ou configure o arquivo `.env`:

```env
EXPO_PUBLIC_API_URL=https://fordcare-intelligence-mobile.onrender.com
```

### 3. Iniciar a aplicação

```bash
npx expo start
```

---

## 📦 Build Android — APK

A versão final Android do **FordCare Intelligence** foi gerada utilizando o **Expo EAS Build**.

O projeto possui o perfil `preview` configurado no arquivo `eas.json` para geração do aplicativo no formato APK.

Para realizar um novo build:

```bash
npx eas-cli@latest build --platform android --profile preview
```

O build final da Sprint 3 foi **concluído com sucesso**, resultando na geração do aplicativo Android em formato `.apk`.

### 📲 Download do APK

Devido ao tamanho do arquivo, o APK final não está armazenado diretamente neste repositório e também ultrapassa o limite de envio da plataforma utilizada para a entrega.

O arquivo **FordCare-Intelligence.apk** está disponível através do Google Drive:

👉 **[BAIXAR APK — FordCare Intelligence](https://drive.google.com/drive/folders/17PA50zWbjAYjHHYaZttvEttgOb_z91ED?usp=sharing)**

> O link direciona para a pasta do Google Drive contendo o APK final da aplicação Android desenvolvido para a Sprint 3.

---

## ✅ Validações Realizadas

Durante a preparação da versão final foram realizadas validações da configuração do projeto e das dependências.

### Expo Doctor

O projeto foi validado através do Expo Doctor:

```text
21/21 checks passed.
No issues detected!
```

### Bundle Android

Também foi validada a geração do bundle da aplicação para Android:

```bash
npx expo export --platform android
```

O processo de bundle foi concluído corretamente.

### EAS Build

O build final Android foi realizado através do **Expo EAS Build**.

Como resultado, foi gerado com sucesso o arquivo instalável:

```text
FordCare-Intelligence.apk
```

---

## 🔒 Segurança

A aplicação utiliza mecanismos de segurança integrados ao backend do FordCare Intelligence, incluindo:

- Autenticação baseada em JWT;
- Controle de acesso baseado em permissões;
- Comunicação através de HTTPS;
- Proteção das rotas da API;
- Validação das requisições;
- Configuração da URL da API através de variável de ambiente.

---

## 📋 Atendimento aos Requisitos da Sprint 3

| Requisito | Status |
|---|---|
| Aplicação mobile final | ✅ |
| Fluxos do FordCare Intelligence | ✅ |
| Identidade visual consolidada | ✅ |
| Código organizado | ✅ |
| README completo | ✅ |
| Integração com backend | ✅ |
| Configuração Android | ✅ |
| Expo EAS Build | ✅ |
| Build final em APK | ✅ |
| APK disponibilizado para download | ✅ |

---

## 📲 APK Final

O APK final da aplicação foi disponibilizado externamente devido ao tamanho do arquivo.

👉 **[BAIXAR FORDCARE INTELLIGENCE — APK](https://drive.google.com/drive/folders/17PA50zWbjAYjHHYaZttvEttgOb_z91ED?usp=sharing)**

**Arquivo:** `FordCare-Intelligence.apk`  
**Plataforma:** Android  
**Formato:** APK  
**Build:** Expo EAS Build

---

## 🚀 Resultado Final

A Sprint 3 consolida a aplicação mobile do **FordCare Intelligence** como parte da solução desenvolvida para o Challenge Ford.

O aplicativo integra os principais fluxos da solução em uma experiência mobile, permitindo o acesso a clientes, leads, indicadores e recursos inteligentes conectados ao backend do FordCare Intelligence.

Como resultado final da Sprint, a versão Android foi compilada através do **Expo EAS Build** e o APK final está disponível para download através do Google Drive.

👉 **[Acessar o APK do FordCare Intelligence](https://drive.google.com/drive/folders/17PA50zWbjAYjHHYaZttvEttgOb_z91ED?usp=sharing)**

---

# 📷 Demonstração Visual

# 📱 Tela de Login 

<img width="120" alt="WhatsApp Image 2026-05-24 at 21 00 00" src="https://github.com/user-attachments/assets/bdd312ef-fe71-464d-9c22-1ac48b0be790" />


---

# 📊 Dashboard Executivo

<img width="120" alt="WhatsApp Image 2026-05-24 at 20 59 59 (1)" src="https://github.com/user-attachments/assets/ade45d93-9b29-4b1d-b125-165798737b0b" />


---

# 👥 Gestão de Clientes

<img width="120" alt="WhatsApp Image 2026-05-24 at 20 59 58 (2)" src="https://github.com/user-attachments/assets/b8bb3ecc-e1cd-4251-8e57-3bec488b5c37" />


---

# 📄 Detalhe do Cliente

<img width="120" alt="WhatsApp Image 2026-05-24 at 20 59 58 (1)" src="https://github.com/user-attachments/assets/638c9d63-b987-4325-9699-3cabca1d76cb" />


---

# 🤖 IA Preditiva

<img width="120" alt="WhatsApp Image 2026-05-24 at 20 59 57" src="https://github.com/user-attachments/assets/a2eaa4d7-e934-4f98-83a1-ae2674dd17ba" />


---

# 📈 Gestão de Leads

<img width="120" alt="WhatsApp Image 2026-05-24 at 20 59 57 (1)" src="https://github.com/user-attachments/assets/79481873-f692-40cb-ac9a-3039dd658816" />

---

# 📚 Swagger / APIs REST

<img width="1080" alt="Captura de tela 2026-05-24 210558" src="https://github.com/user-attachments/assets/a5b43b7f-c9bc-4503-9e77-948778fe4d23" />


---

# 🎥 Demonstração em Vídeo

[Clique aqui para acessar o vídeo de demonstração do aplicativo](https://drive.google.com/file/d/1WD-UlHRWJlGkXgsY7aqlc03sTucWAggk/view?usp=drive_link)



---

## 👨‍💻 Equipe

**Luan Orlandelli Ramos**  
RM 554747

**Jorge Luiz Silva Santos**  
RM 554418

**Arthur Bobadilla Franchi**  
RM 555056

---

### FIAP — Engenharia de Software

**Challenge Ford 2026 — FordCare Intelligence**
