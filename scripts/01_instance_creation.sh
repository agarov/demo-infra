#!/usr/bin/env bash
# =============================================================
# Étape 1 : Création d'une instance cloud avec Terraform
# =============================================================
# Ce script tourne en LOCAL avant de se connecter au serveur.
# Prérequis :
#   export SCW_ACCESS_KEY="your-access-key"
#   export SCW_SECRET_KEY="your-secret-key"
# =============================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/lib/demo.sh"

clear

section "Étape 1 — Création d'une instance cloud"

p "# Un 'cloud provider' loue des serveurs à la demande via une API"
p "# Scaleway, AWS, GCP, Azure... On paie uniquement ce qu'on utilise"

wait

section "Infrastructure as Code (IaC) avec Terraform"

p "# Plutôt que de cliquer dans une interface web, on décrit l'infra en code"
p "# C'est versionnable, reproductible et collaboratif"

pe "cat $REPO_ROOT/terraform/main.tf"

wait

section "Terraform : initialisation"

p "# terraform init télécharge les providers déclarés dans le fichier"
p "cd terraform"
p "terraform init"

wait

section "Terraform : plan"

p "# terraform plan montre exactement ce qui sera créé/modifié/détruit"
p "# Aucune modification réelle à ce stade"
p "terraform plan"

wait

section "Terraform : apply"

p "# terraform apply crée réellement l'infrastructure"
p "terraform apply -auto-approve"

wait

section "Instance créée ✓"

p "# On récupère l'IP publique depuis l'output Terraform"
p "terraform output server_ip"
p "terraform output ssh_command"

echo ""
echo -e "${BOLD}${GREEN}  ✓  Instance disponible à l'adresse : $SERVER_IP${COLOR_RESET}"
echo -e "${GREY}     → Prochaine étape : s'y connecter via SSH${COLOR_RESET}"
echo ""
