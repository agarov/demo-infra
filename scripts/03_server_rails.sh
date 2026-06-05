#!/usr/bin/env bash
# =============================================================
# Étape 3 — SERVER-SIDE : Ruby, Rails, systemd
# Tourne sur le serveur en tant qu'utilisateur applicatif
# =============================================================

. ~/demo-magic.sh -d -n


DEMO_PROMPT="${GREEN}$(whoami)${CYAN}@$(hostname)${COLOR_RESET} $ "

clear

section() {
  echo ""
  echo -e "\033[1m\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo -e "\033[1m\033[0;37m  $1\033[0m"
  echo -e "\033[1m\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo ""
}

# section "Gestionnaire de paquets : apt"

# p "# apt installe des logiciels depuis les dépôts officiels Ubuntu"
# pe "sudo apt update -qq"
# pe "sudo apt install -y git curl build-essential libssl-dev libreadline-dev zlib1g-dev"

wait

section "Installation de Ruby via rbenv"

p "# rbenv permet de gérer plusieurs versions de Ruby sur la même machine"
pe "[ -d ~/.rbenv ] || git clone https://github.com/rbenv/rbenv.git ~/.rbenv"
pe "[ -d ~/.rbenv/plugins/ruby-build ] || git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build"
pe 'grep -qxF "export PATH=\"\$HOME/.rbenv/bin:\$PATH\"" ~/.bashrc || echo "export PATH=\"\$HOME/.rbenv/bin:\$PATH\"" >> ~/.bashrc'
pe 'grep -qxF "eval \"\$(rbenv init - bash)\"" ~/.bashrc || echo "eval \"\$(rbenv init - bash)\"" >> ~/.bashrc'
p "# Active rbenv immédiatement dans ce shell (source ~/.bashrc est souvent inopérant en non-interactif)"
pe 'export PATH="$HOME/.rbenv/bin:$PATH"'
pe 'eval "$(rbenv init - bash)"'
pe "command -v rbenv"

wait

p "# Compilation de Ruby 3.3.0 (quelques minutes)"
pe 'RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr" rbenv install -s 3.3.0'
pe "rbenv global 3.3.0"
pe "ruby --version"

wait

section "Clone du dépôt"

p "# Ce dépôt contient l'application Rails et tous les fichiers de config"
pe "[ -d ~/demo-infra/.git ] && git -C ~/demo-infra pull --ff-only || git clone https://github.com/agarov/demo-infra.git ~/demo-infra"
pe "cd ~/demo-infra/app"
pe "cat Gemfile"

wait

section "Installation des gems"

pe "gem install bundler --no-document"
pe "bundle install"

wait

section "Premier lancement de Rails"

pe "RAILS_ENV=production SECRET_KEY_BASE_DUMMY=1 rails db:prepare"
pe "RAILS_ENV=production SECRET_KEY_BASE_DUMMY=1 rails server -b 0.0.0.0 -p 3000"

p "# ⚠️  Fonctionne ! Mais s'arrête si on ferme ce terminal"
p "#    Besoin d'un gestionnaire de processus → systemd"

wait

p "# La configuration systemd est maintenant exécutée dans un script root dédié"

echo ""
echo -e "\033[1m\033[0;32m  ✓  Ruby et Rails installés côté utilisateur applicatif\033[0m"
echo -e "\033[0;90m     Le service systemd sera activé ensuite via le script root dédié\033[0m"
echo ""

p ""
