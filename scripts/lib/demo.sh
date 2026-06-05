#!/usr/bin/env bash
# Shared configuration for all demo scripts

_LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_MAGIC_DIR="$_LIB_DIR/../demo-magic"
REPO_ROOT="$(cd "$_LIB_DIR/../.." && pwd)"

# ============================================================
# CONFIGURATION — update these before the live demo
# ============================================================
export SERVER_IP="${SERVER_IP:-1.2.3.4}"
export DOMAIN="${DOMAIN:-demo-infra-alpha.cheerz.com}"
export APP_USER="${APP_USER:-demoapp}"
# ============================================================

# Load demo-magic
if [[ ! -f "$DEMO_MAGIC_DIR/demo-magic.sh" ]]; then
  echo ""
  echo "  ERROR: demo-magic not found."
  echo "  Run: git submodule update --init"
  echo ""
  exit 1
fi

# shellcheck source=/dev/null
. "$DEMO_MAGIC_DIR/demo-magic.sh"

# Demo settings
TYPE_SPEED=200
PROMPT_TIMEOUT=0
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W${COLOR_RESET} $ "

# Print a titled section separator
function section() {
  echo ""
  echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${COLOR_RESET}"
  echo -e "${BOLD}${WHITE}  $1${COLOR_RESET}"
  echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${COLOR_RESET}"
  echo ""
}

function context_banner() {
  echo ""
  echo -e "${BOLD}${CYAN}██████████████████████████████████████████████████${COLOR_RESET}"
  echo -e "${BOLD}${WHITE}  CONTEXTE : $1${COLOR_RESET}"
  echo -e "${BOLD}${CYAN}██████████████████████████████████████████████████${COLOR_RESET}"
  echo ""
}
