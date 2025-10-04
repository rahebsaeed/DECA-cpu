#!/bin/bash
# ===============================================================
# fetch_data.sh - Download all DECA model files into ./data/
# ===============================================================

set -e  # Stop on first error

# Ensure data directory exists
mkdir -p data

cd data

echo "=== Downloading all required DECA and FLAME models into ./data ==="

# Download FLAME models
wget -O generic_model.pkl "https://huggingface.co/camenduru/show/resolve/064a379f415f674051145ec4862f54bd6a65073f/models/models_MICA/FLAME2020/generic_model.pkl?download=true"
wget -O female_model.pkl "https://huggingface.co/camenduru/show/resolve/064a379f415f674051145ec4862f54bd6a65073f/models/models_MICA/FLAME2020/female_model.pkl?download=true"
wget -O male_model.pkl "https://huggingface.co/camenduru/show/resolve/064a379f415f674051145ec4862f54bd6a65073f/models/models_MICA/FLAME2020/male_model.pkl?download=true"

# Download DECA model
wget -O deca_model.tar "https://huggingface.co/camenduru/show/resolve/d95d9e7901b981d744390e052e05432499d3106c/models/models_deca/data/deca_model.tar?download=true"

# Download FLAME albedo model
wget -O FLAME_albedo_from_BFM.npz "https://huggingface.co/camenduru/TalkingHead/resolve/main/FLAME_albedo_from_BFM.npz?download=true"

# Extract DECA model directly into ./data
echo "=== Extracting deca_model.tar into ./data ==="
tar -xvf deca_model.tar

echo "All model files successfully downloaded and extracted into ./data/"
