# GPU-Accelerated Audio Signal Processing

## Motivation
This project explores how GPU parallelism can accelerate signal processing
tasks such as convolution-based filtering, which are common in audio,
biomedical, and sensor data pipelines.

## What This Project Does
- Loads a large 1D signal from CSV
- Applies a moving-average filter using a CUDA kernel
- Processes the entire signal in parallel on the GPU
- Writes the filtered signal back to disk

## GPU Usage
All convolution computation is performed using a custom CUDA kernel.
The CPU is used only for I/O and kernel orchestration.

## Build
```bash
make
