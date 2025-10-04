#!/bin/bash
set -e

echo "====================================================="
echo "[DECA CPU Installer] Cross-Platform Environment Setup"
echo "====================================================="

# --- Detect OS ---
OS_TYPE=$(uname | tr '[:upper:]' '[:lower:]')
echo "[INFO] Detected OS: $OS_TYPE"

# --- Check for Python 3.7 ---
if command -v python3.7 &>/dev/null; then
    PYTHON_CMD="python3.7"
elif command -v py &>/dev/null && py -3.7 -c "exit()" 2>/dev/null; then
    PYTHON_CMD="py -3.7"
else
    echo "[ERROR] Python 3.7 not found!"
    echo "Please install Python 3.7 before proceeding."
    echo "On Ubuntu: sudo apt install python3.7 python3.7-venv"
    echo "On Windows: install via https://www.python.org/downloads/release/python-370/"
    exit 1
fi

# --- Create and activate virtual environment ---
if [[ "$OS_TYPE" == *"linux"* || "$OS_TYPE" == *"wsl"* ]]; then
    echo "[INFO] Creating Python 3.7 virtual environment on Linux/WSL..."
    $PYTHON_CMD -m venv env
    source env/bin/activate
elif [[ "$OS_TYPE" == *"mingw"* || "$OS_TYPE" == *"msys"* || "$OS_TYPE" == *"cygwin"* ]]; then
    echo "[INFO] Creating Python 3.7 virtual environment on Windows..."
    $PYTHON_CMD -m venv env
    source env/Scripts/activate
else
    echo "[WARN] Unknown OS type. Defaulting to Linux-style activation."
    $PYTHON_CMD -m venv env
    source env/bin/activate
fi

# --- Upgrade pip ---
echo "[INFO] Upgrading pip, setuptools, and wheel..."
pip install --upgrade pip setuptools wheel

# --- Install core dependencies ---
echo "[INFO] Installing Python dependencies..."
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

# --- Install PyTorch (CPU-only) ---
echo "[INFO] Installing PyTorch 1.6.0 + torchvision (CPU-only)..."
pip install torch==1.6.0+cpu torchvision==0.7.0+cpu \
    -f https://download.pytorch.org/whl/cpu/torch_stable.html

# --- Install PyTorch3D (CPU) ---
echo "[INFO] Installing PyTorch3D v0.3.0 (CPU-only)..."
MAX_JOBS=1 FORCE_CUDA=0 pip install --no-build-isolation \
    "git+https://github.com/facebookresearch/pytorch3d.git@v0.3.0"

echo "====================================================="
echo "[SUCCESS] DECA (CPU Edition) Installed Successfully!"
echo "Activate environment with:"
if [[ "$OS_TYPE" == *"linux"* || "$OS_TYPE" == *"wsl"* ]]; then
    echo "source env/bin/activate"
else
    echo "env\\Scripts\\activate"
fi
echo "====================================================="
