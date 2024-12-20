include "Premake5/scripts/helpers.lua"
include "dependencies.lua"

workspace "ReHPL"
    architecture "x64"
    startproject "Amnesia"
    configurations {"Debug", "Release"}

    buildpattern = "%{cfg.buildcfg}.%{cfg.system}.%{cfg.architecture}"

    project "HPL"
        location "HPL"
        kind "StaticLib"
        language "C++"
        cppdialect "C++20"
        characterset "MBCS"
        staticruntime "on"

        targetdir("build/bin/" .. buildpattern .. "/%{prj.name}")
        objdir("build/int/" .. buildpattern .. "/%{prj.name}")

        pchheader "hplpch.hpp"
        pchsource "%{wks.location}/%{prj.name}/source/hplpch.cpp"

        files
        {
            "%{wks.location}/%{prj.name}/include/**.hpp",
            "%{wks.location}/%{prj.name}/source/**.cpp"
        }

        includedirs
        {
            "%{wks.location}/%{prj.name}/include"
        }

        links
        {

        }

        filter "system:windows"
            systemversion "latest"

            defines
            {
                "HPL_WINDOWS",
                "HPL_COMPILED_PLATFORM=Windows"
            }


        filter "configurations:Debug"
            symbols "on"

            defines
            {
                "HPL_DEBUG",
                "HPL_ENABLE_ASSERT"
            }

        filter "configurations:Release"
            optimize "on"

            defines
            {
                "HPL_RELEASE"
            }

    project "Amnesia"
        location "Amnesia"
        kind "ConsoleApp"
        language "C++"
        cppdialect "C++20"
        staticruntime "on"
        characterset "MBCS"

        -- Executable will be placed in the root of application folder
        -- to have easier eaccess to game resources.
        targetdir("%{wks.location}/%{prj.name}/")
        objdir("build/int/" .. buildpattern .. "/%{prj.name}")

        files
        {
            "%{wks.location}/%{prj.name}/include/**.hpp",
            "%{wks.location}/%{prj.name}/source/**.cpp"
        }

        includedirs
        {
            "%{wks.location}/%{prj.name}/include",
            "%{wks.location}/HPL/include"
        }

        links
        {
            "HPL"
        }

        filter "system:windows"
            systemversion "latest"

        filter "configurations:Debug"
            symbols "on"

        filter "configurations:Release"
            optimize "on"


-----------------------
--- Overrides
-----------------------

require "vstudio"

-- https://github.com/premake/premake-core/pull/2187
local function clangtidy(cfg)
    if _ACTION >= "vs2019" then
        premake.vstudio.vc2010.element("EnableClangTidyCodeAnalysis", nil, "true")
        premake.vstudio.vc2010.element("ClangTidyChecks", nil, "\"--config-file=../.clang-tidy\"")
    end
end

premake.override(premake.vstudio.vc2010.elements, "outputProperties", function(base, cfg)
    local calls = base(cfg)
    table.insert(calls, clangtidy)
    return calls
end)
