-- AngelScript 2.38.0: core copied from FlatByte (Module/Scripting/dependencies/angelscript),
-- add_on/scriptarray from the official SDK zip of the same version.
project "AngelScript"
    kind "StaticLib"
    location "./"
    language "C++"
    cppdialect "C++17"

    targetdir("%{wks.location}/build/bin/" .. buildpattern .. "/%{prj.name}")
    objdir("%{wks.location}/build/int/" .. buildpattern .. "/%{prj.name}")

    files
    {
        "./include/angelscript/angelscript.h",
        "./source/angelscript/*.h",
        "./source/angelscript/*.cpp",
        "./add_on/scriptarray/scriptarray.h",
        "./add_on/scriptarray/scriptarray.cpp"
    }

    includedirs
    {
        "./include/angelscript"
    }

    warnings "Off"

    filter "system:windows"
        defines { "_CRT_SECURE_NO_WARNINGS" }

    -- Native calling convention on x64 MSVC is implemented in assembly.
    filter { "system:windows", "architecture:x86_64" }
        files { "./source/angelscript/as_callfunc_x64_msvc_asm.asm" }

    filter "configurations:Debug"
        symbols "on"

    filter "configurations:Release"
        optimize "on"
