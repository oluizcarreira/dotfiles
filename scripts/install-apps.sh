#!/bin/bash

# Garante que o script para se houver erro crítico
set -e

echo "--- Iniciando instalação de aplicações Flatpak ---"

# 1. Garante que o repositório Flathub está configurado
echo "A verificar repositório Flathub..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# 2. Lista de aplicações Flatpak
APPS=(
    org.freedesktop.Piper
    com.rtosta.zapzap
    com.google.Chrome
    com.brave.Browser
    io.dbeaver.DBeaverCommunity
    com.discordapp.Discord
    org.localsend.localsend_app
    com.visualstudio.code
    com.obsproject.Studio
    org.onlyoffice.desktopeditors
    org.prismlauncher.PrismLauncher
    com.valvesoftware.Steam
    io.mrarm.mcpelauncher
)

# 3. Instalação individual com tolerância a falhas
for app in "${APPS[@]}"; do
    echo ">> A instalar: $app..."
    if flatpak install -y flathub "$app"; then
        echo "✓ $app instalado com sucesso."
    else
        echo "⚠ Falha ao instalar $app (verifique o ID no Flathub)."
    fi
done

# 4. Ajustes de permissões (Flatpak Overrides)
echo "A aplicar permissões específicas de Flatpak..."
# Permite ao VS Code comunicar com ferramentas do host e motores de contentores
flatpak override --user --talk-name=org.freedesktop.Flatpak com.visualstudio.code 2>/dev/null || true
# Permite ao DBeaver ler chaves SSH para túneis em bases de dados remotas
flatpak override --user --filesystem=~/.ssh:ro io.dbeaver.DBeaverCommunity 2>/dev/null || true

echo "--- Instalação de aplicações concluída com sucesso! ---"