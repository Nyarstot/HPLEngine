Amnesia: The Dark Descent Source Code
=======================

The HPL2 engine and the game code of Amnesia: The Dark Descent, revived to build with a modern
toolchain (Visual Studio 2022, premake5). The original release notes are kept at the end.

Building (Windows)
------------------

1. Unpack `HPL2/dependencies.zip` into `HPL2/dependencies` (prebuilt 32-bit libraries and headers).
2. Point the build at an installed copy of the game (data and runtime DLLs), either with the
   `AMNESIA_TDD_DIR` environment variable or `--amnesia-dir=<path>`.
3. Run `GenerateProject.bat` (premake5, `vs2022`) and open `HPLEngine.sln`.
4. Build the `x86` platform and start `Amnesia`: Visual Studio runs it from the game folder.

Options: `--with-fbx` builds the FBX mesh loader (off by default, see below).

Status of the x64 migration
---------------------------

- `x86`: the game builds and runs; every level of the main campaign loads.
- `x64`: OALWrapper, AngelScript, Newton and HPL2 build. The game does not link yet: the 64-bit
  SDL2, OpenAL, ogg/vorbis/theora, DevIL, GLEW and zlib libraries are still missing.

Major changes
-------------

### Build
- CMake and the VS2010 project setup replaced by premake5 (`premake5.lua`, `dependencies.lua`,
  `options.lua`, one `premake5.lua` per project). Output goes to `build/bin` and `build/int`.
- Fixes for the current MSVC: `std::binary_function`, const comparators, SDL2 header packing,
  `afxres.h`. OALWrapper no longer pulls SDL 1.2 in through `#pragma comment`.
- The FBX loader is optional (`HPL_WITH_FBX`): FBX SDK 2012 is not available anymore.

### AngelScript 2.19 → 2.38 (built from source, `HPL2/dependencies/angelscript`)
- Ported to the new API: function lookup, contexts, `asIStringFactory` for string literals.
- Built-in arrays come from the `scriptarray` add-on, registered as the default array type.
- String literals are const now: script functions take `string &in` instead of `string&`,
  and functions that returned `string&` return a new `string@`.

### Newton Dynamics 2.00 → 3.14 (built from source, `HPL2/dependencies/Newton`)
- The original closed-source 32-bit Newton 2.00 is replaced by Newton 3.14 (zlib), trimmed to its
  core C API. The HPL2 physics layer is ported: shapes, bodies, materials, joints, world queries.
- Buoyancy is reimplemented (Newton 3 removed it); capsule heights follow the new convention.
- Newton runs single-threaded on the game thread and keeps FPU exceptions masked.
- Continuous collision is disabled and level meshes are built with the tree optimizer: both were
  sources of stutter (and a solver overflow) with Newton 3.
- Map caches use the `.map_cache_n3` extension, since the original ones hold Newton 2.00 data.

Physics behaves close to the original but not identically; small objects can get stuck in thin
geometry a bit more often.

Contributing Code
-----------------
We encourage everyone to contribute code to this project, so just sign up for a github account, create a fork and hack away at the codebase.

License Information
-------------------
All code is under the GPL Version 3 license. Read the LICENSE file for terms of use of the license.
Third-party libraries in `HPL2/dependencies` keep their own licenses (AngelScript and Newton: zlib).

Original release notes
----------------------
Currently the engine uses fbx sdk 2012 which isn't avalable anymore which means the engine wont compile. If you want to give a shot anyway you can find the sdk here:
https://www.autodesk.com/fbx

Other than that, here is almost everything you need to build Amnesia: The Dark Descent. Included are project files for Visual Studio 2010 and CMake for Linux & macOS.
