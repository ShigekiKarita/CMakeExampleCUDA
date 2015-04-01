# Example CMake project for cpp-cuda integration

First, I read this [thrust example (cpp_integration)](https://github.com/thrust/thrust/tree/master/examples/cpp_integration)

Then, I want to make user-code (and test-code) same between CPU and GPU. Switch CPU/GPU by only changing LIBs. In this project, we prepare 1 definition header and 2 implementation (CPU/GPU). In addition, CMake generates 2 CTest (CPU/GPU) from 1 test-code.

```
.
├── CMakeLists.txt
├── cmk.sh
├── header
│   └── thrust_sort.h        # definition header
├── README.md
├── src
│   ├── CMakeLists.txt
│   ├── thrust_sort.cpp      # implementation on CPU
│   └── thrust_sort.cu       # implementation on GPU
└── test
    ├── CMakeLists.txt
    └── thrust_sort_test.cpp  # test on CPU/GPU
```

``` sh
$ ./cmk.sh test

...

[ 25%] Built target cpu
[ 50%] Built target gpu
[ 75%] Built target thrust_sort_test_cpu
[100%] Built target thrust_sort_test_gpu
Test project build/g++/release
    Start 2: thrust_sort_test_gpu
    Start 1: thrust_sort_test_cpu
1/2 Test #1: thrust_sort_test_cpu .............   Passed    0.00 sec
2/2 Test #2: thrust_sort_test_gpu .............   Passed    0.15 sec

100% tests passed, 0 tests failed out of 2

Label Time Summary:
test/thrust_sort_test.cpp (cpu)    =   0.00 sec
test/thrust_sort_test.cpp (gpu)    =   0.15 sec

Total Test time (real) =   0.15 sec
```
