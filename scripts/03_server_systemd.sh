#!/usr/bin/env bash
# =============================================================
# Étape 3C — SERVER-SIDE (root) : installation du service systemd
# =============================================================

SERVER_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SERVER_SCRIPT_DIR/server_lib.sh" -d -n

DEMO_PROMPT="${GREEN}root${CYAN}@$(hostname)${COLOR_RESET} # "
APP_USER="${APP_USER:-demoapp}"
APP_HOME="/home/$APP_USER"

clear

context_banner "SERVEUR DISTANT — root@$(hostname)"

section "systemd : installation du service Rails"

p "# Le fichier service est versionné dans le repo"
pe "cat $APP_HOME/demo-infra/config/demo-app.service"

wait

p "# Installation et démarrage du service"
pe "cp $APP_HOME/demo-infra/config/demo-app.service /etc/systemd/system/demo-app.service"
pe "systemctl daemon-reload"
pe "systemctl enable demo-app"
pe "systemctl restart demo-app"

echo ""
echo -e "\033[1m\033[0;32m  ✓  Rails tourne en tant que service systemd\033[0m"
echo -e "\033[0;90m     Persistant au reboot, redémarre automatiquement en cas de crash\033[0m"
echo ""

wait