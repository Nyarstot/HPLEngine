#include "hplpch.hpp"
#include "HPL/Utils/StackTrace.hpp"

#include <backward.hpp>


namespace hpl
{
    StackTrace::StackTrace()
    {
        backward::TraceResolver workAround; // https://github.com/bombela/backward-cpp/issues/206
        m_stackTrace = std::make_unique<backward::StackTrace>();
        m_stackTrace->load_here(64);
        m_stackTrace->skip_n_firsts(3);
    }

    StackTrace::StackTrace(const StackTrace& aOther)
        : m_stackTrace(std::make_unique<backward::StackTrace>(*m_stackTrace))
    {
    }

    StackTrace::~StackTrace()
    {
    }

    std::string StackTrace::Get() const
    {
        std::ostringstream oss;
        backward::Printer printer;

        printer.print(*m_stackTrace, oss);
        return oss.str();
    }

    StackTrace& StackTrace::operator=(const StackTrace& aOther)
    {
        m_stackTrace = std::make_unique<backward::StackTrace>(*m_stackTrace);
        return *this;
    }
}