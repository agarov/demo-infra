#!/usr/bin/env bash
# =============================================================
# Étape 3 — LOCAL : présentation du contexte, transition serveur
# =============================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/lib/demo.sh"

clear

section "Étape 3 — Installation de Ruby on Rails"

# Upload demo-magic and server-side script
scp "$SCRIPT_DIR/demo-magic/demo-magic.sh" \
    "$SCRIPT_DIR/03_server_rails.sh" \
    "$SCRIPT_DIR/03_server_apt.sh" \
    "$SCRIPT_DIR/03_server_systemd.sh" \
    "$APP_USER@$SERVER_IP:/home/$APP_USER/" > /dev/null 2>&1

p "# Préparation système (root) : paquets requis pour compiler Ruby"
p "ssh root@$SERVER_IP"
ssh -t "root@$SERVER_IP" "bash /home/$APP_USER/03_server_apt.sh"

wait


p "# On se connecte maintenant en tant qu'utilisateur applicatif"
p "# C'est lui qui possédera l'application et lancera le service"
p "ssh $APP_USER@$SERVER_IP"
ssh -t "$APP_USER@$SERVER_IP" "bash /home/$APP_USER/03_server_rails.sh"

wait

p "# Activation du service systemd (root)"
p "ssh root@$SERVER_IP"
ssh -t "root@$SERVER_IP" "APP_USER=$APP_USER bash /home/$APP_USER/03_server_systemd.sh"
