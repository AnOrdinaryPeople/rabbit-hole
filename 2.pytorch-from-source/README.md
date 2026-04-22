# PyTorch From Source

At the time of this build, CUDA 13 had no official PyTorch prebuilt wheels. Blackwell (sm_120) was only partially supported in nightly builds, and the stable releases capped at sm_90. CUDA 13.0 itself dropped on 2025-08-04 with full Turing-Blackwell coverage. The workaround was a full source build.

### Dependencies

```bash
sudo dnf install -y \
  git \
  gcc \
  gcc-c++ \
  make \
  cmake \
  ninja-build \
  python3-devel \
  python3-pip \
  openblas-devel \
  blas-devel \
  lapack-devel \
  openssl-devel \
  zlib-devel \
  ccache

pip install astunparse numpy ninja pyyaml setuptools typing_extensions future six requests dataclasses
```

Then run `sudo chmod +x ./pytorch.sh && ./pytorch.sh`.

### Verify

```python
import torch
print(torch.__version__)
print(torch.cuda.is_available())
print(torch.cuda.get_device_name(0))
print(torch.cuda.get_device_capability()) # should return (12, 0)
print(torch.backends.cpu.get_cpu_capability()) # expect 'avx512'
```
