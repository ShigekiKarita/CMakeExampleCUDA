cmake_minimum_required(VERSION 2.8.12.2)

project(thrust_cpp_integration)

find_package(CUDA REQUIRED)
add_compile_options(-std=c++11 -Wall -Wextra -fdiagnostics-color=auto)
enable_testing()

set(CUDA_NVCC_FLAGS "-std=c++11")

# -D_REETRANT -D_THREAD_SAFE
set(CMAKE_CXX_FLAGS_DEBUG   "-O0 -D_DEBUG -g")
set(CMAKE_CXX_FLAGS_RELEASE "-O2 -DNDEBUG")

set(CUDA_NVCC_FLAGS_DEBUG ${CMAKE_CXX_FLAGS_DEBUG})
set(CUDA_NVCC_FLAGS_RELEASE ${CMAKE_CXX_FLAGS_RELEASE})

set(cpulib "cpu")
set(gpulib "gpu")

include_directories(header)
add_subdirectory(src)
add_subdirectory(test)
