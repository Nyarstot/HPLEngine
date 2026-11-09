newoption {
    trigger = "amnesia-dir",
    value = "PATH",
    description = "Amnesia: The Dark Descent install folder (game data and runtime DLLs). Defaults to %AMNESIA_TDD_DIR%."
}

newoption {
    trigger = "with-fbx",
    description = "Build the FBX mesh loader (needs a FBX SDK compatible with the engine code)."
}

-- Folder the game is started from: it holds the game data and the 32-bit runtime DLLs.
AmnesiaDir = _OPTIONS["amnesia-dir"] or os.getenv("AMNESIA_TDD_DIR")

if AmnesiaDir == nil and _ACTION ~= nil then
    premake.warn("Amnesia install folder is not set: pass --amnesia-dir=<path> or set AMNESIA_TDD_DIR. The game will not be runnable from Visual Studio.")
end
