project "OALWrapper"
    kind "StaticLib"
    location "./"
    language "C++"
    cppdialect "C++17"
    characterset "ASCII"

    targetdir("%{wks.location}/build/bin/" .. buildpattern .. "/%{prj.name}")
    objdir("%{wks.location}/build/int/" .. buildpattern .. "/%{prj.name}")

    files
    {
        "./include/OALWrapper/**.h",
        "./sources/**.cpp"
    }

    includedirs
    {
        "%{LibraryMap.OALWrapper.Include}",
        "%{LibraryMap.SDL2.Include}",
        "%{LibraryMap.Common.Include}"
    }

    warnings "Off"

    filter "configurations:Debug"
        symbols "on"

    filter "configurations:Release"
        optimize "on"
