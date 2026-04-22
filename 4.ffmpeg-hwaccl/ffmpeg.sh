#!/bin/bash
set -euo pipefail

export FFMPEG_PREFIX="$HOME/ffmpeg"
export CUDA_PATH="$HOME/cuda13"

mkdir -p "$FFMPEG_PREFIX/bin"

cd "$FFMPEG_PREFIX"

[ -d "nv-codec-headers" ] || git clone https://github.com/FFmpeg/nv-codec-headers.git
cd nv-codec-headers
make install PREFIX="$FFMPEG_PREFIX/deps"

export PKG_CONFIG_PATH="$FFMPEG_PREFIX/deps/lib/pkgconfig"

cd "$FFMPEG_PREFIX"
[ -d "ffmpeg_repo" ] || git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg_repo
cd ffmpeg_repo

./configure \
  --prefix="$FFMPEG_PREFIX" \
  --bindir="$FFMPEG_PREFIX/bin" \
  --extra-cflags="-I$CUDA_PATH/include  -I$FFMPEG_PREFIX/deps/include" \
  --extra-ldflags="-L$CUDA_PATH/lib64" \
  --extra-libs="-lpthread -lm -lz -ldl -lrt" \
  --nvcc="$CUDA_PATH/bin/nvcc" \
  --nvccflags="-gencode arch=compute_75,code=sm_75 -std=c++17 -Xcompiler -D__STRICT_ANSI__" \
  --enable-gpl \
  --enable-nonfree \
  --enable-static \
  --disable-shared \
  --enable-cuda-nvcc \
  --enable-nvenc \
  --enable-nvdec \
  --enable-cuvid \
  --enable-libx264 \
  --enable-libx265 \
  --enable-libvpx \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libvorbis \
  --enable-libass \
  --enable-openssl \
  --enable-ffprobe \
  --disable-debug \
  --disable-doc

make -j$(nproc)
make install
