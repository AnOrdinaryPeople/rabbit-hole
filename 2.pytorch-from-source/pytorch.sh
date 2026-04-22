#!/bin/bash
set -euo pipefail

export CUDA_HOME="$HOME/cuda13"
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
export TORCH_CUDA_ARCH_LIST="12.0"
# CPU-specific: Ryzen 9 7950X is Zen 4
export CFLAGS="-march=znver4 -O3"
export CXXFLAGS="-march=znver4 -O3"
export CMAKE_C_COMPILER_LAUNCHER=ccache
export CMAKE_CXX_COMPILER_LAUNCHER=ccache
export USE_DISTRIBUTED=0
export USE_NCCL=0
export USE_MKLDNN=1
export USE_OPENMP=1

git clone --recursive https://github.com/pytorch/pytorch
cd pytorch
git submodule sync --recursive
git submodule update --init --recursive

python setup.py develop
python setup.py bdist_wheel
pip install dist/torch-*.whl
