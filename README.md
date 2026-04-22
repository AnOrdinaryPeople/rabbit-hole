# Rabbit Hole

A collection of optimization and compatibility experiments I've explored so far.

## discord-bot

A minimal FFmpeg build tailored for Discord bots, with support for Opus and PCM audio codecs. Patches Discord.js dependencies to work with Bun's `bun compile` by rewriting dynamic N-API imports in prism-media and WebSocket modules into static imports.

**Tech:** FFmpeg, Bun, Discord.js, NAPI bindings

## pytorch-from-source

PyTorch built from source with CUDA 13 for Blackwell GPU (sm_120). Includes CPU optimizations for Zen 4 and ccache caching.  

**Tech:** CUDA 13, Blackwell GPU, PyTorch, OpenBLAS, LAPACK

## sageattention

Builds CPython and libffi from scratch in DistroBox for installing SageAttention. Workaround for Bazzite DX's Python lacking CPython.  

**Tech:** CPython, libffi, DistroBox, SageAttention

## ffmpeg-hwaccl

FFmpeg with NVIDIA GPU acceleration (NVENC, NVDEC, CUVID). Includes CUDA header patching for compatibility.  

**Tech:** FFmpeg, NVIDIA NVENC/NVDEC, CUDA 13, x264/x265, VP8/VP9, Opus, OpenSSL

## pipewire-virtualization

PipeWire 7.1 spatial audio virtualization for simulating surround sound. Uses SOFA files for audio processing.  

**Tech:** PipeWire, SOFA files

## proton

Notes on running Windows games on Bazzite. Documents workarounds for anti-cheat and DLL issues.  

**Tech:** Proton, Wine, DXVK
