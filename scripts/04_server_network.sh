#!/usr/bin/env bash
# =============================================================
# Étape 4 — SERVER-SIDE : vérification réseau
# =============================================================

. ~/demo-magic.sh -d


DEMO_PROMPT="${GREEN}$(whoami)${CYAN}@$(hostname)${COLOR_RESET} $ "

clear

section() {
  echo ""
  echo -e "\033[1m\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo -e "\033[1m\033[0;37m  $1\033[0m"
  echo -e "\033[1m\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo ""
}

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

p ""
