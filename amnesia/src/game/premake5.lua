project "Amnesia"
    kind "WindowedApp"
    location "./"
    language "C++"
    cppdialect "C++17"
    characterset "ASCII"

    targetdir("%{wks.location}/build/bin/" .. buildpattern .. "/%{prj.name}")
    objdir("%{wks.location}/build/int/" .. buildpattern .. "/%{prj.name}")

    files
    {
        "./*.h",
        "./*.cpp",
        "./Lux.rc"
    }

    removefiles
    {
        -- Serial key checking (COPY_PROTECTION_ENABLED), needs FLTK and the missing serial_gen sources.
        "./LuxKeyEntry.cpp",
        "./LuxKeyEntry.h"
    }

    includedirs
    {
        "./",
        "%{wks.location}/HPL2/core/include",
        "%{LibraryMap.AngelScript.Include}",
        "%{LibraryMap.Common.Include}"
    }

    libdirs
    {
        "%{LibraryMap.Common.LibDir}"
    }

    links
    {
        "HPL2",
        "OALWrapper",
        "AngelScript",
        "Newton"
    }

    links(LibraryMap.SDL2.Libs)
    links(LibraryMap.Audio.Libs)
    links(LibraryMap.Engine.Libs)
    links(LibraryMap.System.Libs)

    defines
    {
        "USE_GAMEPAD"
    }

    disablewarnings { "4244", "4267", "4305", "4996", "4018", "4800" }
    buildoptions { "/permissive" }

    -- Run from the game install so the data and the 32-bit runtime DLLs are found.
    if AmnesiaDir ~= nil then
        debugdir(AmnesiaDir)
        debugenvs { "PATH=" .. AmnesiaDir .. ";%PATH%" }
    end

    filter "configurations:Debug"
        symbols "on"
        defines { "_DEBUG" }

    filter "configurations:Release"
        optimize "on"
        defines { "NDEBUG" }
