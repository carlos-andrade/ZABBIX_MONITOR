# CONTRATO DE INTEGRAÇÃO — ZABBIX_MONITOR E PROJETO COM RASPBERRY

**Versão:** 1.0  
**Data:** 24/10/2026  
**Estado:** PROPOSTO — NÃO VALIDADO  
**Repositório complementar:** https://github.com/carlos-andrade/PROJETO-COM-RASPBERRY  
**Documento par no outro repositório:** `docs/projetos/P01_GATEWAY_MONITORAMENTO/arquitetura/CONTRATO_INTEGRACAO_ZABBIX_MONITOR_V1.0.md`

## 1. Objetivo

Formalizar a colaboração do ZABBIX_MONITOR com o P01 — Gateway de Monitorização Remota, preservando a responsabilidade de cada repositório e exigindo validação técnica antes de declarar a integração operacional.

## 2. Responsabilidades do ZABBIX_MONITOR

- Ser a autoridade para configuração central do Zabbix e da infraestrutura Ubuntu Server.
- Registar a versão instalada, dependências, políticas de rede e método de ingestão efetivamente disponível.
- Definir hosts, itens, unidades, triggers, dashboards, retenção e alertas centrais.
- Definir o endpoint autorizado de ingestão e os requisitos de autenticação, certificados e firewall.
- Executar primeiro testes num host/ambiente de teste sem alterar silenciosamente a produção.
- Documentar evidências de receção, atraso, falha, reconexão e duplicação.
- Manter segredos fora do repositório.

O repositório Raspberry é a autoridade sobre hardware, alimentação, pinagem, firmware e serviço do gateway. A configuração do Zabbix não pode presumir essas informações.

## 3. Arquitetura lógica candidata

```text
Raspberry Pi Pico H -> Raspberry Pi Model B V1 S -> SIM800C/rede móvel
                                                    |
                                                    v
                        endpoint autorizado / rede privada / VPN
                                                    |
                                                    v
                                 Ubuntu Server + ZABBIX_MONITOR
                                                    |
                                                    v
                                    Zabbix / triggers / dashboards
```

Esta é uma arquitetura lógica, não uma confirmação da rede disponível. A escolha entre Zabbix trapper/sender, API intermediária HTTPS ou agente ativo permanece pendente da versão instalada, topologia, firewall e condições do operador móvel. Não expor a interface do Zabbix à Internet nem abrir portas por conveniência.

## 4. Contrato de dados

A implementação deve acordar com o repositório Raspberry os seguintes campos mínimos: `schema_version`, `device_id`, `timestamp` UTC, `sequence`, `metric`, `value`, `unit`, `quality`, `firmware_version`, `gateway_version` e `source_status`, quando aplicáveis.

Os nomes dos itens Zabbix, tipos de dados, unidades, intervalos, retenção, host e regras de deduplicação devem ser documentados no lado central. Não converter ausência ou falha de leitura em valor zero.

## 5. Segurança e operação

- Aceitar apenas origens autorizadas.
- Requerer autenticação e autorização explícitas para a ingestão.
- Preferir HTTPS com validação de certificados quando for usada API intermédia.
- Aplicar limites de payload, timeouts, proteção contra repetição e rate limiting conforme o método escolhido.
- Separar credenciais e chaves da configuração versionada.
- Registar erros de ingestão e de validação sem gravar segredos.
- A fase inicial permite telemetria e diagnóstico; comandos remotos de atuação ficam fora do âmbito.
- Alarmes devem diferenciar gateway inativo, canal celular indisponível, endpoint inacessível e dado inválido quando houver evidência para tal.

## 6. Testes de aceitação

| ID | Teste | Critério |
|---|---|---|
| ZR-01 | Inventário | Versão do Zabbix, OS, serviços e configuração relevante registados |
| ZR-02 | Conectividade | Caminho autorizado do gateway ao ponto de ingestão comprovado |
| ZR-03 | Autenticação | Origem não autorizada é rejeitada |
| ZR-04 | Métrica de teste | Host, valor, unidade e timestamp aparecem corretamente |
| ZR-05 | Falha de rede | O sistema não sinaliza entrega bem-sucedida sem confirmação |
| ZR-06 | Recuperação | Reconexão e retransmissão são observáveis e duplicados tratados |
| ZR-07 | Alertas | Alarmes de teste são disparados e recuperam conforme os limiares aprovados |
| ZR-08 | Segredos | Nenhuma credencial de produção se encontra no Git |
| ZR-09 | Rastreabilidade | Versão de firmware/gateway e versão do contrato podem ser identificadas |
| ZR-10 | Operação | Runbook de falha, diagnóstico e recuperação é reproduzível |

Nenhum teste está declarado como aprovado por este documento. Cada teste deve ter registo de ambiente, procedimento, resultado observado e evidência.

## 7. Questões pendentes

1. Versão exata do Zabbix e método de ingestão suportado no servidor existente.
2. Método de acesso a partir da rede móvel: APN privada, VPN/túnel ou endpoint HTTPS intermediário.
3. Política de certificados, autenticação, firewall e autorização.
4. Identificador inicial do gateway, nomes das métricas, unidades e intervalos.
5. Retenção, fila local, comportamento em perda prolongada de conectividade e deduplicação.
6. Confirmação por teste do suporte a dados IP do módulo SIM800C concreto, cobertura e serviço fornecido pelo operador.

## 8. Promoção de estado

Estado atual: **PROPOSTO — NÃO VALIDADO**. O componente central só pode ser declarado integrado depois de os testes ponta a ponta serem aprovados, com evidências versionadas. O documento técnico par deve ser atualizado em conjunto sempre que o contrato mudar.

## 9. Histórico

| Versão | Data | Alteração | Estado |
|---|---|---|---|
| 1.0 | 24/10/2026 | Cria a definição inicial de colaboração com o gateway Raspberry | PROPOSTO — NÃO VALIDADO |
