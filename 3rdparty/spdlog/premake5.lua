project "spdlog"
    kind "StaticLib"
    language "C++"
    location "./"
    buildoptions {"/Zc:__cplusplus", "/utf-8"}
    staticruntime "on"

    targetdir("lib/bin/" .. buildpattern .. "/%{prj.name}")
    objdir("lib/int/" .. buildpattern .. "/%{prj.name}")

    files
    {
        "./spdlog/include/**.h",
        "./spdlog/src/spdlog.cpp",
        "./spdlog/src/stdout_sinks.cpp",
        "./spdlog/src/color_sinks.cpp",
        "./spdlog/src/file_sinks.cpp",
        "./spdlog/src/async.cpp",
        "./spdlog/src/cfg.cpp"
    }

    includedirs
    {
        "./spdlog/include"
    }

    defines
    {
        "SPDLOG_COMPILED_LIB",
        "SPDLOG_FWRITE_UNLOCKED",
        "SPDLOG_WCHAR_TO_UTF8_SUPPORT"
    }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

        defines
        {

        }

    filter "configurations:Release"
        runtime "Release"
        optimize "on"

        defines
        {

        }

