# Newton Dynamics 3.14 (trimmed)

Physics library used by HPL2 since the x64 migration. Licensed under zlib (see `LICENSE`).

- Source: https://github.com/MADEAPPS/newton-dynamics
- Commit: `a9c460c3509c935e65c5b1196b955d56627c3ffa` (2026-01-17), folder `newton-3.14/sdk` (copied to `sdk/`)
- Kept: only the core C API (`sdk/dgCore`, `sdk/dgPhysics`, `sdk/dgMeshUtil`, `sdk/dgNewton`).
  Demos, tools, 4.00, CMake files and the git history were removed to keep the repository small.
- Local patch: `DG_FLOAT_EXCEPTIONS_MASK` in `sdk/dgCore/dgTypes.h` can be overridden; premake sets it
  to 0 so Newton does not unmask FPU exceptions during the simulation step on x86.
- Built by `premake5.lua` as the static library `Newton` (`_NEWTON_STATIC_LIB`, no plugins, no profiler)
  and single-threaded (`DG_USE_THREAD_EMULATION`): the step and all callbacks run on the game thread.

Why 3.14 and not the original version: Amnesia shipped with a closed-source Newton 2.00 binary
(32-bit only), and the public history of newton-dynamics starts at 3.00. Newton 4.x has an entirely
different C++ API; 3.14 keeps the 2.x style C API, so the HPL2 physics layer only needed a port.
