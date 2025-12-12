#!/bin/bash

# Instalador do MelonDS para Linux Mint 22.1
# Compila a última versão do GitHub com todas as dependências
# criado por Hudson Albuquerque (hud.and@yandex.com)

set -e

echo "=========================================="
echo "Instalador do MelonDS para Linux Mint 22.1"
echo "=========================================="
echo ""

# Verificar se está rodando como root
if [ "$EUID" -eq 0 ]; then 
    echo "ERRO: Não execute este script como root/sudo"
    echo "O script pedirá sudo quando necessário"
    exit 1
fi

# Atualizar repositórios
echo "[1/5] Atualizando repositórios..."
sudo apt update

# Instalar dependências
echo ""
echo "[2/5] Instalando dependências..."
sudo apt install -y \
    build-essential \
    cmake \
    git \
    pkg-config \
    qt6-base-dev \
    qt6-multimedia-dev \
    qt6-base-private-dev \
    libqt6svg6-dev \
    libsdl2-dev \
    libarchive-dev \
    libzstd-dev \
    libfaad-dev \
    libenet-dev \
    extra-cmake-modules \
    libgl1-mesa-dev \
    libxkbcommon-dev

echo ""
echo "[3/5] Baixando código-fonte do MelonDS..."
# Criar diretório temporário
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Clonar repositório
git clone https://github.com/melonDS-emu/melonDS.git
cd melonDS

echo ""
echo "[4/5] Compilando MelonDS..."
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j$(nproc)

echo ""
echo "[5/5] Instalando MelonDS..."
sudo cmake --install build

# Limpar arquivos temporários
echo ""
echo "Limpando arquivos temporários..."
cd ~
rm -rf "$TEMP_DIR"

echo ""
echo "=========================================="
echo "✓ Instalação concluída com sucesso!"
echo "=========================================="
echo ""
echo "Para iniciar o MelonDS, execute: melonDS"
echo "ou procure por 'melonDS' no menu de aplicativos"
echo ""
