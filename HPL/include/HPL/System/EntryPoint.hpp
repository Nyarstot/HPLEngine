#ifndef HPL_SYSTEM_ENTRYPOINT_HPP
#define HPL_SYSTEM_ENTRYPOINT_HPP

#include "HPL/Engine/Engine.hpp"
#include <iostream>

extern int hplMain();
int main(int argc, char** argv)
{
    std::cout << "Hello World!" << std::endl;
    return hpl::hplMain();
}

#endif // !HPL_SYSTEM_ENTRYPOINT_HPP
