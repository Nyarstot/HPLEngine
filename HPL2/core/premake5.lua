project "HPL2"
    kind "StaticLib"
    location "./"
    language "C++"
    cppdialect "C++17"
    characterset "ASCII"

    targetdir("%{wks.location}/build/bin/" .. buildpattern .. "/%{prj.name}")
    objdir("%{wks.location}/build/int/" .. buildpattern .. "/%{prj.name}")

    files
    {
        "./include/**.h",
        "./sources/**.cpp"
    }

    removefiles
    {
        -- Non-Windows platform layers
        "./sources/impl/PlatformMacOSX.mm",
        "./sources/impl/PlatformUnix.cpp",
        "./sources/impl/PlatformSDL.cpp",
        "./sources/impl/MutexSDL.cpp",
        "./sources/impl/ThreadSDL.cpp",

        -- Dead backends: Cg shaders, FMOD sound, HaptX haptics, SDL1 gamepad
        "./sources/impl/CGProgram.cpp",
        "./sources/impl/CGShader.cpp",
        "./sources/impl/SDLFragmentProgram.cpp",
        "./sources/impl/SDLVertexProgram.cpp",
        "./sources/impl/FmodSoundChannel.cpp",
        "./sources/impl/FmodSoundData.cpp",
        "./sources/impl/LowLevelSoundFmod.cpp",
        "./sources/impl/LowLevelHapticHaptX.cpp"
    }

    filter "not options:with-fbx"
        removefiles { "./sources/impl/MeshLoaderFBX.cpp" }
    filter {}

    includedirs
    {
        "./include",
        "%{LibraryMap.OALWrapper.Include}",
        "%{LibraryMap.Common.Include}",
        "%{LibraryMap.Common.Include}/AL"
    }

    links
    {
        "OALWrapper"
    }

    -- Legacy code base: keep the noise down until it builds.
    warnings "Default"
    disablewarnings { "4244", "4267", "4305", "4996", "4018", "4800" }
    buildoptions { "/permissive" }

    filter "configurations:Debug"
        symbols "on"
        defines { "_DEBUG" }

    filter "configurations:Release"
        optimize "on"
        defines { "NDEBUG" }
