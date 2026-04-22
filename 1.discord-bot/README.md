# Discord Bot

A minimal build notes.

## FFmpeg

Stripped-down FFmpeg built from source, targeting minimal resource usage for a Discord bot.

### Dependencies

```bash
sudo dnf install -y \
  gcc \
  gcc-c++ \
  make \
  autoconf \
  automake \
  libtool \
  pkgconf-pkg-config \
  nasm \
  yasm \
  opus-devel \
  openssl-devel \
  zlib-devel \
  wget \
  cmake \
  xz
```

Then run `sudo chmod +x ./ffmpeg.sh && ./ffmpeg.sh`.

## Patch Dynamic Imports

Bun requires static imports at compile time. `patch.sh` rewrites dynamic NAPI imports in `prism-media`, and replaces WebSocket imports in `@discordjs/voice` and `@discordjs/ws` with Bun's native WebSocket.

### Tested Versions

- prism-media@1.3.5
- @discordjs/voice@0.19.0
- @discordjs/ws@1.2.3
