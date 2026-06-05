#!/usr/bin/env bash
# =============================================================
# Étape 5 — SERVER-SIDE : NGINX + Certbot
# Tourne sur le serveur en root
# =============================================================

. ~/demo-magic.sh -d


DEMO_PROMPT="${GREEN}root${CYAN}@$(hostname)${COLOR_RESET} # "
DOMAIN="${DOMAIN:-demo.example.com}"

clear

section() {
  echo ""
  echo -e "\033[1m\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo -e "\033[1m\033[0;37m  $1\033[0m"
  echo -e "\033[1m\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo ""
}

section "Installation de NGINX"

pe "apt install -y nginx"
pe "systemctl status nginx --no-pager"

wait

section "Configuration de NGINX"

pe "cat /home/demoapp/demo-infra/config/nginx.conf"

wait

pe "cp /home/demoapp/demo-infra/config/nginx.conf /etc/nginx/sites-available/demo-app"
pe "ln -s /etc/nginx/sites-available/demo-app /etc/nginx/sites-enabled/demo-app"
pe "rm -f /etc/nginx/sites-enabled/default"

wait

pe "nginx -t"
pe "systemctl reload nginx"

wait

p "# L'app est maintenant accessible sur le port 80"
pe "curl -s http://$DOMAIN | head -20"

wait

section "Certificat SSL avec Certbot (Let's Encrypt)"

p "# Let's Encrypt = autorité de certification gratuite et automatisée"
pe "apt install -y certbot python3-certbot-nginx"

wait

p "# Certbot obtient le certificat et met à jour la config NGINX automatiquement"
pe "certbot --nginx -d $DOMAIN --non-interactive --agree-tos -m admin@$DOMAIN"

wait

p "# Config NGINX mise à jour par certbot — redirection HTTP→HTTPS incluse"
pe "cat /etc/nginx/sites-available/demo-app"

wait

section "Renouvellement automatique"

pe "systemctl status certbot.timer --no-pager"
pe "certbot renew --dry-run"

wait

section "🎉 Résultat final"

pe "curl https://$DOMAIN"

echo ""
echo -e "\033[1m\033[0;32m  ✓  Application accessible sur https://$DOMAIN\033[0m"
echo ""
echo -e "  Récap du parcours :"
echo -e "  \033[0;36m1.\033[0m Instance créée sur Scaleway avec Terraform"
echo -e "  \033[0;36m2.\033[0m Accès SSH, utilisateur applicatif créé"
echo -e "  \033[0;36m3.\033[0m Ruby + Rails installés, service systemd actif"
echo -e "  \033[0;36m4.\033[0m Réseau : IP, ports, DNS, TLS"
echo -e "  \033[0;36m5.\033[0m NGINX reverse proxy + certificat SSL Let's Encrypt"
echo ""

p ""
