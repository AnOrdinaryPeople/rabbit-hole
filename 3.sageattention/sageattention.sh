#!/bin/bash

BASE="$HOME/cooking"
export CUDA_HOME="$BASE/cuda13"
VENV_DIR="$BASE/.venv"
BUILD_DIR="$BASE/builder"
LIBFFI_VERSION=3.5.2

mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

LIBFFI_DIR="libffi-$LIBFFI_VERSION"

if [ ! -f "$LIBFFI_DIR/configure" ]; then
  curl -LO "https://github.com/libffi/libffi/releases/download/v$LIBFFI_VERSION/$LIBFFI_DIR.tar.gz"
  tar -xf "$LIBFFI_DIR.tar.gz"
else
  make distclean
fi

cd "$LIBFFI_DIR"

PREFIX_FFI="$BUILD_DIR/libffi$LIBFFI_VERSION"

CFLAGS="-fPIC" ./configure --prefix=$PREFIX_FFI --disable-shared --enable-static

make -j$(nproc)
make install

export PKG_CONFIG_PATH="$PREFIX_FFI/lib/pkgconfig"
export CPPFLAGS="-I$PREFIX_FFI/include"
export LDFLAGS="-L$PREFIX_FFI/lib64"
export LIBFFI_CFLAGS="-I$PREFIX_FFI/include"
export LIBFFI_LIBS="-L$PREFIX_FFI/lib64 -lffi"

cd ..
PYTHON_VERSION=$(python --version 2>&1 | awk '{print $2}')
PYTHON_DIR="Python-$PYTHON_VERSION"

if [ ! -f "$PYTHON_DIR/configure" ]; then
  curl -LO "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz"
  tar -xf Python-"$PYTHON_VERSION".tgz
else
  make distclean
fi

cd "$PYTHON_DIR"

./configure --prefix="$BUILD_DIR/python$PYTHON_VERSION" --disable-shared --enable-optimizations --with-ensurepip=install

make -j$(nproc)
make install

PY_M=$(echo "$PYTHON_VERSION" | cut -d. -f1)
PY_MM=$(echo "$PYTHON_VERSION" | cut -d. -f1,2)

ln -s "$BASE/python$PYTHON_VERSION/bin/python$PY_MM" "$BASE/.venv/bin/python"
ln -s "$BASE/python$PYTHON_VERSION/bin/python$PY_MM" "$BASE/.venv/bin/python$PY_M"
ln -s "$BASE/python$PYTHON_VERSION/bin/python$PY_MM" "$BASE/.venv/bin/python$PY_MM"

cd ..
git clone https://github.com/thu-ml/SageAttention.git

source "$VENV_DIR/bin/activate"

pip uninstall sageattn3 sageattention
pip install setuptools packaging

export CPLUS_INCLUDE_PATH="$CUDA_HOME/include"
export C_INCLUDE_PATH="$CUDA_HOME/include"

cd SageAttention
python setup.py install
cd sageattention3_blackwell
python setup.py install

cd ../../..
rm -rf "$BUILD_DIR"
pip uninstall setuptools packaging
deactivate

DEFAULT_PY=$(which python)

ln -s "$DEFAULT_PY" "$BASE/.venv/bin/python"
ln -s "$DEFAULT_PY" "$BASE/.venv/bin/python$PY_M"
ln -s "$DEFAULT_PY" "$BASE/.venv/bin/python$PY_MM"
