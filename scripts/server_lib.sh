#!/usr/bin/env bash
# Shared helpers for scripts executed on the remote server.

_SERVER_LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ ! -f "$_SERVER_LIB_DIR/demo-magic.sh" ]]; then
  echo ""
  echo "  ERROR: demo-magic.sh not found next to server_lib.sh."
  echo ""
  exit 1
fi

# shellcheck source=/dev/null
. "$_SERVER_LIB_DIR/demo-magic.sh" "$@"

section() {
  echo ""
  echo -e "\033[1m\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo -e "\033[1m\033[0;37m  $1\033[0m"
  echo -e "\033[1m\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo ""
}

context_banner() {
  echo ""
  echo -e "\033[1m\033[0;36m██████████████████████████████████████████████████\033[0m"
  echo -e "\033[1m\033[0;37m  CONTEXTE : $1\033[0m"
  echo -e "\033[1m\033[0;36m██████████████████████████████████████████████████\033[0m"
  echo ""
}