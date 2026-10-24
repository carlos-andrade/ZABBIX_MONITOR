# ZABBIX_MONITOR — DOCUMENTAÇÃO CONSOLIDADA DO PROJETO

**Documento:** Histórico, arquitetura de referência, inventário conhecido e roadmap  
**Projeto:** ZABBIX_MONITOR  
**Repositório:** https://github.com/carlos-andrade/ZABBIX_MONITOR  
**Ramo de referência:** main  
**Última consolidação:** 24 de outubro de 2026  
**Estado documental:** consolidação inicial; requer validação contínua contra a infraestrutura real

---

## 1. Finalidade deste documento

Este documento reúne, num único ponto de referência, o contexto recuperável das conversas sobre o ZABBIX_MONITOR: objetivos, infraestrutura referida, experiências técnicas, componentes discutidos, decisões de orientação, propostas de integração, problemas históricos e próximos passos.

O documento distingue deliberadamente:

- **Confirmado no repositório:** informação verificada diretamente no GitHub.
- **Registo histórico:** informação relatada em conversas ou observada num momento anterior, que pode já ter mudado.
- **Planeado/proposto:** arquitetura ou funcionalidade discutida, mas sem evidência suficiente de implementação completa.
- **Pendente de validação:** ponto que exige nova inspeção técnica, teste ou evidência reproduzível.

A consolidação representa o histórico recuperável disponível nesta revisão, não uma garantia de que cada mensagem de todos os chats antigos foi integralmente recuperada. Quando não existe evidência atual, o documento não declara a funcionalidade como concluída.

## 2. Resumo executivo

O ZABBIX_MONITOR tem como objetivo desenvolver um ecossistema modular de monitorização e observabilidade de TI, com o Zabbix como componente central e um servidor Ubuntu como infraestrutura-base. O sistema deverá permitir acompanhar a disponibilidade e o desempenho de servidores, serviços, redes, aplicações e dispositivos conectados, com alertas, visualização, automação e integração IoT quando justificados.

A intenção é evoluir de uma máquina e serviços reais para uma solução documentada, reproduzível, segura e demonstrável a empresas. O projeto deverá privilegiar evidências técnicas, alterações rastreáveis, validação antes de promoção e separação clara entre serviços existentes e integrações futuras.

## 3. Identidade do projeto e estado do GitHub

### 3.1 Metadados confirmados

Na inspeção do GitHub realizada em 24 de outubro de 2026, foram confirmados os seguintes elementos:

- Repositório público: https://github.com/carlos-andrade/ZABBIX_MONITOR
- Ramo predefinido: main
- Primeiro commit: “Initial commit”
- Ficheiro inicialmente encontrado na árvore: LICENSE
- Licença declarada: MIT
- Descrição do repositório registada no GitHub:

> ZABBIX_MONITOR É UM ECOSSISTEMA DE MONITORIZAÇÃO DE TI, BASEADO EM ZABBIX E UBUNTU SERVER. INTEGRA VISUALIZAÇÃO, ALERTAS, AUTOMAÇÃO E IOT PARA ACOMPANHAR INFRAESTRUTURAS, REFORÇAR A SEGURANÇA, PREVENIR INCIDENTES E GARANTIR A CONTINUIDADE OPERACIONAL, COM ARQUITETURA MODULAR E ESCALÁVEL PARA EMPRESAS.

A árvore consultada continha apenas o ficheiro LICENSE. Não foi encontrado um README.md, código de aplicação, inventário de infraestrutura, configuração versionada ou testes nessa inspeção. Este documento é, portanto, a primeira consolidação documental proposta para o repositório; a sua criação não significa que os serviços descritos estejam todos configurados ou integrados.

### 3.2 Licença

O ficheiro LICENSE declara a licença MIT e direitos de autor de Carlos Andrade em 2026. A licença permite utilização, modificação e distribuição nos termos definidos no próprio ficheiro. A licença não constitui, por si só, uma validação de segurança, qualidade ou prontidão para produção.

### 3.3 Governação do ramo principal

Na inspeção inicial, o ramo main não estava protegido. Recomenda-se avaliar a proteção do ramo principal, revisão de alterações e verificações automáticas antes de aceitar mudanças relevantes. Esta é uma recomendação, não uma alteração já aplicada.

## 4. Objetivos e âmbito

### 4.1 Objetivos funcionais

1. Centralizar a monitorização de infraestrutura e serviços.
2. Recolher métricas, estados, eventos e logs relevantes.
3. Detetar falhas e anomalias através de triggers e regras verificáveis.
4. Notificar os responsáveis por canais configurados e testados.
5. Disponibilizar dashboards e vistas operacionais.
6. Automatizar tarefas de diagnóstico e resposta de forma controlada.
7. Integrar, quando necessário, sistemas IoT e telemetria.
8. Manter documentação operacional, inventário e procedimentos de recuperação.
9. Preparar uma solução que possa ser demonstrada e adaptada a ambientes empresariais.

### 4.2 Princípios de desenvolvimento

- Modularidade e separação de responsabilidades.
- Segurança por defeito e princípio do menor privilégio.
- Proteção de segredos; nunca guardar palavras-passe, tokens ou chaves privadas no repositório.
- Reprodutibilidade de instalações e configurações.
- Alterações pequenas, rastreáveis e com possibilidade de reversão.
- Validação baseada em evidências, logs e resultados de teste.
- Documentação explícita de pressupostos, dependências e limitações.
- Nenhuma integração será considerada concluída apenas porque um contentor está em execução.
- Nenhum estado histórico será tratado como estado atual sem nova verificação.

## 5. Infraestrutura conhecida

### 5.1 Servidor Ubuntu

Em conversas anteriores, o utilizador confirmou que possui uma máquina/servidor Ubuntu e esclareceu que o objetivo de apresentar a saída dos comandos era provar a existência dessa infraestrutura, não iniciar imediatamente uma alteração técnica. O nome de host referido em registos anteriores é **ubuntuserver**.

O projeto deverá manter um inventário explícito com, no mínimo:

- Nome do host e função.
- Versão exata do Ubuntu e kernel.
- CPU, memória, armazenamento e interfaces de rede.
- Endereços e portas necessários à operação, evitando publicar dados sensíveis.
- Serviços instalados e respetivas versões.
- Serviços ativos, estado de arranque e dependências.
- Volumes persistentes, política de backup e recuperação.
- Exposição de rede, firewall e acessos administrativos.

**Limitação:** nesta consolidação não foi recolhida uma nova saída do servidor. Por isso, a versão atual do Ubuntu, o estado atual de todos os serviços, a capacidade de hardware e a configuração de rede devem ser confirmados diretamente na máquina.

### 5.2 Zabbix Agent — registo histórico

Um registo de junho de 2025 indicava que o Zabbix Agent no host ubuntuserver escutava na porta TCP 10050 em IPv4 e IPv6. O mesmo diagnóstico histórico registava rejeições de ligações locais e a configuração de hosts permitidos com o endereço 192.168.60.142. Na altura, a ferramenta zabbix_get não estava disponível.

Estes dados são pistas para auditoria, não uma afirmação sobre a configuração atual. É necessário verificar a versão e o modo do agente, os parâmetros Server/ServerActive/Hostname, os endereços autorizados, a conectividade a partir do servidor Zabbix e os logs atuais. Não se deve abrir a porta 10050 indiscriminadamente à Internet.

### 5.3 Contentores e ChirpStack — registos históricos

Em fevereiro de 2026 foi discutida e tentada uma stack Docker Compose para ChirpStack, com componentes como ChirpStack, PostgreSQL, Redis e Mosquitto. O arranque inicial teve um conflito porque a porta 1883 do host já estava ocupada. Foi sugerido identificar o serviço que ocupava a porta e decidir de forma explícita qual broker MQTT deveria ser usado, em vez de parar serviços sem diagnóstico.

Numa inspeção de terminal mais recente, foi mostrada uma lista de contentores que incluía, pelo menos, um contentor Mosquitto baseado em eclipse-mosquitto:2 e um serviço ChirpStack REST API, ambos apresentados como ativos naquele instante. A saída partilhada estava incompleta; não permite declarar que toda a stack, a persistência, o gateway LoRaWAN ou a integração com Zabbix funcionam corretamente.

O estado atual deve ser reavaliado com docker ps, docker compose ps, logs relevantes e inspeção das portas e volumes. Não se deve alterar nem reiniciar o ambiente antes de recolher o estado e compreender as dependências.

## 6. Componentes tecnológicos discutidos

A tabela abaixo separa o papel previsto do estado comprovado.

| Componente | Papel previsto | Estado documental |
|---|---|---|
| Ubuntu Server | Base de infraestrutura | Existência confirmada pelo utilizador; versão atual por verificar |
| Zabbix Server/Agent | Monitorização e alertas | Zabbix referido como existente; versões e estado atuais por validar |
| MySQL | Base de dados possível para Zabbix, conforme instalação | Discutido em contexto de arquitetura; estado atual por verificar |
| Grafana | Dashboards e visualização complementar | Proposto; integração completa não comprovada |
| Postfix | Transporte de correio eletrónico | Discutido como componente de notificações; estado atual por verificar |
| Mailgun | Entrega de email através de serviço externo | Proposto como opção complementar; integração não comprovada |
| n8n | Automação de fluxos de trabalho | Proposto; integração não comprovada |
| Docker / Docker Compose | Isolamento e execução de serviços adicionais | Utilização de contentores observada em registos; configuração integral por auditar |
| MQTT / Mosquitto | Transporte de mensagens de telemetria | Contentor Mosquitto observado num snapshot; integração funcional por validar |
| ChirpStack | Gestão de rede LoRaWAN | Serviços discutidos e alguns contentores observados; operação ponta a ponta por validar |
| PostgreSQL / Redis | Dependências possíveis para a stack ChirpStack | Incluídos na arquitetura proposta; estado atual por verificar |
| TimescaleDB / InfluxDB | Armazenamento temporal para dados especializados | Proposta histórica para dados de mercado; não assumir implementação |
| Python | Coletores, verificações e automações específicas | Proposto para integrações e recolha de dados; scripts operacionais não comprovados |
| Squid / Nginx / Zabbix Proxy | Componentes possíveis para proxy, acesso ou monitorização distribuída | Discutidos em arquitetura mais ampla; não fazem parte do núcleo confirmado |

A seleção final deverá evitar componentes redundantes. Cada serviço precisa de uma justificação, responsável, dependências, estratégia de atualização, política de backup e teste de aceitação.

## 7. Arquiteturas e integrações discutidas

### 7.1 Monitorização central

Fluxo de referência:

1. Hosts e serviços produzem métricas e estados.
2. Agentes, verificações de rede ou integrações recolhem os dados.
3. O Zabbix Server processa itens, triggers, eventos e notificações.
4. Dashboards apresentam o estado operacional.
5. Procedimentos de resposta orientam o diagnóstico e a recuperação.

Este é o modelo funcional de referência. A topologia concreta, a base de dados, os proxies e os métodos de recolha dependem do inventário real.

### 7.2 Notificações por email

Postfix e Mailgun foram discutidos como componentes possíveis para entrega de alertas. A configuração deverá definir claramente o papel de cada um, evitando duplicação de relay ou caminhos de envio difíceis de diagnosticar.

Os testes deverão confirmar: evento de teste, execução da ação, autenticação SMTP, aceitação pelo relay, entrega ao destinatário e registos de erro. SPF, DKIM e DMARC são aspetos de configuração do domínio remetente quando aplicáveis. Credenciais SMTP devem ficar fora do Git, em armazenamento de segredos ou ficheiros protegidos.

Em julho de 2025 foi proposto um artefacto de teste de email, com referência a um log em /tmp/log_teste_alerta_zabbix.txt, um item, uma trigger, uma action e validação nos logs de email. O registo disponível não comprova que esse teste tenha sido executado com sucesso; deve ser tratado como procedimento proposto até existir evidência.

### 7.3 Automação com n8n

O n8n foi considerado para coordenar fluxos entre alertas, serviços externos e operações automatizadas. A automação deverá começar com ações de baixo risco, registar entradas e resultados, limitar permissões e impedir ciclos de alertas ou ações repetidas. Ações destrutivas ou que afetem produção devem exigir controlo adicional.

### 7.4 IoT, MQTT e LoRaWAN

A arquitetura de referência discutida foi:

**Dispositivo → gateway LoRaWAN → ChirpStack → MQTT → consumidores de dados e persistência.**

Mosquitto foi considerado broker MQTT. PostgreSQL e Redis foram discutidos como dependências da stack ChirpStack. A integração futura com Zabbix, n8n, Postfix ou Mailgun deve ser feita por interfaces explícitas e testadas.

Parâmetros como região LoRaWAN, configuração de gateway, plano de frequências, RX2 e credenciais dependem do equipamento e da região de operação. A configuração europeia EU868 foi mencionada como hipótese de trabalho, não como instalação validada. É necessário verificar a região e a configuração efetivas antes de ligar gateways ou dispositivos.

### 7.5 Dados de mercado — proposta separada

Em agosto de 2025 foi discutida uma arquitetura opcional para recolha de dados de mercado, com coletores Python, TimescaleDB para séries como candles/VWAP/GAP, InfluxDB para ticks em tempo real, Grafana para visualização e Zabbix para alertas de disponibilidade. Esta linha é uma proposta de integração especializada, não requisito obrigatório do núcleo de monitorização empresarial.

Caso seja retomada, deverá ter limites claros de âmbito, fontes de dados autorizadas, regras de retenção, qualidade dos dados e separação dos dados de negócio dos dados operacionais do Zabbix.

### 7.6 Proxy, web e monitorização distribuída — proposta histórica

Também foram discutidos Squid, Nginx, Postfix, Zabbix Server/Proxy, logs, firewall e SSL. Não há evidência suficiente nesta consolidação para afirmar que estes componentes tenham sido instalados como uma stack integrada. A adoção deve depender de requisitos concretos, não da mera possibilidade técnica.

## 8. Segurança e operação

A implementação deve estabelecer, documentar e testar os seguintes controlos:

- Acesso administrativo limitado e autenticação forte.
- Firewall com exposição mínima das portas necessárias.
- Separação entre redes de administração, serviços e dispositivos, quando aplicável.
- Segredos fora do repositório e sem exposição em logs.
- TLS para interfaces e integrações quando aplicável.
- Atualizações planeadas de sistema operativo, Zabbix, imagens e dependências.
- Backups consistentes de base de dados, configuração, volumes e ficheiros necessários à recuperação.
- Testes periódicos de restauro; a existência de um backup sem teste de restauro não prova recuperabilidade.
- Sincronização horária e retenção adequada de logs.
- Monitorização do próprio sistema de monitorização: espaço em disco, base de dados, filas, processos, conectividade e envio de alertas.
- Registo de alterações, incidentes, causa-raiz e ações corretivas.

Não foram confirmados nesta revisão resultados atuais de auditoria de segurança, backup/restauro, recuperação de desastre ou testes de carga.

## 9. Método de validação e evidências

Uma funcionalidade só deve ser marcada como concluída quando existir evidência verificável. Para cada componente, registar:

1. Requisito e finalidade.
2. Versão e configuração relevante, sem segredos.
3. Comando ou procedimento de teste.
4. Resultado observado e timestamp.
5. Logs ou saída relevante, com dados sensíveis removidos.
6. Critério de aceitação e resultado PASS/FAIL.
7. Limitações conhecidas e ação seguinte.
8. Referência ao commit que introduziu a alteração.

Estados recomendados:

- **POR FAZER:** não implementado.
- **EM IMPLEMENTAÇÃO:** alterações em curso.
- **PENDENTE DE VALIDAÇÃO:** implementação alegada ou parcial sem evidência suficiente.
- **VALIDADO:** critérios de aceitação satisfeitos e evidências registadas.
- **BLOQUEADO:** impedimento identificado, com causa e ação de desbloqueio.

Um contentor em estado Up, um serviço instalado ou uma porta aberta não demonstram, isoladamente, que a função de negócio está operacional.

## 10. Roadmap consolidado

### Fase 0 — Baseline e inventário

- Recolher estado atual do Ubuntu e do host ubuntuserver.
- Capturar versões, serviços, contentores, portas, volumes e utilização de recursos.
- Confirmar versão e arquitetura do Zabbix.
- Registar o estado atual antes de alterar qualquer serviço.
- Classificar factos atuais, histórico e hipóteses.

**Critério de saída:** inventário datado, reprodutível e sem segredos.

### Fase 1 — Documentação e governação

- Manter este documento como histórico técnico consolidado.
- Criar README.md com uma apresentação curta e ligação para esta documentação.
- Definir convenções para commits, alterações, testes e incidentes.
- Avaliar proteção do ramo main e validações automáticas.
- Definir onde ficam os runbooks e os registos de evidência.

**Critério de saída:** documentação coerente e processo de alteração definido.

### Fase 2 — Validar o núcleo Zabbix

- Confirmar saúde do servidor, agente(s), base de dados e frontend.
- Validar conectividade e parâmetros de hosts autorizados.
- Testar itens, triggers, eventos e histórico de dados.
- Rever logs e capacidade de armazenamento.

**Critério de saída:** monitorização ponta a ponta comprovada num host de teste.

### Fase 3 — Alertas e email

- Definir o percurso de envio e a função de cada serviço de email.
- Validar autenticação e configuração do remetente.
- Executar um teste controlado de trigger/action/entrega.
- Documentar falhas, retentativas e procedimento de diagnóstico.

**Critério de saída:** alerta recebido e evidência guardada.

### Fase 4 — Dashboards e operação

- Definir indicadores operacionais prioritários.
- Decidir se Grafana acrescenta valor face ao frontend Zabbix para cada caso.
- Criar dashboards com fonte, unidades e intervalos claros.
- Definir retenção, permissões e revisão periódica.

**Critério de saída:** dashboards úteis com dados verificados.

### Fase 5 — Docker, MQTT e ChirpStack

- Inspecionar a stack atual antes de qualquer mudança.
- Resolver de forma documentada conflitos de portas.
- Validar volumes, reinício, persistência, healthchecks e logs.
- Confirmar o percurso real de uma mensagem MQTT.
- Validar gateway e dispositivo LoRaWAN antes de declarar integração ponta a ponta.

**Critério de saída:** mensagem de teste rastreada desde a origem até ao consumidor esperado.

### Fase 6 — Automação

- Selecionar um caso de uso de baixo risco.
- Definir permissões, deduplicação, limites, logs e tratamento de falhas.
- Testar em ambiente controlado.
- Exigir aprovação adicional para operações destrutivas.

**Critério de saída:** fluxo reproduzível, auditável e com falhas controladas.

### Fase 7 — Segurança, backup e recuperação

- Rever acessos, firewall, TLS e segredos.
- Definir política de backup e retenção.
- Testar restauro.
- Preparar runbooks de incidentes e recuperação.

**Critério de saída:** controlos documentados e testes de recuperação bem-sucedidos.

### Fase 8 — Demonstração empresarial

- Preparar arquitetura e inventário atualizados.
- Demonstrar um incidente de teste, a deteção, o alerta e o diagnóstico.
- Distinguir funcionalidades validadas de funcionalidades futuras.
- Documentar pré-requisitos, limites, manutenção e modelo de implantação.

**Critério de saída:** demonstração repetível com evidência técnica.

## 11. Estrutura documental recomendada

A estrutura abaixo é uma proposta de organização futura, não uma descrição dos diretórios que já existiam no momento da inspeção inicial:

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

A estrutura deve crescer conforme surjam artefactos reais. Evitar diretórios vazios sem finalidade e não copiar segredos, dumps de produção ou logs sensíveis para o Git.

## 12. Decisões e orientação já estabelecidas

1. O projeto tem como nome ZABBIX_MONITOR.
2. O Zabbix é o núcleo de monitorização pretendido.
3. Existe uma máquina/servidor Ubuntu que serve de base ao trabalho.
4. A prioridade inicial é documentar e reconhecer a infraestrutura real antes de ampliar a arquitetura.
5. Ferramentas adicionais devem complementar o núcleo, não ser instaladas sem justificação.
6. O projeto deve ser modular, escalável, documentado e adequado a uma futura demonstração empresarial.
7. O estado de execução dos serviços deve ser separado da validação funcional.
8. O repositório GitHub é o ponto de controlo de versão e documentação do projeto.

## 13. Pendências prioritárias

- [ ] Criar e manter um README.md na raiz.
- [ ] Recolher novamente o inventário atual do servidor Ubuntu.
- [ ] Confirmar versões e estado atual do Zabbix Server, Agent, frontend e base de dados.
- [ ] Verificar a configuração atual da porta 10050 e dos hosts autorizados.
- [ ] Capturar a lista completa dos contentores, redes, volumes e portas Docker.
- [ ] Diagnosticar a origem do conflito histórico da porta MQTT 1883 e confirmar o estado atual.
- [ ] Confirmar quais os componentes efetivamente integrados: email, Grafana, n8n, MQTT e ChirpStack.
- [ ] Executar e registar um teste de alerta de ponta a ponta.
- [ ] Definir e testar backup e restauro.
- [ ] Avaliar proteção do ramo main e automatização de validações.
- [ ] Só depois promover componentes para estado VALIDADO.

As caixas permanecem por marcar até haver evidência atual correspondente.

## 14. Critério de conclusão do projeto

O ZABBIX_MONITOR não deve ser considerado pronto para produção apenas por ter o Zabbix instalado ou serviços ativos. A prontidão exige, pelo menos:

- Inventário e arquitetura atualizados.
- Monitorização ponta a ponta demonstrada.
- Alertas entregues e testados.
- Controlo de acessos e segredos.
- Backup e restauro verificados.
- Logs e procedimentos operacionais.
- Testes de falha e recuperação proporcionais ao risco.
- Documentação e alterações rastreáveis.
- Limitações conhecidas e responsabilidades operacionais definidas.

## 15. Registo de consolidação

Esta versão consolida o contexto recuperável das conversas anteriores e a inspeção do repositório realizada em 24 de outubro de 2026. Não substitui uma auditoria direta e atual ao servidor. As referências a versões, portas, contentores e configurações históricas devem ser revalidadas antes de executar alterações.

**Próxima ação técnica recomendada:** recolher um snapshot atual do servidor e reconciliá-lo com as secções 5, 6 e 13 antes de instalar, remover ou reconfigurar qualquer componente.
