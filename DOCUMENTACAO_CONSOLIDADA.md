# ZABBIX_MONITOR — DOSSIÊ TÉCNICO CONSOLIDADO E LINHA DO TEMPO

**Projeto:** ZABBIX_MONITOR  
**Repositório:** https://github.com/carlos-andrade/ZABBIX_MONITOR  
**Documento:** DOCUMENTACAO_CONSOLIDADA.md  
**Versão documental:** 2.0  
**Data de consolidação:** 24 de outubro de 2026  
**Ramo de referência:** main  
**Finalidade:** centralizar o histórico recuperável dos chats, as datas das pesquisas e sessões técnicas, a arquitetura discutida, os estados conhecidos, os incidentes e o plano de trabalho.

> **Nota sobre a exatidão histórica:** as datas abaixo são as datas dos registos de conversa que foram recuperados. Não significam que todas as ações propostas tenham sido executadas, nem que o estado observado na data permaneça atual. Quando não existe evidência de conclusão, o estado é marcado como histórico, proposto ou pendente. Este documento consolida o histórico recuperável, não garante a reprodução literal de todas as mensagens de todos os chats.

---

## 1. Resumo executivo

O **ZABBIX_MONITOR** pretende evoluir para um ecossistema modular de monitorização, observabilidade e gestão operacional de TI. O Zabbix é o componente central previsto e o Ubuntu Server constitui a infraestrutura-base referida pelo utilizador. A solução deverá monitorizar servidores, serviços, redes, aplicações e dispositivos conectados, detetar falhas, gerar alertas, apresentar métricas e permitir automações controladas.

O trabalho histórico abrangeu quatro linhas principais:

1. **Zabbix no Ubuntu Server:** instalação, agente, conectividade, configuração de hosts autorizados, logs e testes.
2. **Alertas e integrações:** testes de email, Postfix, Mailgun, n8n e possíveis notificações por outros canais.
3. **Contentores e IoT:** Docker Compose, ChirpStack, Mosquitto/MQTT, PostgreSQL e Redis, incluindo conflito histórico da porta 1883.
4. **Arquitetura, governação e validação:** documentação, segurança, inventário, evidências, roadmap e possível apresentação empresarial.

Também foram discutidas integrações opcionais com Grafana, proxies, recolha de dados de mercado e bases de dados temporais. Essas propostas não devem ser confundidas com componentes comprovadamente instalados ou integrados.

## 2. Convenções para interpretar o documento

Os estados são usados de forma consistente:

- **CONFIRMADO NO GITHUB:** observado diretamente nos metadados ou ficheiros do repositório.
- **RELATADO PELO UTILIZADOR:** informação comunicada em conversa, sem verificação independente nesta consolidação.
- **OBSERVADO NUM SNAPSHOT:** estado de uma saída de terminal num momento específico.
- **HISTÓRICO:** informação técnica de uma sessão antiga que deve ser novamente verificada.
- **PROPOSTO:** solução ou configuração recomendada, sem evidência de execução bem-sucedida.
- **PENDENTE:** necessita de nova recolha, teste ou validação.
- **VALIDADO:** reservado a resultados acompanhados por evidência suficiente e critérios de aceitação satisfeitos.

Não se deve interpretar a presença de um serviço em execução como prova de que a sua integração funcional, segurança, persistência ou recuperação foram testadas.

## 3. Identidade e estado do repositório

### 3.1 Estado confirmado em 24 de outubro de 2026

Na inspeção direta ao GitHub em **24-10-2026**, foram confirmados:

- Repositório: https://github.com/carlos-andrade/ZABBIX_MONITOR
- Visibilidade: pública.
- Ramo predefinido: `main`.
- Primeiro commit: `Initial commit`.
- Licença: MIT.
- Árvore inicial inspecionada: continha apenas `LICENSE`.
- README.md: não encontrado na inspeção inicial.
- Código de monitorização e configurações versionadas: não encontrados na árvore inicial.
- Proteção do ramo `main`: não ativada na inspeção.
- Issues: ativadas.
- Data de criação indicada pelo GitHub: 24-10-2026.

A descrição registada no GitHub é:

> ZABBIX_MONITOR É UM ECOSSISTEMA DE MONITORIZAÇÃO DE TI, BASEADO EM ZABBIX E UBUNTU SERVER. INTEGRA VISUALIZAÇÃO, ALERTAS, AUTOMAÇÃO E IOT PARA ACOMPANHAR INFRAESTRUTURAS, REFORÇAR A SEGURANÇA, PREVENIR INCIDENTES E GARANTIR A CONTINUIDADE OPERACIONAL, COM ARQUITETURA MODULAR E ESCALÁVEL PARA EMPRESAS.

A licença MIT está no ficheiro [LICENSE](https://github.com/carlos-andrade/ZABBIX_MONITOR/blob/main/LICENSE). A licença permite uso, modificação e redistribuição segundo as condições ali descritas; não certifica a segurança nem a qualidade técnica do projeto.

### 3.2 Registos documentais no GitHub

- **24-10-2026:** criado o documento inicial `DOCUMENTACAO_CONSOLIDADA.md`, commit `746cbe0ca1cc2945ea964145b12a6af49c39d871`.
- **24-10-2026:** a versão documental foi ampliada para incluir uma linha do tempo datada, mais detalhes históricos e uma distinção explícita entre observações, propostas e pendências. O SHA deste commit deve ser confirmado após a gravação desta revisão.

A árvore e os metadados do repositório devem ser novamente inspecionados sempre que se iniciar uma nova fase do projeto.

## 4. Linha do tempo cronológica das conversas e pesquisas

As datas seguintes foram recuperadas dos registos de conversas disponíveis. Cada entrada descreve o conteúdo técnico associado à data e indica o nível de certeza.

### 21 de maio de 2025 — Atualização do Zabbix no Ubuntu Server

**Tema:** atualização e manutenção do Zabbix.

O registo desta conversa tratou de atualização do Zabbix no Ubuntu Server. Foi mencionado um procedimento que incluía:

- Fazer backup da base de dados e dos ficheiros de configuração antes da atualização.
- Usar o repositório apropriado para a versão-alvo do Zabbix.
- Atualizar os componentes de servidor, frontend e agente.
- Reiniciar os serviços e verificar o estado após a atualização.

O exemplo de repositório mencionado estava associado ao Zabbix 7.0 LTS e Ubuntu 22.04; não se deve inferir que esse procedimento tenha sido executado exatamente dessa forma, nem que a versão atual do sistema seja Ubuntu 22.04.

**Estado:** histórico de orientação; execução e resultado final não confirmados nesta consolidação.

### 2 de junho de 2025 — Zabbix Agent no Ubuntu Server em máquina virtual

**Tema:** agente a monitorizar o próprio servidor.

O utilizador descreveu o host `UBUNTUSERVER`, um Ubuntu Server executado numa máquina virtual. O agente aparecia a escutar em:

- `0.0.0.0:10050`
- `[::]:10050`

A saída indicava múltiplos processos `zabbix_agentd`.

**Significado técnico:** a porta 10050 é a porta habitual de escuta do Zabbix Agent clássico. A existência de um socket em escuta confirma apenas que o processo abriu a porta; não prova que o servidor Zabbix esteja autorizado a consultar o agente ou que os itens estejam a ser recolhidos.

**Estado:** observação histórica; confirmar versão do agente, configuração e conectividade atuais.

### 22 de junho de 2025 — Âmbito inicial de monitorização e troubleshooting do agente

**Tema:** infraestrutura Ubuntu/Zabbix, hardening e conectividade.

O contexto recuperado indica que o utilizador já usava Ubuntu Server e Zabbix. Entre os tópicos de interesse estavam:

- Hardening e segurança.
- Agentes e templates.
- Monitorização por SNMP e HTTP.
- Grafana.
- Zabbix Proxy e monitorização distribuída.
- API e automações.

No troubleshooting do agente no host `ubuntuserver`, foi observada escuta em TCP 10050 para IPv4 e IPv6. O log do agente rejeitava pedidos locais provenientes de `127.0.0.1`. A configuração de hosts autorizados continha `192.168.60.142), repetido em entradas de configuração.

Foi proposta a inclusão de `127.0.0.1` na diretiva `Server`, mantendo o endereço do servidor Zabbix:

```ini
Server=127.0.0.1,192.168.60.142
```

Também foi sugerida a verificação de `ServerActive`, se a recolha ativa fosse utilizada, e um teste com `zabbix_get`. A ferramenta `zabbix_get) não estava instalada na sessão; a shell sugeriu instalar pacotes relacionados com Zabbix Server/Proxy.

**Cuidado:** o valor `192.168.60.142` é um endereço histórico. Não o reutilizar sem confirmar que ainda corresponde ao servidor Zabbix. Não instalar componentes adicionais apenas para obter uma ferramenta de teste sem primeiro avaliar o pacote apropriado e o papel da máquina.

**Estado:** problema e diagnóstico históricos; correção final não comprovada.

### 9 de julho de 2025 — Testes de alertas por email

**Tema:** cadeia de eventos, triggers e notificações.

Foi descrito um procedimento de teste de alertas por email envolvendo um item de log, uma trigger e um script externo. O objetivo era confirmar que uma condição monitorizada gerava um evento e que esse evento acionava o mecanismo de notificação.

O procedimento deve ser entendido como uma sequência de validação:

1. Confirmar que o item recolhe o dado esperado.
2. Gerar uma condição de teste controlada.
3. Confirmar que a trigger muda de estado.
4. Confirmar a criação do evento e a execução da action.
5. Verificar a execução do script ou do media type.
6. Confirmar entrega ao destinatário e inspecionar logs.

**Estado:** teste proposto/documentado; não há prova recuperada de entrega final bem-sucedida.

### 12 de julho de 2025 — Organização da descoberta de nós

**Tema:** duplicação na descoberta de nós.

Foi proposta uma reorganização para evitar duplicação de `zabbix.nodes.discovery`. O registo recuperado não contém detalhe suficiente para afirmar que houve alteração definitiva ou qual ficheiro foi modificado.

**Ação pendente:** se o tema voltar a ser relevante, localizar a configuração atual, identificar a origem da duplicação e validar o resultado antes de alterar regras de descoberta.

### 12 de agosto de 2025 — Proposta de automação com Ansible, Postfix e Mailgun

**Tema:** configuração reproduzível de Zabbix e notificações.

Foi discutida uma proposta YAML/Ansible com os seguintes componentes:

- `zabbix-server-mysql`
- `zabbix-frontend-php`
- `zabbix-agent`
- Postfix como relay SMTP para `[smtp.mailgun.org]:587`
- n8n em contentor, com a porta 5678

Foi sugerida a execução de um playbook Ansible e a validação do resultado. O registo não confirma a execução bem-sucedida do playbook nem a integração final com Mailgun.

**Estado:** arquitetura/procedimento proposto; implementação não comprovada.

**Requisitos para retomar:** confirmar versão de Ubuntu e Zabbix, variáveis e inventário Ansible, credenciais fora do Git, autenticação SMTP, TLS, logs e um teste de entrega ponta a ponta.

### 19 de agosto de 2025 — IP do servidor Zabbix e ligação do agente

**Tema:** erro de conexão e configuração do agente.

O utilizador corrigiu o endereço IP do servidor Zabbix para `192.168.60.142`. Os parâmetros discutidos foram:

```ini
Server=127.0.0.1,192.168.60.142
ServerActive=192.168.60.142
Hostname=UBUNTUSERVER
```

Foi relatado o erro `[104] Connection reset by peer`. Foram sugeridos:

- Teste de conectividade com `zabbix_get` na porta 10050, usando a chave `agent.ping`, cujo resultado esperado seria `1`.
- Inspeção dos logs do agente e do servidor.
- Verificação de nome de host e correspondência com o host configurado no frontend.

Caminhos de log indicados na conversa:

```text
/var/log/zabbix/zabbix_agentd.log
/var/log/zabbix/zabbix_server.log
```

**Estado:** o IP e os parâmetros são registos históricos; o erro e a resolução final devem ser novamente verificados. Não assumir que o endereço ou o hostname continuam iguais.

### 11 de outubro de 2025 — Zabbix 7.0.17 no Ubuntu 24.04

**Tema:** pacotes instalados.

O utilizador reportou pacotes Zabbix **7.0.17** num Ubuntu **24.04**, incluindo:

- Agent.
- Server com suporte MySQL.
- Frontend PHP.
- Configuração Apache.

Este registo é mais específico que as referências anteriores a Ubuntu 22.04, mas continua a ser uma fotografia histórica. A versão atual do sistema e dos pacotes precisa de ser recolhida diretamente no servidor.

**Estado:** reportado pelo utilizador em 11-10-2025; não revalidado nesta revisão.

### 30 de outubro de 2025 — n8n em Docker com PostgreSQL

**Tema:** automação de fluxos a partir do Zabbix.

Foi discutido n8n em Docker/Ubuntu com PostgreSQL, expondo a porta 5678 e usando um comando de arranque `docker-compose up -d`. O fluxo de referência era:

**Zabbix → n8n → Mailgun e/ou Telegram.**

A ideia era encaminhar eventos do Zabbix para um fluxo de automação que pudesse normalizar, enriquecer e encaminhar notificações.

**Estado:** arquitetura proposta; a execução, a segurança da interface n8n e a integração funcional não foram confirmadas.

### 23 de fevereiro de 2026 — ChirpStack, Docker Compose e MQTT

**Tema:** stack LoRaWAN e integração com Zabbix/n8n.

Foi discutida uma stack Docker Compose para ChirpStack em Ubuntu, com serviços como:

- ChirpStack.
- PostgreSQL.
- Redis.
- Mosquitto.

O primeiro arranque falhou porque a porta do host `0.0.0.0:1883/tcp` já estava ocupada. A situação indicava um conflito de porta com um serviço já em escuta, mas não autorizava parar serviços sem descobrir primeiro qual processo ou contentor era o proprietário da porta.

Mais tarde, o registo da conversa indicou que a stack tinha arrancado. A saída de `docker ps` mostrava os serviços ChirpStack, REST API, bridges de gateway, Redis, PostgreSQL e Mosquitto em execução. As portas referidas incluíam:

- `1883/TCP`: MQTT interno no cenário descrito.
- `8080` e `8090`: serviços/API do ChirpStack no mapeamento discutido.
- `1700/UDP): tráfego de gateway referido.
- `3001): bridge/serviço referido na saída.

Foi recomendado manter o broker MQTT interno na rede Docker, com o endereço de serviço:

```text
tcp://mosquitto:1883
```

Foi indicado como exemplo de tópico de uplink:

```text
application/{{application_id}}/device/{{dev_eui}}/event/up
```

A integração proposta era receber eventos MQTT e encaminhá-los para consumidores como n8n e/ou integrações de Zabbix, com alertas por Postfix/Mailgun.

**Interpretação correta:** o registo indica que uma stack foi apresentada como Running naquele momento. Não comprova, por si só, que gateway e dispositivo LoRaWAN tenham enviado mensagens reais, que a persistência tenha sido testada, que os tópicos estejam autorizados corretamente ou que os alertas estejam integrados de ponta a ponta.

**Pendências de segurança e operação:** confirmar o serviço que ocupa a porta 1883 no host; evitar exposição pública desnecessária do MQTT; verificar autenticação, ACLs, redes Docker, volumes, healthchecks, backups e logs; testar uma mensagem de ponta a ponta.

### 24 de outubro de 2026 — Inventário da Máquina 02 e reconhecimento do servidor

**Tema:** provar a existência da infraestrutura e documentar o estado antes de intervir.

O utilizador esclareceu que a finalidade era demonstrar que possui uma máquina/servidor Ubuntu, e não começar por alterar a infraestrutura.

O contexto recuperado da sessão de 24-10-2026 refere uma stack Docker Compose denominada `chirpstack-docker`, com ChirpStack, Mosquitto, Redis e PostgreSQL. A lista de serviços ativos reportada incluía:

- `zabbix-agent`
- `zabbix-server`
- Apache
- Dovecot
- MySQL
- PostgreSQL
- Redis
- BIND
- Mosquitto

Também foram referidos os serviços e portas do ChirpStack e a porta 10050 do Zabbix Agent. O primeiro diagnóstico Docker foi afetado por permissões; foram pedidos comandos com `sudo`, nomeadamente:

```bash
sudo docker ps -a
sudo docker compose ls -a
```

Foi relatado que um inventário da Máquina 02 tinha sido preparado noutro repositório, **API_CARLOS**, numa pull request #13, com o caminho `docs/INFRAESTRUTURA_MAQUINA_02.md` e commit `da2068378ed48834863a8de5bb3df15be540d932`. O registo indicava que a PR ainda não estava integrada. A inspeção não autorizava alterações a serviços; o estado foi descrito como NO-GO para alterações públicas/operacionais até haver validação.

Na mesma data foi criado o repositório ZABBIX_MONITOR, cuja árvore inicial foi inspecionada. Na inspeção, o repositório continha apenas `LICENSE`; não havia README.md nem diretórios técnicos.

**Decisão de trabalho:** reconhecer, inventariar e documentar antes de modificar. Não reiniciar, remover ou reconfigurar serviços sem snapshot, dependências identificadas e autorização operacional clara.

### 24 de outubro de 2026 — Documento consolidado inicial

Foi criado `DOCUMENTACAO_CONSOLIDADA.md` para centralizar o contexto recuperável do projeto, com o commit:

```text
746cbe0ca1cc2945ea964145b12a6af49c39d871
```

A revisão atual amplia esse documento com a linha do tempo, os detalhes de troubleshooting recuperados e as limitações de evidência.

## 5. Inventário consolidado de componentes e estado

| Componente | Evidência histórica | Estado correto para planeamento |
|---|---|---|
| Ubuntu Server | Utilizador confirmou a existência do servidor; host referido como `ubuntuserver`/`UBUNTUSERVER` | Existência reportada; versão e configuração atuais a recolher |
| Zabbix Agent | Escuta em 10050 e logs de rejeição em 2025 | Revalidar configuração, conectividade e versão |
| Zabbix Server | Pacotes 7.0.17 reportados em 2025; serviço reportado ativo em 2026 | Revalidar saúde, versão, base de dados e frontend |
| MySQL | Pacotes/serviço reportados em sessões anteriores | Revalidar instância, versão, utilização e backups |
| Apache / frontend PHP | Pacotes reportados em 2025; Apache reportado ativo em 2026 | Revalidar frontend e configuração TLS |
| Postfix | Discutido como relay de notificações | Integração atual não comprovada |
| Mailgun | Relay SMTP proposto em 2025 | Credenciais e entrega a validar |
| n8n | Docker/porta 5678 discutidos em 2025 | Estado atual não confirmado |
| Grafana | Parte do âmbito desejado de dashboards | Instalação/integração não confirmada nesta revisão |
| Docker / Compose | Stack de ChirpStack e serviços reportada | Recolher snapshot atual, volumes, redes e versões |
| Mosquitto | Conflito histórico de 1883; serviço reportado ativo em 2026 | Broker e exposição de portas a auditar |
| ChirpStack | Stack apresentada como Running em fevereiro de 2026; API reportada em 2026 | Validar operação LoRaWAN ponta a ponta |
| PostgreSQL / Redis | Dependências da stack discutida e serviços reportados em 2026 | Confirmar versões, persistência e uso real |
| BIND / Dovecot | Serviços reportados ativos na Máquina 02 em 2026 | Inventariar finalidade, exposição e manutenção |
| Zabbix Proxy | Discutido como opção para monitorização distribuída | Não assumir instalação |
| Squid / Nginx | Discutidos em cenários de proxy/web | Não assumir instalação |
| Python / Ansible | Propostos para coletores e instalação reproduzível | Playbooks/scripts não comprovados nesta consolidação |
| TimescaleDB / InfluxDB | Propostos para séries temporais especializadas | Arquitetura opcional, não requisito do núcleo |

## 6. Arquitetura funcional de referência

### 6.1 Núcleo de monitorização

**Hosts/serviços → agentes e verificações → Zabbix Server → itens/triggers/eventos → notificações e dashboards.**

O desenho final depende da versão do Zabbix, do tipo de agente, da topologia de rede e da base de dados real. A configuração do agente deve permitir apenas os servidores autorizados, e a porta 10050 não deve ser exposta indiscriminadamente à Internet.

### 6.2 Notificações

Fluxo de referência discutido:

**Zabbix → action/media type ou script controlado → Postfix/relay SMTP → Mailgun, quando configurado → destinatário.**

O n8n pode ser uma camada de orquestração alternativa ou complementar:

**Zabbix → webhook → n8n → serviço de notificação.**

Não se deve criar caminhos duplicados sem necessidade. A arquitetura final precisa de definir quem envia, quem autentica, como se faz retry e onde se consultam os logs.

### 6.3 IoT e LoRaWAN

**Dispositivo → gateway → ChirpStack → MQTT/Mosquitto → consumidor/automação → persistência e/ou alerta.**

A configuração real depende da região LoRaWAN, dos gateways, das chaves e dos tópicos utilizados. A hipótese EU868 foi mencionada anteriormente, mas tem de ser confirmada no equipamento e na configuração. A conectividade MQTT não prova, por si só, que a receção de uplinks está correta.

### 6.4 Dados de mercado — linha opcional separada

Em agosto de 2025 foi discutida uma arquitetura especializada com:

- Coletores Python.
- TimescaleDB para séries temporais como candles, VWAP e GAP.
- InfluxDB para ticks/telemetria em tempo real.
- Grafana para visualização.
- Zabbix para monitorização de disponibilidade dos coletores e serviços.

Esta linha deve ser tratada como integração opcional, separada do âmbito essencial da monitorização de infraestrutura. Exige fontes autorizadas, regras de retenção e validação da qualidade dos dados.

## 7. Segurança, fiabilidade e operação

Os seguintes pontos são requisitos de projeto, não resultados já auditados:

1. **Privilégios mínimos:** serviços e utilizadores devem ter apenas as permissões necessárias.
2. **Firewall:** abrir apenas portas justificadas e para origens autorizadas.
3. **Zabbix Agent:** validar `Server`, `ServerActive`, `Hostname`, modo do agente e correspondência do host.
4. **MQTT:** evitar exposição pública sem necessidade; configurar autenticação, ACLs e redes apropriadas.
5. **Segredos:** nunca guardar passwords, tokens, chaves ou credenciais SMTP no Git.
6. **TLS:** proteger interfaces e integrações conforme a exposição e o risco.
7. **Logs:** definir localização, rotação, retenção e remoção de dados sensíveis.
8. **Persistência:** confirmar volumes e backups das bases de dados e serviços de estado.
9. **Recuperação:** testar restauro, não apenas criação de backups.
10. **Atualizações:** documentar versões e janelas de manutenção.
11. **Observabilidade do próprio sistema:** monitorizar disco, memória, filas, processos, conectividade, base de dados e entrega de alertas.
12. **Alterações controladas:** capturar o estado antes de qualquer alteração e manter rollback documentado.

## 8. Runbooks e testes propostos

### 8.1 Recolha inicial de estado

Executar de forma controlada e guardar saídas sem segredos:

```bash
hostnamectl
cat /etc/os-release
uname -r
systemctl --type=service --state=running
ss -lntup
sudo docker ps -a
sudo docker compose ls -a
```

Os comandos podem exigir privilégios e devem ser executados no servidor correto. Antes de partilhar logs, remover endereços públicos sensíveis, credenciais, tokens e dados pessoais.

### 8.2 Diagnóstico do Zabbix Agent

Verificar configuração e logs atuais antes de editar:

```bash
sudo systemctl status zabbix-agent --no-pager
sudo journalctl -u zabbix-agent --since "24 hours ago"
sudo ss -lntp | grep ':10050'
```

Os caminhos e nomes dos serviços podem variar com a versão e o tipo de agente. Se `zabbix_get` for necessário, instalar apenas o pacote cliente adequado à distribuição e versão, depois de confirmar o objetivo e as dependências.

O teste `agent.ping` deve ser executado a partir de uma origem autorizada. Resultado esperado do item de teste: `1`. Se ocorrer reset ou rejeição, verificar o log do agente, a origem do pedido, a diretiva `Server`, firewall e correspondência do host.

### 8.3 Diagnóstico Docker/MQTT/ChirpStack

Antes de mudar a stack:

```bash
sudo docker ps -a
sudo docker compose ls -a
sudo ss -lntup | grep ':1883'
```

Depois, identificar o projeto Compose, as redes e volumes, consultar logs de cada serviço e determinar qual processo ocupa a porta. Não parar um broker nem remover volumes sem compreender as dependências e confirmar a existência de backup.

### 8.4 Teste de alerta por email

O teste de aceitação deve documentar:

- Evento de teste gerado.
- Item e trigger que produziram o evento.
- Action/media type acionado.
- Resultado de autenticação SMTP e resposta do relay.
- Entrega recebida na caixa de destino.
- Logs e timestamp de cada etapa.
- Resultado final PASS/FAIL e correção necessária.

O caminho `/tmp/log_teste_alerta_zabbix.txt` foi mencionado num procedimento histórico. A existência atual desse ficheiro não foi confirmada.

### 8.5 Teste MQTT

- Confirmar broker e rede corretos.
- Confirmar credenciais/ACLs.
- Subscrever ao tópico correto com um cliente de teste autorizado.
- Produzir uma mensagem de teste ou uplink real.
- Confirmar receção, payload, timestamp e consumidor seguinte.
- Confirmar que a falha de um consumidor não compromete a persistência nem provoca alertas em ciclo.

### 8.6 Evidências

Cada teste deve incluir requisito, versão, comando/procedimento, data e hora, resultado, logs sanitizados, critério de aceitação, estado PASS/FAIL e commit associado.

## 9. Roadmap consolidado e critérios de saída

### Fase 0 — Baseline atual
**Tarefas:** recolher versão Ubuntu/kernel, hardware, serviços, contentores, redes, volumes, portas, versões Zabbix e estado de bases de dados.  
**Saída:** inventário datado e reproduzível.

### Fase 1 — Documentação e governação
**Tarefas:** README.md, decisões de arquitetura, regras de versionamento, segurança, runbooks e proteção do ramo main.  
**Saída:** documentação coerente e processo de mudança definido.

### Fase 2 — Núcleo Zabbix
**Tarefas:** validar servidor, frontend, base de dados, agente, hosts, itens, triggers e histórico.  
**Saída:** recolha ponta a ponta demonstrada num host de teste.

### Fase 3 — Alertas
**Tarefas:** definir caminho de envio, testar SMTP/relay, confirmar entrega e documentar falhas.  
**Saída:** alerta recebido e evidência registada.

### Fase 4 — Dashboards
**Tarefas:** definir KPIs operacionais, decidir o papel de Grafana, configurar permissões e retenção.  
**Saída:** dashboards com dados confirmados e unidades explícitas.

### Fase 5 — Docker, MQTT e ChirpStack
**Tarefas:** reconciliar Compose, portas, redes, volumes, healthchecks, logs e teste de mensagem real.  
**Saída:** mensagem rastreada da origem ao consumidor esperado.

### Fase 6 — Automação n8n
**Tarefas:** escolher um fluxo de baixo risco, limitar permissões, controlar repetição, logs e erros.  
**Saída:** fluxo repetível e auditável.

### Fase 7 — Segurança e recuperação
**Tarefas:** rever acessos, firewall, TLS, segredos, backup e restauro.  
**Saída:** controlos documentados e restauro testado.

### Fase 8 — Demonstração empresarial
**Tarefas:** apresentar arquitetura, inventário, um incidente simulado, deteção, notificação e diagnóstico.  
**Saída:** demonstração reproduzível, distinguindo funcionalidades validadas de planeadas.

## 10. Pendências prioritárias

- [ ] Recolher um snapshot atualizado do servidor Ubuntu.
- [ ] Confirmar a versão atual do Ubuntu e do Zabbix.
- [ ] Confirmar estado do Zabbix Server, Agent, frontend e base de dados.
- [ ] Revalidar os parâmetros do agente e o endereço do servidor autorizado.
- [ ] Verificar a porta 10050 e as regras de firewall.
- [ ] Capturar a lista completa dos contentores, redes, volumes e portas.
- [ ] Identificar a origem atual do conflito histórico da porta 1883, se ainda existir.
- [ ] Validar persistência e saúde da stack ChirpStack/Mosquitto/PostgreSQL/Redis.
- [ ] Confirmar se Grafana, Postfix, Mailgun e n8n estão instalados e integrados.
- [ ] Executar teste de alerta ponta a ponta.
- [ ] Definir e testar backups/restauro.
- [ ] Rever proteção do ramo main e verificações automáticas.
- [ ] Criar/atualizar README.md para apontar para este documento.
- [ ] Só marcar componentes como VALIDADO depois de anexar evidência.

## 11. Estrutura documental recomendada

Esta é uma proposta para evolução do repositório, não a árvore que foi encontrada na inspeção inicial:

```text
ZABBIX_MONITOR/
├── README.md
├── DOCUMENTACAO_CONSOLIDADA.md
├── GOVERNANCA/
│   ├── PRINCIPIOS.md
│   └── DECISOES_ARQUITETURA.md
├── DOCUMENTACAO/
│   ├── INFRAESTRUTURA.md
│   ├── ARQUITETURA.md
│   └── INVENTARIO_SERVICOS.md
├── INSTALACAO/
├── CONFIGURACOES/
├── MONITORIZACAO/
├── ALERTAS/
├── AUTOMACAO/
├── IOT/
├── SEGURANCA/
├── TESTES/
└── ROADMAP.md
```

Criar diretórios apenas quando houver conteúdo ou um plano concreto de utilização. Não colocar no repositório logs integrais de produção, credenciais ou ficheiros com dados sensíveis.

## 12. Decisões e orientações consolidadas

1. O projeto chama-se **ZABBIX_MONITOR**.
2. O Zabbix é o componente central pretendido.
3. O projeto parte de uma máquina/servidor Ubuntu real, segundo confirmação do utilizador.
4. A prioridade imediata é reconhecer e documentar o estado real antes de modificar serviços.
5. Grafana, Postfix, Mailgun, n8n, Docker e IoT devem ser integrados apenas quando houver requisito e teste.
6. A stack ChirpStack/MQTT precisa de validação ponta a ponta; contentores Running não bastam.
7. Os dados de conversas antigas devem ser datados e tratados como históricos até nova confirmação.
8. O GitHub é o ponto de controlo de versão para documentação, decisões e evidências sanitizadas.
9. A prontidão empresarial depende de testes, segurança, backup/restauro e procedimentos operacionais demonstrados.

## 13. Critério de prontidão para produção

O projeto não será considerado pronto para produção apenas por ter serviços instalados ou contentores em execução. É necessário demonstrar:

- Inventário e arquitetura atualizados.
- Monitorização ponta a ponta.
- Alertas entregues e auditáveis.
- Gestão segura de acessos e segredos.
- Backup e restauro verificados.
- Logs e procedimentos de operação.
- Testes de falha e recuperação proporcionais ao risco.
- Alterações rastreáveis e possibilidade de rollback.
- Limitações, dependências e responsabilidades documentadas.

## 14. Registo e limites desta consolidação

Esta versão foi preparada em **24 de outubro de 2026** a partir do histórico recuperável de conversas e da inspeção do repositório. Inclui datas de chats conhecidos — 21-05-2025, 02-06-2025, 22-06-2025, 09-07-2025, 12-07-2025, 12-08-2025, 19-08-2025, 11-10-2025, 30-10-2025, 23-02-2026 e 24-10-2026.

As datas identificam sessões ou registos de conversa disponíveis; não são necessariamente datas de execução de cada ação mencionada. A ausência de uma data ou detalhe significa que não foi possível recuperá-lo com segurança, e não que o trabalho nunca tenha ocorrido.

**Próxima ação recomendada:** recolher o estado atual do servidor, comparar com a linha do tempo e converter cada pendência numa tarefa com responsável, evidência, critério de aceitação e data de validação.


## 13. Reconciliação documental com a Máquina 02 — 24 de outubro de 2026

### 13.1 Resultado da comparação inicial

Foi feita uma reconciliação documental entre o histórico recuperado deste projeto e os registos disponíveis sobre a Máquina 02. Esta etapa **não equivale a uma verificação ao vivo do servidor**: não existe, nesta sessão, um canal de execução remota autorizado para consultar o Ubuntu diretamente.

| Área | Linha de base histórica | Verificação necessária | Estado |
|---|---|---|---|
| Sistema operativo | Ubuntu Server reportado | Recolher versão, kernel e hostname atuais | PENDENTE |
| Zabbix Server/Agent | Ambos reportados como serviços existentes/ativos num snapshot anterior | Estado systemd, versões dos pacotes e portas | PENDENTE |
| Apache, MySQL/MariaDB, PostgreSQL, Redis, BIND, Dovecot e Postfix | Serviços referidos em diferentes momentos; nem todos têm confirmação no mesmo snapshot | Distinguir instalado, ativo e efetivamente utilizado | PENDENTE |
| Docker/Compose | Projeto `chirpstack-docker` e serviços ChirpStack, Mosquitto, PostgreSQL e Redis reportados | Estado atual dos contentores, projetos Compose e portas publicadas | PENDENTE |
| Rede e firewall | Portas históricas 10050, 1883, 3001, 8080, 8090 e 1700 mencionadas | Recolher listeners atuais e estado do UFW, se instalado | PENDENTE |
| Alertas de email | Procedimentos Postfix/Mailgun/n8n discutidos; entrega ponta a ponta não comprovada | Executar teste controlado e verificar evento, ação, logs e receção | PENDENTE |
| Inventário de Máquina 02 | PR [#13 em API_CARLOS](https://github.com/carlos-andrade/API_CARLOS/pull/13) consultada; estado aberto, não integrado | Rever a PR, validar evidências e obter aprovação antes de a integrar | EM REVISÃO |

### 13.2 Ferramenta de recolha de evidências

Foi adicionado o script [`scripts/auditoria_estado_servidor.sh`](https://github.com/carlos-andrade/ZABBIX_MONITOR/blob/main/scripts/auditoria_estado_servidor.sh). O script é de leitura: não instala software, não reinicia serviços e não modifica ficheiros de configuração. Recolhe identificação do sistema, recursos, estado de serviços, versões de pacotes, contentores/Compose, portas em escuta e estado do UFW quando disponível.

Executar no Ubuntu, a partir de uma cópia atualizada do repositório:

```bash
bash scripts/auditoria_estado_servidor.sh 2>&1 | tee auditoria_maquina_02.txt
```

Se o acesso ao Docker exigir privilégios, executar a recolha com permissões administrativas:

```bash
sudo bash scripts/auditoria_estado_servidor.sh 2>&1 | tee auditoria_maquina_02.txt
```

O segundo comando cria o ficheiro de relatório no diretório atual. Antes de partilhar a saída, rever endereços IP, nomes internos e outros dados de infraestrutura. Não partilhar credenciais, tokens, ficheiros `.env`, chaves privadas ou configurações completas que contenham segredos. O script não lê intencionalmente esses conteúdos.

### 13.3 Critérios de reconciliação

Quando a saída for recolhida, cada componente deve ser classificado separadamente:

- **INSTALADO:** pacote ou imagem identificada.
- **ATIVO:** serviço ou contentor em execução no instante da recolha.
- **A ESCUTAR:** porta observada em estado de escuta.
- **FUNCIONAL:** teste de aplicação executado com resultado esperado.
- **INTEGRADO:** teste de ponta a ponta confirma a ligação entre componentes.
- **SEGURO/OPERACIONAL:** controlos de acesso, atualizações, backups, recuperação e monitorização foram verificados com evidências.

Não promover um componente de um estado para o seguinte apenas com base na presença de um pacote ou num contentor em execução. Não parar, atualizar, reconfigurar ou expor serviços como parte desta auditoria inicial.

### 13.4 Benefícios esperados após a recolha

A reconciliação permitirá eliminar suposições antigas, identificar serviços que já não existem ou que foram adicionados, detetar divergências de versões e portas, priorizar pendências reais e construir uma linha de base verificável para futuras alterações. Também permitirá distinguir claramente a existência física/lógica do servidor da prova de funcionamento e integração de cada serviço.

**Estado global da reconciliação: PARCIAL — documentação histórica confrontada; verificação ao vivo pendente da execução do script e análise do relatório.**
