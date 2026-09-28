# FordCare Intelligence

## Sprint 3 — Mobile Development and IoT

**FIAP — Engenharia de Software**

### Integrantes

- Luan Orlandelli Ramos — RM 554747
- Jorge Luiz Silva Santos — RM 554418
- Arthur Bobadilla Franchi — RM 555056

---

## Sobre o Projeto

O **FordCare Intelligence** é uma solução desenvolvida para o Challenge FIAP em parceria com a Ford, com foco no relacionamento e na fidelização de clientes no pós-venda.

A aplicação centraliza informações importantes sobre clientes, leads e indicadores, permitindo o acompanhamento das ações de relacionamento e oferecendo suporte à tomada de decisão por meio de dados e inteligência artificial.

Nesta Sprint 3, o foco foi consolidar a aplicação mobile como um produto final, garantindo funcionamento dos principais fluxos, integração com a API, identidade visual consistente e geração do aplicativo Android em formato APK.

---

## Objetivo da Aplicação Mobile

O aplicativo FordCare Intelligence permite que o usuário acompanhe e gerencie informações relacionadas ao processo de pós-venda diretamente pelo dispositivo móvel.

Entre os principais recursos estão:

- Autenticação de usuários;
- Dashboard com indicadores;
- Consulta de clientes;
- Visualização dos detalhes de clientes;
- Gerenciamento de leads;
- Cadastro de novos leads;
- Recursos relacionados à IA FordCare;
- Integração com a API do FordCare Intelligence;
- Navegação entre as funcionalidades através do Expo Router.

---

## Principais Telas e Fluxos

### Login

Tela responsável pela autenticação do usuário e acesso seguro à aplicação.

### Dashboard

Apresenta uma visão geral das informações e indicadores do FordCare Intelligence.

### Clientes

Permite visualizar os clientes cadastrados e acessar informações individuais de cada cliente.

### Detalhes do Cliente

Apresenta informações detalhadas do cliente selecionado, auxiliando no acompanhamento e nas ações de pós-venda.

### Leads

Permite consultar e acompanhar os leads existentes na plataforma.

### Novo Lead

Possibilita o cadastro de novos leads diretamente pelo aplicativo.

### IA FordCare

Área destinada às funcionalidades inteligentes do FordCare Intelligence, apoiando a análise das informações disponíveis na plataforma.

---

## Tecnologias Utilizadas

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
- Controle de acesso baseado em permissões
- Banco de dados

### Infraestrutura

- Render — hospedagem da API
- Expo EAS Build — geração do APK Android
- GitHub — versionamento do projeto

---

## Arquitetura

A solução utiliza uma arquitetura baseada na comunicação entre a aplicação mobile e uma API REST.

```text
┌──────────────────────────┐
│   FordCare Intelligence  │
│      Mobile App          │
│   React Native + Expo    │
└─────────────┬────────────┘
              │
              │ HTTPS / REST
              ▼
┌──────────────────────────┐
│      FordCare API        │
│      Spring Boot         │
│      JWT / RBAC          │
└─────────────┬────────────┘
              │
              ▼
┌──────────────────────────┐
│      Banco de Dados      │
└──────────────────────────┘
```

---

## Integração com a API

A aplicação mobile está integrada à API publicada do FordCare Intelligence.

A URL da API é configurada através da variável de ambiente:

```env
EXPO_PUBLIC_API_URL=https://fordcare-intelligence-mobile.onrender.com
```

A aplicação utiliza Axios para realizar a comunicação entre o aplicativo e o backend.

---

## Organização do Projeto Mobile

A estrutura principal da aplicação segue o padrão de roteamento do Expo Router:

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
├── package.json
├── app.json
├── eas.json
└── README.md
```

---

## Configuração do Ambiente

### Pré-requisitos

Para executar o projeto em ambiente de desenvolvimento:

- Node.js
- npm
- Expo
- Git

Clone o repositório e acesse a pasta do frontend.

Instale as dependências:

```bash
npm install
```

Configure o arquivo `.env`:

```env
EXPO_PUBLIC_API_URL=https://fordcare-intelligence-mobile.onrender.com
```

Execute o projeto:

```bash
npx expo start
```

---

## Build Android

Para a Sprint 3 foi configurado o **Expo EAS Build** para geração da versão Android da aplicação.

O perfil `preview` foi configurado para gerar diretamente um arquivo instalável no formato APK.

Para gerar o build:

```bash
npx eas-cli@latest build --platform android --profile preview
```

O processo realiza a preparação do projeto Android, compilação nativa e geração do artefato final.

---

## APK Final

A versão final da aplicação foi compilada através do **Expo EAS Build**.

Arquivo entregue:

```text
FordCare-Intelligence.apk
```

Formato:

```text
Android Package (.apk)
```

O APK é o artefato final instalável da aplicação Android e foi gerado a partir da versão final do projeto entregue nesta Sprint.

---

## Validações Realizadas

Antes da geração do APK final foram realizadas validações do projeto e das dependências.

O Expo Doctor apresentou:

```text
21/21 checks passed.
No issues detected.
```

Também foi validado o processo de bundle da aplicação para Android, garantindo a compilação do código JavaScript/TypeScript utilizado pelo aplicativo.

O build Android final foi concluído através do Expo EAS Build, resultando na geração do arquivo:

```text
FordCare-Intelligence.apk
```

---

## Requisitos da Sprint 3 Atendidos

A entrega contempla os principais objetivos definidos para Mobile Development and IoT:

- Aplicação mobile finalizada;
- Principais fluxos do desafio Ford implementados;
- Integração entre aplicação mobile e backend;
- Identidade visual consistente;
- Navegação organizada entre as telas;
- Código estruturado e organizado;
- README com documentação do projeto;
- Configuração para geração do aplicativo Android;
- Build realizado através do Expo EAS Build;
- APK final gerado para Android.

---

## Segurança

A aplicação utiliza mecanismos de segurança integrados ao backend do FordCare Intelligence, incluindo:

- Autenticação baseada em JWT;
- Controle de acesso;
- Comunicação com a API através de HTTPS;
- Proteção das rotas da aplicação;
- Tratamento das requisições realizadas pelo aplicativo.

Informações sensíveis e configurações de ambiente não são armazenadas diretamente no código-fonte da aplicação.

---

## Resultado Final

A Sprint 3 consolida o **FordCare Intelligence Mobile** como parte da solução desenvolvida para o Challenge Ford.

A aplicação conecta o ambiente mobile aos serviços do FordCare Intelligence, oferecendo acesso aos principais fluxos da solução e permitindo o acompanhamento de clientes, leads, indicadores e recursos inteligentes em uma interface preparada para dispositivos móveis.

O projeto é entregue juntamente com o **APK Android final**, permitindo a instalação da aplicação em dispositivos compatíveis.

---

## Equipe

**Luan Orlandelli Ramos**  
RM 554747

**Jorge Luiz Silva Santos**  
RM 554418

**Arthur Bobadilla Franchi**  
RM 555056

### FIAP — Engenharia de Software

**Challenge Ford — FordCare Intelligence — 2026**
