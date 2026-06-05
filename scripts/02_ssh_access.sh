#!/usr/bin/env bash
# =============================================================
# Étape 2 — LOCAL : présentation SSH et transition vers serveur
# =============================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/lib/demo.sh"

clear

section "Étape 2 — Accès SSH à l'instance"

p "# SSH = Secure Shell : protocole de connexion distante chiffré"
p "# Communication protégée par cryptographie asymétrique — port 22 par défaut"

section "Les clefs SSH"

p "# Une paire de clefs : privée (secrète) + publique (partageable)"
pe "ls -la ~/.ssh/"

p "# Si pas encore de clef, voici la commande (pour info — ne pas exécuter ici)"
p "# ssh-keygen -t ed25519 -C 'workshop@demo'"


p "# On affiche la clef publique existante — celle qui est déjà sur le serveur"
pe "cat ~/.ssh/id_ed25519.pub"

wait 

section "Connexion au serveur"

# Upload demo-magic and the server-side script
scp "$SCRIPT_DIR/demo-magic/demo-magic.sh" \
    "$SCRIPT_DIR/02_server_setup.sh" \
    "root@$SERVER_IP:/root/"

p "# Format : ssh user@host — le user 'root' est disponible par défaut (Scaleway)"
p "ssh root@$SERVER_IP"
wait
ssh -t "root@$SERVER_IP" "bash /root/02_server_setup.sh"

section "✓ Connexion possible maintenant avec l'utilisateur applicatif"
p "# Depuis votre machine locale :"
p "ssh $APP_USER@$SERVER_IP"
wait
ssh -t "$APP_USER@$SERVER_IP" "whoami"

p ""