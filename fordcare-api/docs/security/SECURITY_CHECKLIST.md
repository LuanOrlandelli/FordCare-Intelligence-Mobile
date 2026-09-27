# FordCare Intelligence — Security Checklist

## 1. Objetivo

Este documento consolida os controles de segurança implementados e validados no FordCare Intelligence e relaciona os requisitos da Sprint 3 às respectivas implementações e evidências técnicas.

Status utilizados:

- **IMPLEMENTADO** — controle presente no projeto;
- **VALIDADO** — controle executado e comprovado durante os testes;
- **DOCUMENTADO** — processo formalizado na documentação do projeto;
- **PARCIAL** — depende do ambiente de implantação;
- **NÃO APLICÁVEL** — requisito não pertence à arquitetura atual.

---

# 2. Pipeline DevSecOps Integrado

| Requisito | Implementação | Status |
|---|---|---|
| CI/CD | GitHub Actions | VALIDADO |
| Build automatizado | Maven | VALIDADO |
| Testes automatizados | Maven Test | VALIDADO |
| SAST | Semgrep | VALIDADO |
| SCA | OWASP Dependency-Check | VALIDADO |
| Secret Scanning | Gitleaks | VALIDADO |
| Container Security | Trivy | VALIDADO |
| Security Gate | Job final do workflow | VALIDADO |
| Diagrama CI/CD | CYBERSECURITY_SPRINT3.md | DOCUMENTADO |
| Execução real do pipeline | GitHub Actions | VALIDADO |

Arquivo principal:

`.github/workflows/security-ci.yml`

## Resultado final do pipeline

A execução final do pipeline foi concluída com sucesso:

- Build e Testes — aprovado;
- SAST / Semgrep — aprovado;
- SCA / OWASP Dependency-Check — aprovado;
- Secret Scanning / Gitleaks — aprovado;
- Container Security / Trivy — aprovado;
- Security Gate — aprovado.

O Gitleaks apresentou o resultado:

`No leaks detected`

Durante o processo de segurança, o Trivy identificou vulnerabilidades nas dependências da aplicação. As dependências foram revisadas e atualizadas, e a execução final do scanner foi aprovada pelo Security Gate.

---

# 3. Segurança de Código

| Controle | Implementação | Status |
|---|---|---|
| Validação de entrada | Bean Validation | IMPLEMENTADO |
| Limite de payload | Spring/Tomcat | IMPLEMENTADO |
| Tratamento seguro de erros | GlobalExceptionHandler | IMPLEMENTADO |
| Proteção contra SQL Injection | JPA / queries parametrizadas | IMPLEMENTADO |
| Senhas protegidas | BCrypt | IMPLEMENTADO |
| JWT assinado | JJWT | IMPLEMENTADO |
| Expiração JWT | 2 horas | IMPLEMENTADO |
| Chave JWT externa | Variável JWT_SECRET | IMPLEMENTADO |
| Validação mínima da chave JWT | JwtService | VALIDADO |
| Rate limiting | Bucket4j | IMPLEMENTADO |
| CORS | Spring Security | IMPLEMENTADO |
| HTTPS/TLS | Suportado e externalizado | PARCIAL |
| MQTT/TLS | Arquitetura não utiliza MQTT/IoT | NÃO APLICÁVEL |

O ambiente local utiliza HTTP para desenvolvimento e testes.

O keystore foi retirado do código-fonte e sua localização e senha são externalizadas por variáveis de ambiente. A arquitetura permite ativação de TLS em ambiente apropriado de produção.

---

# 4. Autenticação e Controle de Acesso

| Controle | Status |
|---|---|
| Login | IMPLEMENTADO |
| JWT Bearer | IMPLEMENTADO |
| Arquitetura stateless | IMPLEMENTADO |
| ADMIN | IMPLEMENTADO |
| ANALYST | IMPLEMENTADO |
| DEALER_MANAGER | IMPLEMENTADO |
| RBAC por endpoint | VALIDADO |
| HTTP 401 para acesso não autenticado | VALIDADO |
| HTTP 403 para acesso não autorizado | VALIDADO |
| Auditoria de acesso negado | IMPLEMENTADO |
| Testes de autorização | VALIDADO |
| Refresh Token | MELHORIA FUTURA |
| Revogação antecipada de JWT | MELHORIA FUTURA |

Os testes automatizados validam cenários de acesso aos endpoints protegidos para diferentes perfis.

---

# 5. Segurança Mobile

| Controle | Implementação | Status |
|---|---|---|
| Token em armazenamento seguro | Expo SecureStore | IMPLEMENTADO |
| Remoção de token após HTTP 401 | Axios interceptor | IMPLEMENTADO |
| URL da API configurável | EXPO_PUBLIC_API_URL | IMPLEMENTADO |
| IP local hardcoded | Removido | IMPLEMENTADO |
| Autorização validada no backend | Spring Security | IMPLEMENTADO |
| Secrets privados no bundle mobile | Não utilizados | IMPLEMENTADO |
| HTTPS em produção | Requisito de implantação | PARCIAL |

Expo SecureStore é utilizado nos ambientes mobile nativos.

A versão web possui características diferentes de armazenamento e deve seguir controles adequados ao ambiente web.

---

# 6. Secrets e Credenciais

| Controle | Status |
|---|---|
| Senha do banco fora do código | IMPLEMENTADO |
| JWT secret fora do código | IMPLEMENTADO |
| Senha do keystore fora do código | IMPLEMENTADO |
| Keystore fora do código-fonte | IMPLEMENTADO |
| `.env` ignorado pelo Git | IMPLEMENTADO |
| Certificados ignorados pelo Git | IMPLEMENTADO |
| Secrets excluídos do Docker build context | IMPLEMENTADO |
| Secret Scanning com Gitleaks | VALIDADO |
| Pipeline sem vazamento detectado | VALIDADO |

Secrets ou credenciais reais utilizados durante o desenvolvimento devem ser rotacionados antes da utilização em ambiente produtivo.

---

# 7. Segurança de Containers e Infraestrutura

| Controle | Status |
|---|---|
| Multi-stage Docker build | IMPLEMENTADO |
| Runtime separado do build | IMPLEMENTADO |
| Usuário não-root | IMPLEMENTADO |
| no-new-privileges | IMPLEMENTADO |
| `.dockerignore` endurecido | IMPLEMENTADO |
| Health check | VALIDADO |
| PostgreSQL sem porta publicada no host | IMPLEMENTADO |
| Rede Docker dedicada | IMPLEMENTADO |
| Trivy | VALIDADO |
| Persistência PostgreSQL em volume | IMPLEMENTADO |

A imagem da aplicação foi submetida ao Trivy no pipeline DevSecOps e a execução final foi aprovada.

---

# 8. Logging e Auditoria

Eventos de segurança implementados:

| Evento | Status |
|---|---|
| LOGIN_SUCCESS | IMPLEMENTADO |
| LOGIN_FAILED | IMPLEMENTADO |
| UNAUTHORIZED_ACCESS | IMPLEMENTADO |
| ACCESS_DENIED | IMPLEMENTADO |
| RATE_LIMIT_EXCEEDED | IMPLEMENTADO |
| CUSTOMER_ANONYMIZED | IMPLEMENTADO |

Os registros de auditoria podem registrar:

- ação;
- usuário;
- endpoint;
- endereço IP;
- data/hora.

Os logs locais são ignorados pelo Git e não devem integrar o pacote final de entrega.

---

# 9. Observabilidade

| Controle | Ferramenta | Status |
|---|---|---|
| Health Check | Spring Actuator | VALIDADO |
| Métricas | Micrometer | VALIDADO |
| Coleta | Prometheus | VALIDADO |
| Dashboard | Grafana | VALIDADO |
| Disponibilidade | Prometheus/Grafana | VALIDADO |
| CPU | Micrometer | VALIDADO |
| Memória JVM | Micrometer | VALIDADO |
| Requisições HTTP | Micrometer | VALIDADO |
| Erros HTTP | Micrometer | VALIDADO |
| Latência p95 | Micrometer | VALIDADO |
| Conexões DB | HikariCP metrics | VALIDADO |
| WARN/ERROR | métricas/logs | VALIDADO |

Dashboard:

`FordCare Intelligence — Security & Observability`

O Prometheus validou o target da aplicação como `UP`.

A consulta:

`up{job="fordcare-api"}`

retornou:

`1`

---

# 10. Alertas

| Alerta | Condição | Status |
|---|---|---|
| FordCareApiDown | API indisponível por 1 minuto | VALIDADO |
| FordCareHighServerErrorRate | Mais de 5% de HTTP 5xx | VALIDADO |
| FordCareHighJvmMemory | Heap acima de 85% | VALIDADO |

As três regras foram carregadas pelo Prometheus e visualizadas em estado `INACTIVE` durante a operação saudável da aplicação.

---

# 11. Resposta a Incidentes

Fluxo documentado:

`Detecção → Análise → Contenção → Erradicação → Recuperação → Lições Aprendidas → Melhoria Contínua`

Documento:

`docs/security/INCIDENT_RESPONSE.md`

Status:

**IMPLEMENTADO E DOCUMENTADO**

São considerados cenários como:

- falhas de autenticação;
- acessos não autorizados;
- acessos negados por RBAC;
- excesso de requisições;
- indisponibilidade da API;
- aumento de HTTP 5xx;
- consumo elevado de memória.

---

# 12. Threat Modeling

Metodologia utilizada:

**STRIDE**

Categorias analisadas:

- Spoofing;
- Tampering;
- Repudiation;
- Information Disclosure;
- Denial of Service;
- Elevation of Privilege.

Documento:

`docs/security/THREAT_MODEL.md`

Status:

**IMPLEMENTADO E DOCUMENTADO**

---

# 13. OWASP

## OWASP ASVS

Foram mapeados controles relacionados a:

- autenticação;
- sessão e tokens;
- controle de acesso;
- validação;
- criptografia e secrets;
- logging;
- configuração e operação.

Status:

**MAPEADO E DOCUMENTADO**

## OWASP API Security Top 10

Foram considerados riscos relacionados a:

- autorização em objetos;
- autenticação;
- propriedades de objetos;
- consumo de recursos;
- autorização de funções;
- fluxos sensíveis;
- SSRF;
- configuração;
- inventário;
- consumo de APIs externas.

Status:

**MAPEADO E DOCUMENTADO**

## OWASP Mobile Top 10

Foram considerados controles relacionados a:

- armazenamento seguro;
- comunicação;
- autenticação;
- autorização;
- secrets;
- dependências.

Status:

**MAPEADO E DOCUMENTADO**

Documento:

`docs/security/COMPLIANCE.md`

---

# 14. LGPD

| Controle | Status |
|---|---|
| Controle de acesso | IMPLEMENTADO |
| Autenticação | IMPLEMENTADO |
| Auditoria | IMPLEMENTADO |
| Anonimização | IMPLEMENTADO |
| Segurança de secrets | IMPLEMENTADO |
| Monitoramento | IMPLEMENTADO |
| Política de retenção | DOCUMENTADA |
| Backup seguro | DOCUMENTADO |
| Resposta a incidentes | DOCUMENTADA |

A implementação representa controles técnicos de apoio à proteção dos dados pessoais e não constitui declaração de conformidade jurídica integral com a LGPD.

---

# 15. Backup e Recovery

| Controle | Status |
|---|---|
| Volume persistente PostgreSQL | IMPLEMENTADO |
| Script de backup | IMPLEMENTADO |
| Script de restore | IMPLEMENTADO |
| Backup real executado | VALIDADO |
| Arquivo de backup não vazio | VALIDADO |
| Restore em banco isolado | VALIDADO |
| Estrutura recuperada | VALIDADO |
| Banco de teste removido após validação | VALIDADO |
| RPO proposto | 24 horas |
| RTO proposto | 4 horas |

Arquivos:

`scripts/backup-db.ps1`

`scripts/restore-db.ps1`

`docs/security/BACKUP_RECOVERY.md`

Durante a validação foi realizado restore em banco isolado e confirmada a recuperação das tabelas da aplicação.

---

# 16. Segurança Contínua

| Controle | Status |
|---|---|
| Testes automatizados | VALIDADO |
| SAST contínuo | VALIDADO |
| SCA contínuo | VALIDADO |
| Secret Scanning | VALIDADO |
| Container Scanning | VALIDADO |
| Security Gate | VALIDADO |
| Revisão de RBAC | DOCUMENTADA |
| Monitoramento contínuo | IMPLEMENTADO |
| Gestão de vulnerabilidades | VALIDADA |
| Backup periódico | DOCUMENTADO |
| Restore periódico | DOCUMENTADO |
| Revisão do Threat Model | DOCUMENTADA |

Documento:

`docs/security/CONTINUOUS_SECURITY.md`

O pipeline funciona como mecanismo automatizado de segurança contínua, impedindo a aprovação do Security Gate quando etapas obrigatórias falham.

---

# 17. Evidências produzidas

Durante a Sprint foram produzidas evidências técnicas de:

1. Maven `BUILD SUCCESS`;
2. 16 testes automatizados aprovados;
3. containers Docker em execução;
4. FordCare API em estado `HEALTHY`;
5. PostgreSQL em estado `HEALTHY`;
6. `/actuator/health` funcionando;
7. métricas reais disponibilizadas pelo Actuator;
8. target FordCare API `UP` no Prometheus;
9. consulta `up{job="fordcare-api"}` retornando `1`;
10. dashboard Grafana em funcionamento;
11. métricas de CPU e memória;
12. métricas de requisições e erros HTTP;
13. métricas de latência;
14. eventos WARN/ERROR;
15. três regras de alerta carregadas no Prometheus;
16. backup PostgreSQL executado;
17. arquivo de backup criado e não vazio;
18. restauração realizada em banco isolado;
19. dez tabelas verificadas após o restore;
20. execução do pipeline GitHub Actions;
21. Semgrep aprovado;
22. OWASP Dependency-Check aprovado;
23. Gitleaks aprovado com `No leaks detected`;
24. Trivy aprovado;
25. Security Gate aprovado;
26. pipeline DevSecOps concluído com status `Success`.

---

# 18. Validação final

A validação técnica da Sprint foi concluída.

## Ambiente local

- aplicação compilada;
- testes automatizados executados;
- 16 testes aprovados;
- Docker validado;
- observabilidade validada;
- backup e restore validados.

## CI/CD

- Build e Testes — APROVADO;
- Semgrep — APROVADO;
- OWASP Dependency-Check — APROVADO;
- Gitleaks — APROVADO;
- Trivy — APROVADO;
- Security Gate — APROVADO.

## Cuidados para entrega

Antes de gerar o pacote definitivo:

- não incluir `.env`;
- não incluir `target/`;
- não incluir `logs/`;
- não incluir `backups/`;
- não incluir `.idea/`;
- não incluir certificados ou chaves privadas;
- não incluir credenciais reais;
- rotacionar credenciais que tenham sido expostas durante desenvolvimento.

---

# 19. Resultado Final

Os quatro grandes grupos exigidos pela Sprint possuem implementação, documentação e/ou validação correspondente:

1. **Pipeline DevSecOps Integrado**;
2. **Segurança em Código e Infraestrutura**;
3. **Observabilidade, Monitoramento e Resposta**;
4. **Compliance, Riscos e Segurança Contínua**.

O FordCare Intelligence possui uma cadeia DevSecOps executável com testes automatizados, análise estática, análise de dependências, detecção de secrets, análise de containers e Security Gate.

A aplicação também possui controles de autenticação, autorização, auditoria, monitoramento, resposta a incidentes, backup, recuperação e gestão contínua de riscos.

A execução final do pipeline foi concluída com sucesso em todos os jobs obrigatórios.