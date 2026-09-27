# FordCare Intelligence — Backup e Recovery

## 1. Objetivo

Este documento define a estratégia de backup e recuperação utilizada
no FordCare Intelligence para reduzir o impacto causado por perda,
corrupção ou indisponibilidade de dados.

---

## 2. Banco protegido

O banco principal da aplicação é PostgreSQL.

No ambiente containerizado, os dados são persistidos através do volume:

fordcare_postgres_data

A utilização de volume evita que os dados sejam perdidos simplesmente
pela recriação do container.

O volume, entretanto, não substitui uma estratégia de backup.

---

## 3. Backup

O projeto possui o script:

scripts/backup-db.ps1

O script utiliza pg_dump dentro do container PostgreSQL para gerar uma
cópia lógica do banco de dados.

Os arquivos são armazenados localmente na pasta:

backups/

A pasta não é versionada no Git.

---

## 4. Restore

O projeto possui:

scripts/restore-db.ps1

A restauração utiliza psql e exige confirmação explícita antes da
execução.

O objetivo é reduzir o risco de restaurações acidentais.

---

## 5. Política proposta

Para um ambiente de produção, recomenda-se como política inicial:

- backup diário;
- armazenamento fora do servidor principal;
- criptografia dos backups;
- controle de acesso;
- verificação de integridade;
- retenção definida conforme requisitos operacionais e de privacidade;
- testes periódicos de restauração.

Os períodos definitivos de retenção devem ser definidos de acordo com
requisitos do negócio, segurança e privacidade.

---

## 6. RPO e RTO

Como metas iniciais de projeto:

RPO (Recovery Point Objective):

24 horas.

Isso representa uma meta máxima inicial de perda de dados equivalente
ao intervalo entre backups diários.

RTO (Recovery Time Objective):

4 horas.

Isso representa uma meta inicial para restauração do serviço após um
incidente relevante.

Esses valores são objetivos propostos para o projeto acadêmico e devem
ser revisados de acordo com requisitos reais do negócio.

---

## 7. Processo de recuperação

Em caso de perda ou corrupção de dados:

1. identificar e conter a causa do incidente;
2. impedir novas alterações quando necessário;
3. selecionar um backup íntegro;
4. validar a origem e integridade do backup;
5. executar o procedimento de restauração;
6. validar o banco restaurado;
7. iniciar a aplicação;
8. verificar /actuator/health;
9. validar endpoints críticos;
10. acompanhar métricas no Prometheus e Grafana.

---

## 8. Teste de restauração

Backups somente são considerados confiáveis quando o processo de
restauração é testado.

Devem ser realizados testes periódicos em ambiente controlado para
confirmar que:

- o arquivo pode ser lido;
- a estrutura do banco pode ser recuperada;
- os dados esperados estão presentes;
- a aplicação consegue utilizar o banco restaurado.

---

## 9. Segurança dos backups

Backups podem conter dados pessoais e informações sensíveis.

Portanto, em produção devem ser protegidos através de:

- criptografia em repouso;
- controle de acesso;
- armazenamento separado;
- registro de acesso;
- política de retenção;
- descarte seguro.

Backups reais não devem ser adicionados ao repositório de código.

---

## 10. Relação com resposta a incidentes

O processo de recuperação complementa o documento:

INCIDENT_RESPONSE.md

Após contenção e erradicação de um incidente, o mecanismo de backup
pode ser utilizado durante a etapa de recuperação caso a integridade
dos dados tenha sido afetada.