#!/usr/bin/env bash
# =============================================================
# Étape 2 — SERVER-SIDE : authorized_keys + utilisateur applicatif
# Ce script tourne sur le serveur via ssh -t
# =============================================================

SERVER_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SERVER_SCRIPT_DIR/server_lib.sh" -d -n


DEMO_PROMPT="${GREEN}root${CYAN}@$(hostname)${COLOR_RESET} # "

clear

APP_USER="${APP_USER:-demoapp}"

context_banner "SERVEUR DISTANT — root@$(hostname)"

section "Inspection de la configuration SSH"

p "# Les clefs autorisées sont stockées dans authorized_keys"
pe "cat /root/.ssh/authorized_keys"

wait

section "Création d'un utilisateur applicatif"

p "# Bonne pratique : ne jamais faire tourner une application en root"
pe "useradd --create-home --shell /bin/bash $APP_USER"
pe "mkdir -p /home/$APP_USER/.ssh"
pe "echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHHQ+p4FUb1FaAvDVEu0oKqH+ID/+ng3wpyEdMiNjIwp arthur.garreau98@gmail.com' > /home/$APP_USER/.ssh/authorized_keys"
pe "chown -R $APP_USER:$APP_USER /home/$APP_USER/.ssh"
pe "chmod 700 /home/$APP_USER/.ssh && chmod 600 /home/$APP_USER/.ssh/authorized_keys"

wait

p "# Vérification"
pe "id $APP_USER"
pe "cat /home/$APP_USER/.ssh/authorized_keys"

wait