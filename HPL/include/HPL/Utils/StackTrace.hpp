#ifndef HPL_UTILS_STACKTRACE_HPP
#define HPL_UTILS_STACKTRACE_HPP


namespace backward
{
    class StackTrace;
}

namespace hpl
{
    class StackTrace
    {
    private:
        std::unique_ptr<backward::StackTrace> m_stackTrace;

    public:
        StackTrace();
        StackTrace(const StackTrace& aOther);
        ~StackTrace();

        std::string Get() const;
        StackTrace& operator=(const StackTrace& aOther);

    };
}

#endif // !HPL_UTILS_STACKTRACE_HPP
