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
    --run, -r         run exec file
    --test, -t        exec test (next arg: regex-pattern and other options)
    --version, -v     print ${this} version
EOF
}

function version {
    echo "$(basename ${0}) version 1.0.0 "
}

# colors
none=0
red=1
green=2
yellow=3
blue=4
magenda=5
cyan=6
white=7

# styles
bold=1
low_intensity=2
underline=4
blink=5
reverse=7
invisible=8


function cecho {
    msg=${1}
    color=${2:-$none}
    if [ ${3} ]; then
        style=";${3}"
    fi
    echo -e "\033[3${color}${style}m${msg}\033[m"
}



# Parse argmuments
build_mode=release
test_option=""
jobs=""
run_option=""

while [ $# -gt 0 ]; do
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
        run|--run|-r)
            while [ $# -gt 0 ]; do
                run_option=$run_option"${2}"
                shift
            done
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
    cecho "🖖 ${test_option}\n" $green $bold
    ctest -j ${jobs} ${test_option}
fi

if [ -n "${run_option}" ]; then
    cecho "👊 ${run_option}\n" $magenda $bold
    "./${build_dir}/${run_option}"
fi
