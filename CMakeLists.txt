cmake_minimum_required(VERSION 2.8.12.2)

project(thrust_cpp_integration)

find_package(CUDA REQUIRED)
add_compile_options(-std=c++11 -Wall -Wextra -fdiagnostics-color=auto)
enable_testing()

set(cpulib "cpu")
set(gpulib "gpu")

include_directories(header)
add_subdirectory(src)
add_subdirectory(test)
