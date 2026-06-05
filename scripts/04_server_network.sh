#!/usr/bin/env bash
# =============================================================
# Étape 4 — SERVER-SIDE : vérification réseau
# =============================================================

SERVER_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SERVER_SCRIPT_DIR/server_lib.sh" -d -n


DEMO_PROMPT="${GREEN}$(whoami)${CYAN}@$(hostname)${COLOR_RESET} $ "

clear

context_banner "SERVEUR DISTANT — $(whoami)@$(hostname)"

section "Interfaces réseau et adresse IP"

pe "ip addr show"

wait

section "Ports en écoute"

p "# ss -tlnp : liste tous les ports TCP en écoute avec le process associé"
pe "ss -tlnp"

wait

section "Rails répond sur le port 3000"

pe "curl -s http://localhost:3000 | head -20"

p "# Mais depuis l'extérieur il faut passer par IP:port — pas pratique"
p "# → On va installer un reverse proxy NGINX devant Rails"

wait
