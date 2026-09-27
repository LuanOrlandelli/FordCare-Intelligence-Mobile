# FordCare Intelligence

> Challenge Ford 2026 — FIAP  
> Solução digital voltada ao pós-venda, retenção e relacionamento com clientes Ford.

## Sobre o projeto

O **FordCare Intelligence** é uma solução desenvolvida para o Challenge 2026 da FIAP em parceria com a Ford.

O projeto integra uma aplicação mobile, uma API REST, banco de dados, autenticação e autorização, recursos de segurança, observabilidade e automação de verificações por meio de uma pipeline DevSecOps.

A proposta é apoiar as operações de pós-venda e retenção, permitindo o acompanhamento de clientes, leads, recomendações e informações relevantes para tomada de decisão.

---

## Integrantes

- **Luan Orlandelli Ramos** — RM 554747
- **Jorge Luiz Silva Santos** — RM 554418
- **Arthur Bobadilla Franchi** — RM 555056

---

# Sprint 3 — Cybersecurity

A Sprint 3 de Cybersecurity foi desenvolvida com foco na aplicação prática de segurança durante todo o ciclo de desenvolvimento do FordCare Intelligence.

Foram trabalhados quatro pilares principais:

1. **Pipeline DevSecOps Integrado**
2. **Segurança em Código e Infraestrutura**
3. **Observabilidade, Monitoramento e Resposta**
4. **Compliance, Riscos e Segurança Contínua**

## Documentação principal

A documentação completa da entrega está disponível em:

### [Cybersecurity — Sprint 3](./fordcare-api/docs/security/CYBERSECURITY_SPRINT3.md)

O documento apresenta detalhadamente a arquitetura de segurança, implementações realizadas, pipeline DevSecOps, observabilidade, modelagem de ameaças, compliance, backup, recuperação e evidências da Sprint.

---

# Arquitetura

A solução é composta principalmente por:

```text
React Native / Expo
        │
        │ REST + JWT
        ▼
Spring Boot API
        │
        ├── Spring Security
        ├── JWT + RBAC
        ├── Rate Limiting
        ├── Audit Logs
        │
        ▼
   PostgreSQL
        │
        └── Flyway
```

A camada de observabilidade utiliza:

```text
Spring Boot API
      │
      ▼
Actuator / Micrometer
      │
      ▼
Prometheus
      │
      ▼
Grafana
```

---

# Tecnologias

## Backend

- Java 21
- Spring Boot
- Spring Security
- Spring Data JPA
- Bean Validation
- PostgreSQL
- Flyway
- JWT
- Bucket4j
- Spring Boot Actuator
- Micrometer
- Maven

## Frontend / Mobile

- React Native
- Expo
- Expo Router
- Axios
- Expo SecureStore

## Infraestrutura e Segurança

- Docker
- Docker Compose
- GitHub Actions
- Semgrep
- OWASP Dependency-Check
- Gitleaks
- Trivy
- Prometheus
- Grafana

---

# Segurança implementada

Entre os principais controles implementados estão:

- autenticação baseada em JWT;
- controle de acesso baseado em papéis (RBAC);
- perfis `ADMIN`, `ANALYST` e `DEALER_MANAGER`;
- armazenamento seguro do token no mobile com Expo SecureStore;
- BCrypt para proteção de senhas;
- validação de entradas;
- mitigação de SQL Injection por meio de persistência parametrizada;
- rate limiting;
- tratamento seguro de erros;
- externalização de secrets;
- proteção de arquivos `.env`;
- auditoria de eventos de segurança;
- anonimização de clientes;
- monitoramento e métricas;
- alertas;
- análise de vulnerabilidades;
- backup e recuperação;
- Threat Modeling utilizando STRIDE.

---

# Pipeline DevSecOps

O projeto possui pipeline automatizada utilizando **GitHub Actions**.

Fluxo principal:

```text
Código
  │
  ▼
GitHub
  │
  ├── Build + Testes
  ├── SAST — Semgrep
  ├── SCA — OWASP Dependency-Check
  ├── Secret Scanning — Gitleaks
  └── Docker Build
           │
           ▼
      Trivy Scan
           │
           ▼
      Security Gate
```

Na validação final da Sprint, os jobs obrigatórios apresentaram:

```text
Build e Testes                    PASS
SAST — Semgrep                    PASS
SCA — OWASP Dependency-Check      PASS
Secret Scanning — Gitleaks        PASS
Container Security — Trivy        PASS
Security Gate                     PASS
```

---

# Testes e validações

O backend possui testes automatizados para funcionalidades e controles de segurança.

Entre os cenários validados estão:

- inicialização do contexto Spring;
- geração e validação de JWT;
- acesso sem token retornando HTTP 401;
- acesso autorizado por perfil;
- acesso proibido retornando HTTP 403;
- regras de autorização em endpoints protegidos.

A execução validada do backend apresentou:

```text
16 testes
0 failures
0 errors
BUILD SUCCESS
```

O frontend também foi validado com:

```text
Expo Doctor
18/18 checks passed
No issues detected
```

e:

```text
ESLint
0 errors
```

---

# Observabilidade

A aplicação possui uma camada de observabilidade baseada em:

- Spring Boot Actuator;
- Micrometer;
- Prometheus;
- Grafana.

O Prometheus coleta métricas da API e o Grafana disponibiliza o dashboard:

**FordCare Intelligence — Security & Observability**

Durante os testes, o target da API foi validado como:

```text
fordcare-api
UP
```

e a consulta:

```text
up{job="fordcare-api"}
```

retornou:

```text
1
```

Também foram configurados alertas para:

- indisponibilidade da API;
- crescimento da taxa de erros HTTP 5xx;
- consumo elevado de memória JVM.

---

# Estrutura do repositório

```text
FordCareIntelligence/
│
├── .github/
│   └── workflows/
│       └── security-ci.yml
│
├── fordcare-api/
│   ├── docs/
│   │   └── security/
│   ├── monitoring/
│   ├── scripts/
│   ├── src/
│   ├── Dockerfile
│   ├── docker-compose.yml
│   └── pom.xml
│
├── fordcare-frontend/
│   ├── app/
│   ├── assets/
│   ├── src/
│   ├── app.json
│   └── package.json
│
└── README.md
```

---

# Documentação de Segurança

A documentação técnica de Cybersecurity está organizada em:

| Documento | Descrição |
|---|---|
| [CYBERSECURITY_SPRINT3.md](./fordcare-api/docs/security/CYBERSECURITY_SPRINT3.md) | Documento principal da Sprint 3 |
| [SECURITY_CHECKLIST.md](./fordcare-api/docs/security/SECURITY_CHECKLIST.md) | Checklist dos controles implementados |
| [THREAT_MODEL.md](./fordcare-api/docs/security/THREAT_MODEL.md) | Modelagem de ameaças utilizando STRIDE |
| [COMPLIANCE.md](./fordcare-api/docs/security/COMPLIANCE.md) | OWASP ASVS, API Security, Mobile Security e LGPD |
| [INCIDENT_RESPONSE.md](./fordcare-api/docs/security/INCIDENT_RESPONSE.md) | Processo de resposta a incidentes |
| [BACKUP_RECOVERY.md](./fordcare-api/docs/security/BACKUP_RECOVERY.md) | Estratégia e testes de backup e recuperação |
| [CONTINUOUS_SECURITY.md](./fordcare-api/docs/security/CONTINUOUS_SECURITY.md) | Estratégia de segurança contínua |

---

# Backup e recuperação

O projeto possui scripts para backup e recuperação do PostgreSQL:

```text
fordcare-api/scripts/backup-db.ps1
fordcare-api/scripts/restore-db.ps1
```

O processo foi validado por meio da criação de um backup real e posterior restauração em um banco isolado de teste.

Como objetivos acadêmicos foram definidos:

```text
RPO: 24 horas
RTO: 4 horas
```

---

# Compliance e gestão de riscos

O projeto utiliza como referências:

- OWASP ASVS;
- OWASP API Security Top 10;
- OWASP Mobile Top 10;
- LGPD;
- STRIDE para modelagem de ameaças.

Os controles implementados apoiam a proteção dos dados tratados pelo sistema, mas não representam, isoladamente, uma declaração de conformidade jurídica integral com a LGPD.

---

# Execução local

## Backend

O backend utiliza variáveis de ambiente para informações sensíveis.

Exemplo de configuração disponível em:

```text
fordcare-api/.env.example
```

As principais configurações incluem:

```text
SPRING_DATASOURCE_URL
SPRING_DATASOURCE_USERNAME
SPRING_DATASOURCE_PASSWORD
JWT_SECRET
SSL_KEYSTORE_PASSWORD
```

As credenciais reais **não devem ser versionadas**.

Para executar os testes:

```bash
cd fordcare-api
./mvnw clean test
```

No Windows:

```powershell
cd fordcare-api
.\mvnw.cmd clean test
```

---

## Frontend

Entre na pasta:

```bash
cd fordcare-frontend
```

Instale as dependências:

```bash
npm install
```

Crie o `.env` local a partir do `.env.example` e configure:

```env
EXPO_PUBLIC_API_URL=http://localhost:8080
```

Execute:

```bash
npx expo start
```

Para abrir a versão web, pressione:

```text
w
```

O arquivo `.env` real não deve ser enviado ao repositório.

---

# Observações de produção

O ambiente atual foi desenvolvido e validado para fins acadêmicos.

Em um ambiente produtivo devem ser adotadas medidas adicionais, incluindo:

- HTTPS com certificado válido;
- cofre de secrets;
- rotação formal de credenciais;
- proteção das interfaces Prometheus e Grafana;
- restrição da porta de gerenciamento;
- política formal de retenção de logs;
- armazenamento externo e criptografado de backups;
- políticas de rede e firewall;
- monitoramento contínuo;
- testes periódicos de recuperação.

---

# FordCare Intelligence

**FIAP — Engenharia de Software**  
**Challenge Ford 2026**

Desenvolvido por:

**Luan Orlandelli Ramos • Jorge Luiz Silva Santos • Arthur Bobadilla Franchi**