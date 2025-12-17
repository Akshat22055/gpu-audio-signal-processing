#include <iostream>
#include <vector>
#include <cuda_runtime.h>
#include "signal_io.h"

__global__ void convolutionKernel(const float*, float*, const float*, int, int);

int main(int argc, char** argv) {
    int kernelSize = 5;
    if (argc > 1) kernelSize = atoi(argv[1]);

    std::cout << "Running GPU signal filtering with kernel size "
              << kernelSize << std::endl;

    std::vector<float> signal = loadSignal("data/input/input_signal.csv");
    int signalLength = signal.size();

    std::vector<float> output(signalLength, 0.0f);

    std::vector<float> kernel(kernelSize, 1.0f / kernelSize);

    float *d_signal, *d_output, *d_kernel;
    cudaMalloc(&d_signal, signalLength * sizeof(float));
    cudaMalloc(&d_output, signalLength * sizeof(float));
    cudaMalloc(&d_kernel, kernelSize * sizeof(float));

    cudaMemcpy(d_signal, signal.data(),
               signalLength * sizeof(float),
               cudaMemcpyHostToDevice);

    cudaMemcpy(d_kernel, kernel.data(),
               kernelSize * sizeof(float),
               cudaMemcpyHostToDevice);

    int threads = 256;
    int blocks = (signalLength + threads - 1) / threads;

    convolutionKernel<<<blocks, threads>>>(
        d_signal, d_output, d_kernel,
        signalLength, kernelSize);

    cudaDeviceSynchronize();

    cudaMemcpy(output.data(), d_output,
               signalLength * sizeof(float),
               cudaMemcpyDeviceToHost);

    saveSignal(output, "data/output/filtered_signal.csv");

    cudaFree(d_signal);
    cudaFree(d_output);
    cudaFree(d_kernel);

    std::cout << "GPU signal processing completed\n";
    return 0;
}
