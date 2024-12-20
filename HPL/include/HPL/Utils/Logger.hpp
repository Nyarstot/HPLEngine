#ifndef HPL_UTILS_LOGGER_HPP
#define HPL_UTILS_LOGGER_HPP

#include <spdlog/logger.h>
#include <spdlog/spdlog.h>
#include <spdlog/sinks/stdout_color_sinks.h>


namespace hpl
{
    class Logger final
    {
    public:
        template <typename... Args>
        using FmtString = spdlog::format_string_t<Args...>;

        using Level = spdlog::level::level_enum;

    private:
        using LoggerPtr = std::shared_ptr<spdlog::logger>;
        using LoggerRef = LoggerPtr&;

        static LoggerPtr s_engineSideLogger;
        static LoggerPtr s_applicationSideLogger;

        static bool s_isStackTraceOnErrorEnabled;
        static bool s_isStackTraceOnWarnEnabled;

        template <typename... Args>
        static void Log(LoggerPtr& aLogger, Level aLevel, bool aPrintStackTrace, FmtString<Args...> aFmt,
            Args&&... args);

        static void PrintStackTrace();

    public:
        explicit Logger() = delete;

        static void Init();

        static LoggerPtr GetEngineSideLogger();
        static LoggerPtr GetApplicationSideLogger();

        template <typename... Args>
        static void EngineLog(Level aLevel, FmtString<Args...> aFmt, Args&&... args);

        template <typename... Args>
        static void EngineError(FmtString<Args...> aFmt, Args&&... args);

        template <typename... Args>
        static void EngineWarn(FmtString<Args...> aFmt, Args&&... args);

        template <typename... Args>
        static void EngineInfo(FmtString<Args...> aFmt, Args&&... args);

        template <typename... Args>
        static void EngineTrace(FmtString<Args...> aFmt, Args&&... args);

        template <typename... Args>
        static void AppLog(Level aLevel, FmtString<Args...> aFmt, Args&&... args);

        template <typename... Args>
        static void AppError(FmtString<Args...> aFmt, Args&&... args);

        template <typename... Args>
        static void AppWarn(FmtString<Args...> aFmt, Args&&... args);

        template <typename... Args>
        static void AppInfo(FmtString<Args...> aFmt, Args&&... args);

        template <typename... Args>
        static void AppTrace(FmtString<Args...> aFmt, Args&&... args);
    };

    template <typename... Args>
    void Logger::Log(LoggerPtr& aLogger, Level aLevel, const bool aPrintStackTrace, FmtString<Args...> aFmt,
        Args&&... args)
    {
        if (aLogger == nullptr)
        {
            return;
        }

        aLogger->log(aLevel, aFmt, std::forward<Args>(args)...);
        if (aPrintStackTrace)
        {
            PrintStackTrace();
        }
    }

    template <typename... Args>
    void Logger::EngineLog(Level aLevel, FmtString<Args...> aFmt, Args&&... args)
    {
        bool printStackTrace = (aLevel == Level::err && s_isStackTraceOnErrorEnabled) ||
            (aLevel == Level::warn && s_isStackTraceOnWarnEnabled);
        Log(s_engineSideLogger, aLevel, printStackTrace, aFmt, std::forward<Args>(args)...);
    }

    template <typename... Args>
    void Logger::EngineError(FmtString<Args...> aFmt, Args&&... args)
    {
        Log(s_engineSideLogger, Level::err, s_isStackTraceOnErrorEnabled, aFmt, std::forward<Args>(args)...);
    }

    template <typename... Args>
    void Logger::EngineWarn(FmtString<Args...> aFmt, Args&&... args)
    {
        Log(s_engineSideLogger, Level::warn, s_isStackTraceOnWarnEnabled, aFmt, std::forward<Args>(args)...);
    }

    template <typename... Args>
    void Logger::EngineInfo(FmtString<Args...> aFmt, Args&&... args)
    {
        Log(s_engineSideLogger, Level::info, false, aFmt, std::forward<Args>(args)...);
    }

    template <typename... Args>
    void Logger::EngineTrace(FmtString<Args...> aFmt, Args&&... args)
    {
        Log(s_engineSideLogger, Level::trace, false, aFmt, std::forward<Args>(args)...);
    }

    template <typename... Args>
    void Logger::AppLog(Level aLevel, FmtString<Args...> aFmt, Args&&... args)
    {
        bool printStackTrace = (aLevel == Level::err && s_isStackTraceOnErrorEnabled) ||
            (aLevel == Level::warn && s_isStackTraceOnWarnEnabled);
        Log(s_applicationSideLogger, aLevel, printStackTrace, aFmt, std::forward<Args>(args)...);
    }

    template <typename... Args>
    void Logger::AppError(FmtString<Args...> aFmt, Args&&... args)
    {
        Log(s_applicationSideLogger, Level::err, s_isStackTraceOnErrorEnabled, aFmt, std::forward<Args>(args)...);
    }

    template <typename... Args>
    void Logger::AppWarn(FmtString<Args...> aFmt, Args&&... args)
    {
        Log(s_applicationSideLogger, Level::warn, s_isStackTraceOnWarnEnabled, aFmt, std::forward<Args>(args)...);
    }

    template <typename... Args>
    void Logger::AppInfo(FmtString<Args...> aFmt, Args&&... args)
    {
        Log(s_applicationSideLogger, Level::info, false, aFmt, std::forward<Args>(args)...);
    }

    template <typename... Args>
    void Logger::AppTrace(FmtString<Args...> aFmt, Args&&... args)
    {
        Log(s_applicationSideLogger, Level::trace, false, aFmt, std::forward<Args>(args)...);
    }
}

    #define TRACE_LOG(...) ::hpl::Logger::EngineTrace(__VA_ARGS__)
    #define INFO_LOG(...)  ::hpl::Logger::EngineInfo(__VA_ARGS__)
    #define WARN_LOG(...)  ::hpl::Logger::EngineWarn(__VA_ARGS__)
    #define ERROR_LOG(...) ::hpl::Logger::EngineError(__VA_ARGS__)

    #define APP_TRACE_LOG(...) ::hpl::Logger::AppTrace(__VA_ARGS__)
    #define APP_INFO_LOG(...)  ::hpl::Logger::AppInfo(__VA_ARGS__)
    #define APP_WARN_LOG(...)  ::hpl::Logger::AppWarn(__VA_ARGS__)
    #define APP_ERROR_LOG(...) ::hpl::Logger::AppError(__VA_ARGS__)

#endif // !HPL_UTILS_LOGGER_HPP
