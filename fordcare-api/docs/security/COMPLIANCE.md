# FordCare Intelligence — Compliance e Referenciais de Segurança

## 1. Objetivo

Este documento apresenta o mapeamento dos controles de segurança do
FordCare Intelligence com referenciais reconhecidos de segurança e
privacidade.

Foram considerados:

- OWASP ASVS;
- OWASP API Security Top 10;
- OWASP Mobile Top 10;
- Lei Geral de Proteção de Dados Pessoais (LGPD).

O objetivo não é declarar certificação formal ou conformidade integral,
mas demonstrar como os controles implementados no projeto apoiam boas
práticas de segurança e proteção de dados.

---

# 2. OWASP ASVS

O OWASP Application Security Verification Standard (ASVS) fornece
requisitos para verificação de controles técnicos de segurança em
aplicações.

No FordCare Intelligence, foram adotados controles relacionados
principalmente a autenticação, autorização, validação, proteção de dados,
logging e configuração segura.

## Autenticação

Controles implementados:

- autenticação por email e senha;
- armazenamento de senha utilizando BCrypt;
- respostas genéricas para credenciais inválidas;
- JWT assinado;
- expiração do token;
- chave JWT externalizada;
- registro de tentativas de autenticação;
- rate limiting.

Status: IMPLEMENTADO.

---

## Gerenciamento de sessão e tokens

Controles implementados:

- arquitetura stateless;
- autenticação utilizando Bearer Token;
- validação da assinatura do JWT;
- validação da expiração;
- token armazenado com Expo SecureStore no ambiente mobile;
- ausência de sessão HTTP tradicional no backend.

Limitação atual:

O projeto não implementa refresh token ou mecanismo centralizado de
revogação antecipada de JWT.

Status: PARCIALMENTE IMPLEMENTADO.

---

## Controle de acesso

Controles implementados:

- RBAC com Spring Security;
- perfis ADMIN, ANALYST e DEALER_MANAGER;
- autorização definida por grupos de endpoints;
- resposta HTTP 403 para acessos sem permissão;
- auditoria de ACCESS_DENIED;
- testes automatizados de autorização.

Status: IMPLEMENTADO.

---

## Validação e tratamento de entradas

Controles implementados:

- Bean Validation;
- validação de DTOs;
- limites para tamanho de payload;
- persistência através de Spring Data JPA;
- tratamento centralizado de exceções;
- respostas de erro sem stack trace para o cliente.

Status: IMPLEMENTADO.

---

## Criptografia e proteção de secrets

Controles implementados:

- BCrypt para senhas;
- assinatura criptográfica do JWT;
- secrets obtidos por variáveis de ambiente;
- .env ignorado pelo Git;
- arquivos de chaves e certificados excluídos do contexto Docker;
- keystore externalizado;
- suporte a HTTPS/TLS.

Observação:

No ambiente local de desenvolvimento o HTTPS direto na aplicação está
desabilitado. Em produção, TLS deve ser habilitado na aplicação ou
terminado em infraestrutura segura, como reverse proxy ou gateway.

Status: IMPLEMENTADO COM CONFIGURAÇÃO DE PRODUÇÃO PENDENTE.

---

## Logging e auditoria

Controles implementados:

- logs da aplicação;
- registros persistentes de auditoria;
- LOGIN_SUCCESS;
- LOGIN_FAILED;
- UNAUTHORIZED_ACCESS;
- ACCESS_DENIED;
- RATE_LIMIT_EXCEEDED;
- CUSTOMER_ANONYMIZED;
- data/hora;
- usuário;
- endpoint;
- endereço IP;
- monitoramento de WARN e ERROR.

Status: IMPLEMENTADO.

---

## Configuração e operação segura

Controles implementados:

- Docker multi-stage;
- container executado sem usuário root;
- no-new-privileges;
- health check;
- PostgreSQL sem porta publicada externamente;
- Actuator em porta de gerenciamento separada;
- Prometheus;
- Grafana;
- alertas;
- pipeline DevSecOps.

Status: IMPLEMENTADO.

---

# 3. OWASP API Security Top 10

A API FordCare utiliza diferentes controles para reduzir riscos comuns
em APIs REST.

## Broken Object Level Authorization

Risco:

Usuários acessarem recursos que não deveriam estar disponíveis para
seu perfil ou contexto.

Controles:

- autenticação obrigatória;
- RBAC;
- separação de permissões por endpoint;
- testes de autorização.

Melhoria contínua:

As verificações de propriedade e escopo dos objetos devem continuar
sendo avaliadas individualmente sempre que novos endpoints forem criados.

---

## Broken Authentication

Controles:

- BCrypt;
- JWT assinado;
- expiração de token;
- chave JWT externa;
- resposta genérica para login inválido;
- rate limiting;
- auditoria de tentativas de autenticação.

---

## Broken Object Property Level Authorization

Controles:

- utilização de DTOs;
- validação de entrada;
- service layer;
- regras de autorização.

Melhoria contínua:

Evitar exposição ou alteração automática de propriedades que não devem
ser controladas diretamente pelo cliente.

---

## Unrestricted Resource Consumption

Controles:

- rate limiting;
- limite de payload;
- monitoramento de CPU;
- monitoramento de memória;
- monitoramento de requisições;
- health checks;
- alertas.

---

## Broken Function Level Authorization

Controles:

- RBAC;
- Spring Security;
- perfis distintos;
- HTTP 403;
- auditoria ACCESS_DENIED;
- testes de integração.

---

## Unrestricted Access to Sensitive Business Flows

Controles:

- autenticação;
- autorização;
- rate limiting;
- auditoria;
- monitoramento.

Operações críticas devem continuar sendo avaliadas individualmente de
acordo com sua relevância para o negócio.

---

## Server Side Request Forgery — SSRF

A arquitetura atual não possui funcionalidade genérica que permita ao
cliente informar uma URL para que o backend realize requisições arbitrárias.

Status atual:

Risco reduzido pela arquitetura existente.

Caso integrações externas desse tipo sejam adicionadas, deverão ser
utilizados allowlists, validação de destino e restrições de rede.

---

## Security Misconfiguration

Controles:

- configuração centralizada;
- secrets fora do código;
- tratamento seguro de erros;
- Actuator separado;
- health sem detalhes;
- CORS configurado;
- Docker hardening;
- Security Gate.

---

## Improper Inventory Management

Controles:

- documentação OpenAPI/Swagger;
- endpoints centralizados;
- versionamento do código;
- pipeline CI/CD.

Melhoria futura:

Adotar versionamento explícito de API caso múltiplas versões sejam
mantidas simultaneamente.

---

## Unsafe Consumption of APIs

Integrações externas devem ser consideradas não confiáveis por padrão.

Controles necessários para futuras integrações:

- validação de respostas;
- timeouts;
- TLS;
- autenticação;
- tratamento de falhas;
- limites de tamanho;
- dependências atualizadas.

---

# 4. OWASP Mobile Top 10

O frontend mobile do FordCare Intelligence utiliza React Native com Expo.

## Armazenamento seguro

O JWT é armazenado utilizando Expo SecureStore nos ambientes Android
e iOS.

Isso evita utilizar armazenamento comum para o token no dispositivo
mobile.

Observação:

A versão web possui comportamento diferente e não recebe as mesmas
garantias de armazenamento seguro fornecidas pelo SecureStore nativo.

---

## Comunicação segura

A aplicação utiliza uma URL de API configurável através de:

EXPO_PUBLIC_API_URL

A URL não contém credenciais ou secrets.

Em produção, a comunicação deve utilizar HTTPS/TLS.

---

## Autenticação e autorização

A autorização não depende somente da aplicação mobile.

O backend realiza novamente:

- validação do JWT;
- validação de assinatura;
- validação de expiração;
- verificação do perfil do usuário.

Portanto, modificar a interface mobile não é suficiente para obter
permissões adicionais no backend.

---

## Secrets no aplicativo

Secrets de backend não são armazenados no aplicativo mobile.

Variáveis EXPO_PUBLIC devem conter somente informações públicas de
configuração, pois podem fazer parte do bundle da aplicação.

---

## Dependências

Dependências mobile devem ser revisadas e atualizadas continuamente.

Auditorias de dependências devem fazer parte do processo de segurança
contínua do projeto.

---

# 5. LGPD

O FordCare Intelligence trabalha com informações relacionadas a clientes
e, portanto, possui requisitos relevantes de proteção de dados pessoais.

Os controles descritos nesta seção representam medidas técnicas de apoio
à proteção de dados e não constituem declaração de conformidade jurídica
integral.

---

## Controle de acesso

O acesso aos dados é limitado de acordo com o perfil do usuário através
de RBAC.

Perfis diferentes possuem acesso a conjuntos diferentes de endpoints.

---

## Segurança dos dados

Medidas implementadas:

- autenticação;
- autorização;
- BCrypt;
- JWT;
- secrets externalizados;
- suporte a TLS;
- logs de segurança;
- auditoria;
- monitoramento;
- rate limiting;
- hardening de containers.

---

## Anonimização

A aplicação possui operação específica para anonimização de cliente.

Endpoint:

PUT /privacy/customers/{id}/anonymize

A ação também gera registro de auditoria:

CUSTOMER_ANONYMIZED

Esse mecanismo apoia processos internos relacionados à redução da
identificabilidade de dados pessoais quando aplicável.

---

## Rastreabilidade

Eventos relevantes são registrados através da estrutura de auditoria.

Os registros permitem identificar:

- ação;
- usuário;
- endpoint;
- endereço IP;
- data e hora.

---

## Minimização

A aplicação deve coletar e processar somente os dados necessários para
as funcionalidades e objetivos definidos pelo FordCare Intelligence.

Novos campos devem ser avaliados antes de sua inclusão.

---

## Retenção

Logs, auditorias, backups e dados pessoais não devem ser armazenados
indefinidamente sem necessidade.

Uma política de retenção deve definir:

- finalidade;
- período;
- forma de descarte;
- responsáveis;
- critérios legais e operacionais aplicáveis.

---

## Incidentes envolvendo dados pessoais

Caso um incidente de segurança envolva dados pessoais, além do processo
técnico definido no INCIDENT_RESPONSE.md, o impacto sobre os titulares
e as obrigações aplicáveis devem ser avaliados pelos responsáveis pela
privacidade e segurança da organização.

---

# 6. MQTT / IoT

O requisito de segurança também considera MQTT/TLS quando existir
comunicação com dispositivos IoT.

O FordCare Intelligence atualmente não possui:

- broker MQTT;
- dispositivos IoT;
- comunicação MQTT;
- telemetria veicular direta através de MQTT.

Portanto:

Status: NÃO APLICÁVEL À ARQUITETURA ATUAL.

Não foi criada uma implementação fictícia apenas para atender ao
requisito.

Caso MQTT seja incorporado futuramente, deverão ser considerados:

- MQTT sobre TLS;
- autenticação de clientes;
- autorização por tópico;
- certificados;
- rotação de credenciais;
- isolamento de rede;
- proteção do broker.

---

# 7. Resumo

| Referencial | Aplicação no FordCare |
|---|---|
| OWASP ASVS | Autenticação, autorização, validação, criptografia, logging e configuração |
| OWASP API Security Top 10 | Proteção dos endpoints e fluxos da API REST |
| OWASP Mobile Top 10 | SecureStore, autenticação no servidor, comunicação segura e proteção de secrets |
| LGPD | Controle de acesso, segurança, anonimização, rastreabilidade e retenção |
| MQTT/TLS | Não aplicável à arquitetura atual |

---

# 8. Segurança como processo contínuo

Os controles descritos neste documento devem ser revisados sempre que
houver alterações relevantes na arquitetura.

A segurança do FordCare Intelligence é tratada como parte do ciclo de
desenvolvimento, e não apenas como uma validação realizada ao final do
projeto.