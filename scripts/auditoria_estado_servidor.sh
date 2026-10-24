#!/usr/bin/env bash
# ZABBIX_MONITOR — auditoria somente de leitura da Máquina Ubuntu
# Não instala pacotes, não reinicia serviços e não altera configurações.
set -u
export LC_ALL=C

section() { printf '\n\n===== %s =====\n' "$1"; }
run() {
  printf '\n$'
  printf ' %q' "$@"
  printf '\n'
  "$@" 2>&1 || printf '[AVISO] comando terminou com código %s\n' "$?"
}

section "IDENTIFICAÇÃO E DATA"
date -Is
hostname
id
section "SISTEMA OPERATIVO E KERNEL"
cat /etc/os-release 2>/dev/null || true
uname -a
hostnamectl 2>/dev/null || true
section "TEMPO DE ATIVIDADE E RECURSOS"
uptime
free -h 2>/dev/null || true
df -hT
section "SERVIÇOS RELEVANTES"
for svc in zabbix-server zabbix-agent zabbix-agent2 apache2 mysql mariadb postgresql redis-server bind9 named dovecot docker containerd mosquitto postfix; do
  if command -v systemctl >/dev/null 2>&1; then
    printf '%-18s %s\n' "$svc" "$(systemctl is-active "$svc" 2>/dev/null || true)"
  fi
done
section "PACOTES RELEVANTES INSTALADOS"
if command -v dpkg-query >/dev/null 2>&1; then
  dpkg-query -W -f='${binary:Package}\t${Version}\t${db:Status-Abbrev}\n' 2>/dev/null |
    grep -Ei '^(zabbix|apache2|mysql-server|mariadb-server|postgresql|redis-server|bind9|dovecot|docker|containerd|mosquitto|postfix)' || true
fi
section "CONTENTORES DOCKER"
if command -v docker >/dev/null 2>&1; then
  docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}' 2>&1 ||
    printf '[AVISO] docker ps falhou; se for um erro de permissões, execute este script com sudo.\n'
  printf '\n--- Projetos Compose ---\n'
  docker compose ls -a 2>&1 || true
else
  printf 'Docker CLI não encontrado no PATH.\n'
fi
section "PORTAS TCP/UDP EM ESCUTA"
if command -v ss >/dev/null 2>&1; then
  ss -lntup 2>&1 || ss -lntu 2>&1 || true
else
  printf 'Comando ss não disponível.\n'
fi
section "FIREWALL UFW"
if command -v ufw >/dev/null 2>&1; then
  ufw status verbose 2>&1 || true
else
  printf 'UFW não encontrado. Isto não prova que não exista outro firewall.\n'
fi
section "FIM"
printf 'Auditoria apenas de leitura concluída. Rever e redigir dados de rede antes de partilhar publicamente.\n'
