#include <iostream>
#include "a_common.hpp"

template <typename T>
struct A<T>::Impl {
    void msg() {
        std::cout << "from cpp" << std::endl;
    }
};
