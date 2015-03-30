# Example CMake project for cpp-cuda integration

First, I read this [thrust example (cpp_integration)](https://github.com/thrust/thrust/tree/master/examples/cpp_integration)

Then, I want to make user-code (and test-code) same between CPU and GPU. Switch CPU/GPU by only changing LIBs. In this project, we prepare 1 definition header and 2 implementation (CPU/GPU). In addition, CMake generates 2 CTest (CPU/GPU) from 1 test-code.

``` sh
$ ./cmk.sh test

...

[ 25%] Building NVCC (Device) object src/CMakeFiles/gpu.dir//./gpu_generated_device.cu.o
Scanning dependencies of target cpu
[ 50%] Building CXX object src/CMakeFiles/cpu.dir/device.cpp.o
Linking CXX static library libcpu.a
[ 50%] Built target cpu
Scanning dependencies of target host_cpu
[ 75%] Building CXX object test/CMakeFiles/host_cpu.dir/host.cpp.o
Linking CXX executable host_cpu
[ 75%] Built target host_cpu
Scanning dependencies of target gpu
Linking CXX static library libgpu.a
[ 75%] Built target gpu
Scanning dependencies of target host_gpu
[100%] Building CXX object test/CMakeFiles/host_gpu.dir/host.cpp.o
Linking CXX executable host_gpu
[100%] Built target host_gpu
Test project /home/karita/Grain/cpp_integration/build/g++/release
    Start 1: host_cpu
    Start 2: host_gpu
1/2 Test #1: host_cpu .........................   Passed    0.00 sec
2/2 Test #2: host_gpu .........................   Passed    0.12 sec

100% tests passed, 0 tests failed out of 2
Total Test time (real) =   0.12 sec
```
