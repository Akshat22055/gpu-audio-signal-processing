#include <cuda_runtime.h>

__global__ void convolutionKernel(
    const float* input,
    float* output,
    const float* kernel,
    int signalLength,
    int kernelSize) {

    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx >= signalLength) return;

    float sum = 0.0f;
    int half = kernelSize / 2;

    for (int k = 0; k < kernelSize; k++) {
        int signalIdx = idx + k - half;
        if (signalIdx >= 0 && signalIdx < signalLength) {
            sum += input[signalIdx] * kernel[k];
        }
    }
    output[idx] = sum;
}
