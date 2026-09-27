# FordCare Intelligence — Threat Model

## 1. Objetivo

Este documento apresenta a análise de ameaças da plataforma FordCare
Intelligence utilizando o modelo STRIDE.

O objetivo é identificar ameaças relacionadas à arquitetura da solução,
associar cada ameaça aos componentes afetados e documentar os controles
de segurança implementados para reduzir os riscos.

---

## 2. Escopo da análise

A análise considera os principais componentes da solução:

- aplicação mobile desenvolvida com React Native / Expo;
- API REST desenvolvida com Spring Boot;
- autenticação baseada em JWT;
- controle de acesso baseado em perfis (RBAC);
- banco de dados PostgreSQL;
- containers Docker;
- pipeline DevSecOps;
- Prometheus;
- Grafana;
- logs e registros de auditoria.

Principais perfis de acesso:

- ADMIN;
- ANALYST;
- DEALER_MANAGER.

---

## 3. Fluxo principal

Usuário
↓
Aplicação Mobile
↓
API REST FordCare
↓
Spring Security
↓
JWT + RBAC
↓
Service Layer
↓
PostgreSQL

Paralelamente:

API REST
↓
Actuator / Micrometer
↓
Prometheus
↓
Grafana

E durante o desenvolvimento:

Código-fonte
↓
Pipeline DevSecOps
↓
SAST + SCA + Secret Scanning + Container Security
↓
Security Gate

---

# 4. Análise STRIDE

## S — Spoofing

### Ameaça

Um atacante pode tentar se passar por um usuário legítimo utilizando
credenciais obtidas indevidamente ou um token de autenticação roubado.

### Componentes afetados

- endpoint de login;
- JWT;
- aplicação mobile;
- endpoints protegidos da API.

### Controles implementados

- autenticação com email e senha;
- armazenamento de senha utilizando BCrypt;
- JWT assinado;
- chave JWT externalizada por variável de ambiente;
- validação da assinatura e expiração do token;
- expiração do JWT em 2 horas;
- armazenamento do token utilizando Expo SecureStore no ambiente mobile;
- respostas genéricas para credenciais inválidas;
- rate limiting;
- registro de LOGIN_SUCCESS e LOGIN_FAILED.

### Risco residual

O comprometimento do dispositivo ou das credenciais do usuário ainda
pode permitir utilização indevida da sessão até a expiração do token.

---

## T — Tampering

### Ameaça

Um atacante pode tentar alterar requisições, parâmetros ou dados enviados
para a API com o objetivo de modificar informações de maneira não autorizada.

### Componentes afetados

- API REST;
- payloads HTTP;
- banco de dados;
- JWT.

### Controles implementados

- Bean Validation;
- validação de entradas;
- Spring Data JPA;
- consultas parametrizadas;
- assinatura criptográfica do JWT;
- RBAC;
- limites de tamanho para payloads;
- tratamento centralizado de exceções;
- suporte a HTTPS/TLS para produção.

### Risco residual

Falhas futuras de validação ou autorização em novos endpoints podem
introduzir possibilidades de alteração indevida.

---

## R — Repudiation

### Ameaça

Um usuário pode negar ter realizado determinada ação ou tentativa de acesso.

### Componentes afetados

- autenticação;
- endpoints protegidos;
- operações sobre dados;
- ações administrativas.

### Controles implementados

A aplicação possui registros persistentes de auditoria contendo:

- ação;
- usuário;
- endpoint;
- endereço IP;
- data e hora.

Eventos relevantes incluem:

- LOGIN_SUCCESS;
- LOGIN_FAILED;
- UNAUTHORIZED_ACCESS;
- ACCESS_DENIED;
- RATE_LIMIT_EXCEEDED;
- CUSTOMER_ANONYMIZED.

Também são produzidos logs operacionais da aplicação.

### Risco residual

Os registros precisam possuir política adequada de retenção, proteção
contra alteração e controle de acesso no ambiente de produção.

---

## I — Information Disclosure

### Ameaça

Dados pessoais, credenciais, tokens, informações internas ou detalhes
da infraestrutura podem ser expostos para usuários não autorizados.

### Componentes afetados

- banco de dados;
- API;
- JWT;
- logs;
- arquivos de configuração;
- aplicação mobile.

### Controles implementados

- secrets externalizados por variáveis de ambiente;
- arquivos .env ignorados pelo Git;
- certificados e chaves ignorados pelo Git e Docker;
- token armazenado no SecureStore no mobile;
- RBAC;
- tratamento de erros sem exposição de stack trace;
- health check sem detalhes internos;
- porta de gerenciamento separada;
- endpoint de anonimização de clientes;
- suporte a HTTPS/TLS;
- PostgreSQL sem porta publicada pelo Docker Compose.

### Risco residual

Logs e registros de auditoria podem conter informações operacionais ou
identificadores e precisam possuir acesso restrito e retenção controlada.

---

## D — Denial of Service

### Ameaça

Um atacante pode realizar grande quantidade de requisições com o objetivo
de degradar ou tornar a API indisponível.

### Componentes afetados

- API;
- autenticação;
- banco de dados;
- infraestrutura.

### Controles implementados

- rate limiting;
- limite de tamanho de requisição;
- health check;
- métricas de CPU e memória;
- monitoramento de erros HTTP;
- Prometheus;
- Grafana;
- alerta de indisponibilidade;
- alerta de memória JVM;
- monitoramento de conexões com o banco.

### Risco residual

Ataques distribuídos de grande escala exigiriam controles adicionais de
infraestrutura, como WAF, CDN, proteção DDoS e escalabilidade horizontal.

---

## E — Elevation of Privilege

### Ameaça

Um usuário autenticado pode tentar acessar funcionalidades destinadas a
outro perfil.

### Componentes afetados

- endpoints protegidos;
- JWT;
- regras de autorização.

### Controles implementados

RBAC através do Spring Security.

Exemplos:

- /insights/** → ADMIN e ANALYST;
- /customers/** → ADMIN, ANALYST e DEALER_MANAGER;
- /recommendations/** → ADMIN, ANALYST e DEALER_MANAGER;
- /leads/** → ADMIN e DEALER_MANAGER;
- /predictions/** → ADMIN e ANALYST.

Tentativas de acesso sem autorização geram HTTP 403 e evento
ACCESS_DENIED para auditoria.

Testes automatizados verificam cenários de acesso autorizado e negado.

### Risco residual

Novos endpoints precisam obrigatoriamente ser incluídos na política de
autorização e nos testes de segurança.

---

# 5. Matriz resumida STRIDE

| Categoria | Principal risco | Controle principal | Risco residual |
|---|---|---|---|
| Spoofing | Roubo de identidade | JWT, BCrypt, SecureStore, rate limiting | Credencial/dispositivo comprometido |
| Tampering | Alteração de dados | Validation, JPA, RBAC, JWT | Falhas futuras de validação |
| Repudiation | Negação de ações | Audit logs e logs de segurança | Proteção e retenção dos logs |
| Information Disclosure | Vazamento de informações | Secrets externos, RBAC, TLS, anonimização | Dados presentes em logs |
| Denial of Service | Indisponibilidade | Rate limiting, métricas e alertas | DDoS distribuído |
| Elevation of Privilege | Acesso acima do perfil | RBAC + testes + auditoria | Novos endpoints mal configurados |

---

# 6. Riscos relacionados ao DevSecOps

Além das ameaças STRIDE, foram considerados riscos relacionados ao ciclo
de desenvolvimento.

## Código vulnerável

Controle:

SAST utilizando Semgrep.

## Dependências vulneráveis

Controle:

SCA utilizando OWASP Dependency-Check.

## Secrets enviados ao repositório

Controle:

Gitleaks, variáveis de ambiente, .gitignore e .dockerignore.

## Vulnerabilidades na imagem Docker

Controle:

Trivy.

## Execução privilegiada de container

Controle:

usuário não-root e no-new-privileges.

## Falha de qualidade ou segurança antes da integração

Controle:

testes automatizados e Security Gate no pipeline CI/CD.

---

# 7. Revisão contínua de riscos

O Threat Model deve ser revisado quando ocorrer:

- criação de novos endpoints;
- inclusão de novos perfis;
- alteração da autenticação;
- inclusão de novos serviços;
- alteração da infraestrutura;
- inclusão de novas integrações;
- identificação de vulnerabilidade relevante;
- ocorrência de incidente de segurança.

A análise de riscos, portanto, faz parte do ciclo contínuo de desenvolvimento
do FordCare Intelligence.