#!/bin/bash
set -euo pipefail

FFMPEG_VERSION="8.0"
BUILD_DIR="/tmp"
PREFIX="/usr/local"

cd "$BUILD_DIR"
wget -q "https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz"
tar -xzf "ffmpeg-${FFMPEG_VERSION}.tar.gz"
cd "ffmpeg-${FFMPEG_VERSION}"

./configure \
  --disable-everything \
  --enable-encoder=pcm_s16le \
  --enable-demuxer=ogg \
  --enable-muxer=pcm_s16le \
  --enable-decoder=opus \
  --enable-filter=aresample \
  --enable-filter=volume \
  --enable-protocol=file \
  --enable-protocol=pipe \
  --enable-libopus \
  --enable-shared \
  --enable-small \
  --prefix=/usr/local && \
  make -j$(nproc) && \
  make install

make -j"$(nproc)"
sudo make install
sudo ldconfig

echo "FFmpeg ${FFMPEG_VERSION} installed to ${PREFIX}"
rm -rf "$BUILD_DIR/ffmpeg-${FFMPEG_VERSION}"*
