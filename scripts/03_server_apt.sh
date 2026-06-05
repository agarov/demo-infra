#!/usr/bin/env bash
# =============================================================
# Étape 3A — SERVER-SIDE (root) : dépendances système Ruby/Rails
# =============================================================

SERVER_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SERVER_SCRIPT_DIR/server_lib.sh" -d -n

DEMO_PROMPT="${GREEN}root${CYAN}@$(hostname)${COLOR_RESET} # "

clear

context_banner "SERVEUR DISTANT — root@$(hostname)"

section "Préparation système pour Ruby/Rails"

p "# Installation des paquets nécessaires à ruby-build (compilation Ruby)"
pe "export DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=a; apt-get update && apt-get install -y git curl build-essential rustc perl pkg-config libssl-dev libreadline-dev zlib1g-dev libyaml-dev libffi-dev libgmp-dev sqlite3 libsqlite3-dev"

wait

p "# Vérification rapide"
pe "gcc --version | head -1"
pe "perl --version | head -2"
pe "pkg-config --modversion openssl"

echo ""
echo -e "\033[1m\033[0;32m  ✓  Prérequis système Ruby installés\033[0m"
echo ""

wait
systemctl stop demo-app 2>/dev/null || true