#pragma once
#include <memory>


template <typename T>
class A {
public:
    A();
    virtual ~A();
    void where();
private:
    A(const A&);
    const A& operator=(const A&);
    struct Impl;
    Impl* _impl;
};

// type args to link
template class A<float>;
template class A<double>;
