-- Prebuilt third-party libraries shipped in HPL2/dependencies.
-- Paths are relative to the workspace location.

DependencyDir = "%{wks.location}/HPL2/dependencies"

LibraryMap = {}

LibraryMap["Common"] = {
    ["Include"] = DependencyDir .. "/include",
    ["LibDir"]  = DependencyDir .. "/lib/win32"
}

LibraryMap["OALWrapper"] = {
    -- Must come before Common.Include: it carries newer OpenAL (AL/*) headers.
    ["Include"] = DependencyDir .. "/OALWrapper/include"
}

LibraryMap["AngelScript"] = {
    -- Built from source (HPL2/dependencies/angelscript). Must come before Common.Include,
    -- which still carries the old 2.19 angelscript.h.
    ["Include"] = DependencyDir .. "/angelscript/include/angelscript",
    ["AddOnInclude"] = DependencyDir .. "/angelscript/add_on"
}

LibraryMap["Newton"] = {
    -- Built from source (HPL2/dependencies/Newton, 3.14). Must come before Common.Include,
    -- which still carries the old 2.00 Newton.h.
    ["Include"] = DependencyDir .. "/Newton/sdk/dgNewton",
    ["Defines"] = { "_NEWTON_STATIC_LIB" }
}

LibraryMap["SDL2"] = {
    ["Include"] = DependencyDir .. "/include/SDL2",
    ["Libs"]    = { "SDL2.lib" }
}

LibraryMap["Audio"] = {
    ["Libs"] = { "OpenAL32.lib", "libogg.lib", "libvorbis.lib", "libvorbisfile.lib" }
}

LibraryMap["Engine"] = {
    ["Libs"] =
    {
        "DevIL.lib",
        "glew32.lib",
        "libtheora.lib",
        "zlibwapi.lib",
        "TaskKeyHook.lib",
        "XInput.lib"
    }
}

LibraryMap["System"] = {
    ["Libs"] =
    {
        "opengl32.lib",
        "glu32.lib",
        "user32.lib",
        "gdi32.lib",
        "shell32.lib",
        "wininet.lib",
        "dbghelp.lib",
        "comctl32.lib",
        "wsock32.lib"
    }
}
