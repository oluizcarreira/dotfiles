#!/bin/bash

set -e

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$BASE_DIR/scripts"

echo "=================================================="
echo "    Iniciando Setup do Sistema (Bootstrap)       "
echo "=================================================="

# Torna executáveis todos os scripts auxiliares
chmod +x "$SCRIPTS_DIR"/*.sh

# 1. CLI e configurações do terminal
echo -e "\n[1/3] A executar install-cli.sh..."
bash "$SCRIPTS_DIR/install-cli.sh"

# 2. Contentores de desenvolvimento e trabalho
echo -e "\n[2/3] A executar setup-distrobox.sh..."
bash "$SCRIPTS_DIR/setup-distrobox.sh"

# 3. Aplicações gráficas Flatpak
echo -e "\n[3/3] A executar install-apps.sh..."
bash "$SCRIPTS_DIR/install-apps.sh"

echo ""
echo "=================================================="
echo "    Configuração concluída com sucesso!           "
echo "=================================================="
echo "Reinicie a sessão ou o terminal para carregar o novo ambiente."