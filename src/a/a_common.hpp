#include <a.hpp>

template <typename T>
A<T>::A() : _impl(new Impl) {}

template <typename T>
A<T>::~A() { delete _impl; }

template <typename T>
void A<T>::where() { _impl->msg(); }
