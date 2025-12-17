NVCC=nvcc
CFLAGS=-std=c++17

all:
	$(NVCC) $(CFLAGS) src/main.cu src/signal_io.cpp kernels/convolution_kernel.cu -o gpu_signal_filter

clean:
	rm -f gpu_signal_filter
