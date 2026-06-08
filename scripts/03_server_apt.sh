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
pe "export DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=a; apt-get update && apt-get install -y git curl build-essential autoconf libssl-dev libyaml-dev zlib1g-dev libffi-dev libgmp-dev rustc"

wait

p "# Vérification rapide"
pe "gcc --version | head -1"
pe "rustc --version"

echo ""
echo -e "\033[1m\033[0;32m  ✓  Prérequis système Ruby installés\033[0m"
echo ""

wait
systemctl stop demo-app 2>/dev/null || true