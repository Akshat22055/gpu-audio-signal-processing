#!/bin/bash
make clean
make
./gpu_signal_filter 5 | tee logs/execution_log.txt
