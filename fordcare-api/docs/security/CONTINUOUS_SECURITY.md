# FordCare Intelligence — Segurança Contínua

## 1. Objetivo

Este documento define o processo de segurança contínua do FordCare
Intelligence.

A segurança é incorporada ao ciclo de desenvolvimento através de
testes automatizados, análise de código, análise de dependências,
detecção de secrets, análise de containers, revisão de permissões,
monitoramento e procedimentos de backup e recuperação.

---

# 2. Pipeline DevSecOps

O pipeline de segurança é executado através do GitHub Actions.

As principais etapas são:

1. Build e testes automatizados;
2. SAST;
3. SCA;
4. Secret Scanning;
5. Container Security;
6. Security Gate.

O objetivo é identificar problemas antes que alterações sejam
consideradas aptas para integração ou entrega.

---

# 3. SAST — Static Application Security Testing

Ferramenta:

Semgrep.

Objetivo:

Analisar o código-fonte em busca de padrões potencialmente inseguros,
erros de implementação e vulnerabilidades conhecidas.

Execução:

Pipeline CI/CD.

A análise deve ser repetida sempre que houver alterações relevantes
no código.

---

# 4. SCA — Software Composition Analysis

Ferramenta:

OWASP Dependency-Check.

Objetivo:

Identificar vulnerabilidades conhecidas nas dependências utilizadas
pelo projeto.

Dependências vulneráveis devem ser avaliadas considerando:

- severidade;
- possibilidade de exploração;
- componente afetado;
- versão corrigida disponível;
- impacto da atualização.

---

# 5. Secret Scanning

Ferramenta:

Gitleaks.

Objetivo:

Identificar credenciais, tokens, chaves ou outros secrets que possam
ter sido adicionados ao repositório.

Além da análise automatizada, o projeto utiliza:

- variáveis de ambiente;
- .gitignore;
- .dockerignore;
- externalização do keystore;
- ausência de secrets no código-fonte.

Caso um secret real seja exposto, removê-lo do código não é suficiente.

A credencial deve ser considerada comprometida e deve ser rotacionada.

---

# 6. Container Security

Ferramenta:

Trivy.

Objetivo:

Analisar a imagem Docker da API em busca de vulnerabilidades conhecidas
no sistema operacional e nas bibliotecas presentes na imagem.

O pipeline verifica vulnerabilidades HIGH e CRITICAL conforme a política
definida no workflow.

Outros controles utilizados:

- multi-stage build;
- imagem de runtime separada;
- usuário não-root;
- no-new-privileges;
- redução dos arquivos enviados ao build através do .dockerignore.

---

# 7. Testes de segurança

O projeto possui testes automatizados relacionados a:

- inicialização da aplicação;
- geração e validação de JWT;
- rejeição de chave JWT insegura;
- acesso sem autenticação;
- acesso autorizado;
- acesso negado por perfil;
- endpoints protegidos.

Os testes devem continuar sendo ampliados sempre que novas regras de
segurança forem introduzidas.

---

# 8. Auditoria periódica de permissões

O FordCare utiliza os perfis:

- ADMIN;
- ANALYST;
- DEALER_MANAGER.

As regras de acesso devem ser revisadas periodicamente e sempre que
ocorrer:

- criação de novo endpoint;
- criação de novo perfil;
- alteração de responsabilidade de um perfil;
- identificação de acesso indevido;
- alteração relevante no fluxo de negócio.

A revisão deve confirmar o princípio do menor privilégio.

---

# 9. Monitoramento contínuo

A observabilidade utiliza:

- Spring Boot Actuator;
- Micrometer;
- Prometheus;
- Grafana;
- logs;
- registros persistentes de auditoria.

São acompanhados indicadores como:

- disponibilidade;
- CPU;
- memória JVM;
- requisições;
- erros HTTP;
- latência;
- conexões com banco;
- eventos WARN e ERROR.

---

# 10. Alertas

O projeto possui regras para:

- indisponibilidade da API;
- taxa elevada de erros 5xx;
- utilização elevada de memória JVM.

Novas regras devem ser criadas quando novos riscos operacionais forem
identificados.

---

# 11. Backup e Recovery

O projeto possui:

scripts/backup-db.ps1

e:

scripts/restore-db.ps1

O processo de backup e restauração foi validado utilizando um banco
temporário isolado.

O teste confirmou a recuperação da estrutura do banco sem alterar o
banco principal da aplicação.

Detalhes adicionais estão documentados em:

BACKUP_RECOVERY.md

---

# 12. Frequência recomendada

| Controle | Frequência |
|---|---|
| Testes automatizados | A cada alteração integrada |
| SAST | Pipeline CI/CD |
| SCA | Pipeline CI/CD e revisão periódica |
| Secret Scanning | Pipeline CI/CD |
| Container Scan | A cada nova imagem |
| Revisão de RBAC | Mudanças de acesso e revisão periódica |
| Monitoramento | Contínuo |
| Backup | Diário em produção |
| Teste de restore | Periódico |
| Threat Model | Mudanças relevantes de arquitetura |
| Revisão de dependências | Contínua/periódica |

---

# 13. Gestão de vulnerabilidades

Quando uma vulnerabilidade for identificada:

1. registrar a descoberta;
2. avaliar severidade e impacto;
3. identificar o componente afetado;
4. definir prioridade;
5. aplicar correção ou mitigação;
6. executar testes;
7. executar novamente os scanners relevantes;
8. validar que a vulnerabilidade foi tratada;
9. documentar o resultado.

Vulnerabilidades críticas devem receber prioridade máxima de análise.

---

# 14. Gestão de mudanças

Alterações relacionadas à segurança devem passar por:

Código
↓
Testes
↓
SAST
↓
SCA
↓
Secret Scanning
↓
Container Security
↓
Security Gate
↓
Entrega

Falhas relevantes nas verificações de segurança devem impedir que a
alteração seja considerada aprovada até que sejam analisadas.

---

# 15. Melhoria contínua

Resultados de:

- incidentes;
- scanners;
- testes;
- auditorias;
- monitoramento;
- revisão de arquitetura;

devem alimentar novamente o processo de desenvolvimento.

O ciclo adotado é:

Planejar
↓
Desenvolver
↓
Testar
↓
Analisar Segurança
↓
Monitorar
↓
Responder
↓
Melhorar