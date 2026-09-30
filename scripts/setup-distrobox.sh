#!/bin/bash

# Garante que o script para se houver erro
set -e

echo "--- Provisionamento de Ambientes Distrobox ---"

# 1. Dev Box (Ubuntu LTS)
if ! distrobox list | grep -q "dev-box"; then
    echo "A criar dev-box (Ubuntu LTS)..."
    distrobox create --image docker.io/library/ubuntu:lts --name dev-box --yes
    
    echo "A instalar dependências essenciais dentro da dev-box..."
    distrobox enter dev-box -- bash -c "sudo apt update && sudo apt install -y build-essential curl git pkg-config libssl-dev libpq-dev python3-dev"
else
    echo "dev-box já existe."
fi

# 2. DaVinci Box (Rocky Linux 9 com aceleração Nvidia)
if ! distrobox list | grep -q "davinci-box"; then
    echo "A criar davinci-box (Rocky Linux 9)..."
    distrobox create --image quay.io/rockylinux/rockylinux:9 --name davinci-box --nvidia --yes
else
    echo "davinci-box já existe."
fi

echo "--- Ambientes Distrobox prontos! ---"