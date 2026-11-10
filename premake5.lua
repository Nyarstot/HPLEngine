include "dependencies.lua"
include "options.lua"


workspace "HPLEngine"
    configurations {"Debug", "Release"}
    platforms {"x86", "x64"}
    startproject "Amnesia"

    -- x86 links against the prebuilt 32-bit libraries in HPL2/dependencies/lib/win32.
    -- x64 is in progress: everything except the game executable builds so far.
    filter "platforms:x86"
        architecture "x86"
    filter "platforms:x64"
        architecture "x86_64"
    filter {}

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
        include "HPL2/dependencies/angelscript"
        include "HPL2/dependencies/Newton"

    group "Engine"
        include "HPL2/core"

    group ""
        include "amnesia/src/game"
