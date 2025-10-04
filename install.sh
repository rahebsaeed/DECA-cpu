#!/bin/bash
set -e

echo "[INFO] Creating virtual environment..."
python3 -m venv env
source env/bin/activate

echo "[INFO] Upgrading pip..."
pip install --upgrade pip setuptools wheel

echo "[INFO] Installing base Python packages..."
pip install \
    numpy==1.21.6 \
    scipy==1.7.3 \
    scikit-image==0.19.3 \
    Pillow==9.5.0 \
    imageio==2.31.2 \
    tifffile==2021.11.2 \
    requests==2.28.1 \
    PyYAML==5.1.1 \
    tabulate==0.9.0 \
    termcolor==2.3.0 \
    tqdm==4.67.1 \
    typing_extensions==4.7.1 \
    six==1.17.0 \
    networkx==2.6.3 \
    packaging==24.0 \
    portalocker==2.7.0 \
    zipp==3.15.0 \
    importlib-metadata==6.7.0 \
    face-alignment==1.1.1 \
    kornia==0.4.0 \
    fvcore==0.1.5.post20221221 \
    iopath==0.1.10 \
    yacs==0.1.8 \
    llvmlite==0.39.1 \
    numba==0.56.4 \
    PyWavelets==1.3.0 \
    chumpy==0.70 \
    ninja==1.11.1.4

echo "[INFO] Installing torch + torchvision (CPU-only, PyTorch 1.6)..."
pip install torch==1.6.0+cpu torchvision==0.7.0+cpu \
    -f https://download.pytorch.org/whl/cpu/torch_stable.html

echo "[INFO] Installing PyTorch3D v0.3.0 (CPU-only)..."
MAX_JOBS=1 FORCE_CUDA=0 pip install --no-build-isolation \
    "git+https://github.com/facebookresearch/pytorch3d.git@v0.3.0"

echo "[INFO] Installation complete!"
