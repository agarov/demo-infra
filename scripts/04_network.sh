#!/usr/bin/env bash
# =============================================================
# Étape 4 — LOCAL : concepts réseau, puis commandes serveur
# =============================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/lib/demo.sh"

clear

section "Étape 4 — Notions de réseau"

section "Adresse IP"

p "# Chaque machine sur Internet a une adresse IP unique"
p "# Notre serveur : $SERVER_IP"

wait

section "Ports"

p "# Un port identifie un service précis sur une machine"
p "# Exemples : SSH=22, HTTP=80, HTTPS=443, Rails=3000"
p "# Rails écoute sur 3000 — accessible uniquement via IP:port pour l'instant"

wait

section "HTTP / HTTPS"

p "# HTTP : HyperText Transfer Protocol — port 80, non chiffré"
p "# HTTPS : HTTP + TLS — port 443, tout est chiffré de bout en bout"

wait

section "DNS — Domain Name System"

p "# Le DNS traduit un nom de domaine en adresse IP"
p "# Comme un annuaire téléphonique : nom → numéro"
pe "dig +short $DOMAIN"

wait

echo ""
echo -e "  Enregistrement DNS à créer chez votre registrar :"
echo -e "  ${BOLD}Type A :${COLOR_RESET}  ${CYAN}$DOMAIN${COLOR_RESET}  →  ${GREEN}$SERVER_IP${COLOR_RESET}"
echo ""

wait

section "Certificat SSL/TLS"

p "# Le certificat permet :"
p "#   1. Authentifier le serveur (vous parlez bien à $DOMAIN)"
p "#   2. Chiffrer les échanges (personne ne peut espionner)"
p "# Let's Encrypt fournit des certificats gratuits et automatiques"

wait

section "Vérification des ports sur le serveur"

p "ssh $APP_USER@$SERVER_IP"
scp "$SCRIPT_DIR/demo-magic/demo-magic.sh" \
    "$SCRIPT_DIR/server_lib.sh" \
    "$SCRIPT_DIR/04_server_network.sh" \
    "$APP_USER@$SERVER_IP:~/" > /dev/null 2>&1
ssh -t "$APP_USER@$SERVER_IP" "bash ~/04_server_network.sh"
clear
context_banner "LOCAL — $(hostname)"
