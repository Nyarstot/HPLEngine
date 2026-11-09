include "dependencies.lua"
include "options.lua"


workspace "HPLEngine"
    -- Stage 1: the prebuilt dependencies in HPL2/dependencies/lib/win32 are 32-bit only.
    architecture "x86"
    configurations {"Debug", "Release"}
    startproject "Amnesia"

    buildpattern = "%{cfg.buildcfg}.%{cfg.system}.%{cfg.architecture}"

    -- The prebuilt dependencies are DLLs built against the shared CRT, so everything uses /MD.
    staticruntime "Off"

    -- Engine and game agree on this one: it changes how hplNew/hplDelete are implemented.
    filter "configurations:Debug"
        defines { "MEMORY_MANAGER_ACTIVE" }
    filter {}

    defines
    {
        "WIN32",
        "_WINDOWS",
        "USE_SDL2",
        "USE_OALWRAPPER",
        "_CRT_SECURE_NO_WARNINGS",
        "_CRT_NONSTDC_NO_DEPRECATE"
    }

    filter "options:with-fbx"
        defines { "HPL_WITH_FBX" }
    filter {}

    group "Dependencies"
        include "HPL2/dependencies/OALWrapper"

    group "Engine"
        include "HPL2/core"

    group ""
        include "amnesia/src/game"
