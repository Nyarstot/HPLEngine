#ifndef HPL_SYSTEM_ENTRYPOINT_HPP
#define HPL_SYSTEM_ENTRYPOINT_HPP

#include "HPL/Engine/Engine.hpp"
#include "HPL/Utils/Logger.hpp"

extern int hplMain();
int main(int argc, char** argv)
{
    hpl::Logger::Init();
    return hpl::hplMain();
}

#endif // !HPL_SYSTEM_ENTRYPOINT_HPP
