#!/usr/bin/env bash
# =============================================================
# Étape 3 — SERVER-SIDE : Ruby, Rails, systemd
# Tourne sur le serveur en tant qu'utilisateur applicatif
# =============================================================

SERVER_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SERVER_SCRIPT_DIR/server_lib.sh" -d -n


DEMO_PROMPT="${GREEN}$(whoami)${CYAN}@$(hostname)${COLOR_RESET} $ "

clear

context_banner "SERVEUR DISTANT — $(whoami)@$(hostname)"

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

p "# Compilation de Ruby 4.0.5 avec make parallèle (quelques minutes)"
pe 'MAKE_OPTS="-j$(nproc)" RUBY_CONFIGURE_OPTS="--disable-install-doc" rbenv install -s 4.0.5'
pe "rbenv global 4.0.5"
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

echo ""
echo -e "\033[1m\033[0;32m  ✓  Ruby et Rails installés côté utilisateur applicatif\033[0m"
echo -e "\033[0;90m     Le service systemd sera activé ensuite via le script root dédié\033[0m"
echo ""

wait