# FFmpeg with Hardware Acceleration

Builds FFmpeg from source with NVIDIA hardware acceleration (NVENC/NVDEC/CUDA) and common codec support. Intended for use with a custom CUDA 13 installation. `patch.sh` fixes a CUDA 13 header incompatibility with C++ before building, and `ffmpeg.sh` clones and compiles FFmpeg with nv-codec-headers and the codec flags below.

**Enabled codecs:** x264, x265, VP8/VP9, MP3, Opus, Vorbis, ASS subtitles, OpenSSL.
**Hardware:** NVENC, NVDEC, CUVID, CUDA (compute capability sm_75+).

## Dependencies

```bash
sudo dnf install -y \
  "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
  "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

sudo dnf install -y \
  autoconf automake bzip2 bzip2-devel cmake freetype-devel gcc gcc-c++ git \
  libtool make mercurial pkgconfig zlib-devel nasm yasm \
  libxml2-devel openssl-devel \
  libva-devel libvdpau-devel \
  alsa-lib-devel pulseaudio-libs-devel SDL2-devel \
  xz-devel perl-Compress-Zlib glibc-static libstdc++-static libass-devel \
  x264-devel x265-devel libvpx-devel fdk-aac-devel svt-av1-devel lame-devel opus-devel libvorbis-devel libogg-devel flac-devel libaom-devel libdav1d-devel libwebp-devel openssl-devel libxml2-devel libva-devel libvdpau-devel perl-IO-Compress
```
