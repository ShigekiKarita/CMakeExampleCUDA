#!/usr/bin/env bash

# Functions
function usage {
this=$(basename ${0})
    cat <<EOF
${this} is a tool for CMake and CTest

Usage:
    ${this} [command] [<options>]
    eg. ${this} debug test -V    # run all test in debug

Options:
    --clang, -c       use Clang compiler (default: CC and CXX)
    --debug, -d       enable debug-mode (default: release-mode)
    --help, -h        print this
    --jobs, -j        set parallel jobs number manually (default: /proc/cpuinfo)
    --test, -t        exec test (next arg: regex-pattern and other options)
    --version, -v     print ${this} version
EOF
}

function version {
    echo "$(basename ${0}) version 1.0.0 "
}


# Parse argmuments
build_mode=release
test_option=""
jobs=""

while [ $# -gt 0 ];
do
    case ${1} in
        clang|--clang|-c)
            CC=clang
            CXX=clang++
        ;;
        debug|--debug|-d)
            build_mode=debug
        ;;
        help|--help|-h)
            usage
            exit 0
        ;;
        jobs|--jobs|-j)
            jobs=${2}
            shift
        ;;
        test|--test|-t)
            test_option="-R ${2}"
            shift
        ;;
        version|--version|-v)
            version
            exit 0
        ;;
        *)
            echo "[ERROR] Invalid option '${1}'"
            usage
            exit 1
        ;;
    esac
    shift
done


# Setup params
root_dir=`pwd`
build_dir="build/${CXX}/${build_mode}"
cmake_flags="-DCMAKE_BUILD_TYPE=${build_mode}"
project_name=`grep project CMakeLists.txt | sed -E 's/(project\()(.*)(\))/\2/'`
if [ -z "${jobs}" ]; then
    jobs=`grep -c ^processor /proc/cpuinfo 2>/dev/null`
fi


# Build and Test
if [ ! -e ${build_dir} ]; then
    mkdir -p ${build_dir}
fi

cd ${build_dir} &&
cmake ${cmake_flags} ${root_dir} &&
make -j ${jobs} &&
if [ -n "${test_option}" ]; then
    ctest -j ${jobs} ${test_option}
fi