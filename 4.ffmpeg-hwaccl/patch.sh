#!/bin/bash
set -euo pipefail

export CUDA_PATH="$HOME/cuda13"

cp $CUDA_PATH/targets/x86_64-linux/include/crt/math_functions.h $CUDA_PATH/targets/x86_64-linux/include/crt/math_functions_backup.h
sed -i 's/\(extern.*rsqrtf\?.*\))/\1) noexcept/' $CUDA_PATH/targets/x86_64-linux/include/crt/math_functions.h
