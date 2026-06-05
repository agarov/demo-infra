#!/usr/bin/env bash
# =============================================================
# Étape 5 — LOCAL : explication reverse proxy, puis serveur
# =============================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/lib/demo.sh"

clear

section "Étape 5 — Reverse proxy NGINX et SSL"

section "Qu'est-ce qu'un reverse proxy ?"

p "# Un reverse proxy est un intermédiaire entre Internet et votre application"
p "# Il reçoit les requêtes HTTP(S) sur les ports standard (80/443)"
p "# et les redirige vers le backend Rails (port 3000, local uniquement)"
echo ""
echo -e "  Internet"
echo -e "    ${GREY}↓ HTTPS (443)${COLOR_RESET}"
echo -e "  ${BOLD}${BLUE}NGINX${COLOR_RESET} — terminaison SSL, logs, rate limiting, headers..."
echo -e "    ${GREY}↓ HTTP (3000, localhost uniquement)${COLOR_RESET}"
echo -e "  ${BOLD}${GREEN}Rails${COLOR_RESET}"
echo ""

wait

p "# Avantages :"
p "#   - Rails n'a pas à gérer SSL"
p "#   - Port 80/443 (ports privilégiés, root requis) isolé du processus app"
p "#   - NGINX peut servir les assets statiques directement"

wait

section "Installation et configuration sur le serveur"

p "ssh root@$SERVER_IP"
scp "$SCRIPT_DIR/demo-magic/demo-magic.sh" \
    "$SCRIPT_DIR/server_lib.sh" \
    "$SCRIPT_DIR/05_server_nginx.sh" \
    "root@$SERVER_IP:~/" > /dev/null 2>&1
ssh -t "root@$SERVER_IP" "DOMAIN=$DOMAIN bash ~/05_server_nginx.sh"
clear
context_banner "LOCAL — $(hostname)"
