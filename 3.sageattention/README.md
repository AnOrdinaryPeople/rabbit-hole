# SageAttention Build Script

Intended for use in an isolated environment such as DistroBox.

Assumes CUDA 13 toolkit is installed and `triton`, `torch`, `torchvision`, and `torchaudio` are installed in a `venv`. PyTorch must be built with CUDA 13 support.

Run `sudo chmod +x ./sageattention.sh && ./sageattention.sh`.

## Context

- Builds libffi from source as a static library, required to compile CPython with FFI support.
- Builds CPython from source matching the active Python version, since Bazzite DX's system Python lacks CPython.
- Symlinks the built Python into the existing venv, temporarily replacing the system Python.
- Installs both SageAttention (fallback for models without Blackwell support) and SageAttention3 via `setup.py` into the venv.
- Cleans up build artifacts and restores the original system Python symlinks in the venv.
