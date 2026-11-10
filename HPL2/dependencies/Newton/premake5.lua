-- Newton Dynamics 3.14 (zlib), core C API only: dgCore + dgPhysics + dgMeshUtil + dgNewton.
-- Mirrors the upstream CMake build with NEWTON_BUILD_CORE_ONLY, static, no plugins, no profiler.
NewtonSdkDir = "./sdk"

project "Newton"
    kind "StaticLib"
    location "./"
    language "C++"
    cppdialect "C++17"

    targetdir("%{wks.location}/build/bin/" .. buildpattern .. "/%{prj.name}")
    objdir("%{wks.location}/build/int/" .. buildpattern .. "/%{prj.name}")

    files
    {
        NewtonSdkDir .. "/dgCore/*.h",
        NewtonSdkDir .. "/dgCore/*.cpp",
        NewtonSdkDir .. "/dgPhysics/*.h",
        NewtonSdkDir .. "/dgPhysics/*.cpp",
        NewtonSdkDir .. "/dgMeshUtil/*.h",
        NewtonSdkDir .. "/dgMeshUtil/*.cpp",
        NewtonSdkDir .. "/dgNewton/*.h",
        NewtonSdkDir .. "/dgNewton/*.cpp"
    }

    includedirs
    {
        NewtonSdkDir .. "/dgCore",
        NewtonSdkDir .. "/dgPhysics",
        NewtonSdkDir .. "/dgMeshUtil",
        NewtonSdkDir .. "/dgNewton"
    }

    defines
    {
        "_NEWTON_STATIC_LIB",
        "_CRT_SECURE_NO_WARNINGS",
        -- On 32-bit Windows Newton unmasks invalid/denormal/zero-divide FPU exceptions for the
        -- whole simulation step (a debugging aid). Game callbacks run inside it and SSE code works
        -- on unused vector lanes, so that crashes the game: keep the exceptions masked.
        "DG_FLOAT_EXCEPTIONS_MASK=0",
        -- Run the simulation step on the calling thread (upstream NEWTON_BUILD_SINGLE_THREADED).
        -- Otherwise NewtonUpdate steps in Newton's own thread, and HPL2 callbacks (impact effects,
        -- sounds, particle systems with GL buffers) would run outside the GL thread, like they never
        -- did with Newton 2.00.
        "DG_USE_THREAD_EMULATION"
    }

    floatingpoint "Fast"
    warnings "Off"

    filter "architecture:x86"
        defines { "_WIN_32_VER" }
        vectorextensions "SSE2"

    filter "architecture:x86_64"
        defines { "_WIN_64_VER" }

    -- Optimized in Debug too: an unoptimized solver alone makes the game stutter.
    -- Newton's own asserts (dgAssert, enabled by _DEBUG) still run.
    filter "configurations:Debug"
        symbols "on"
        optimize "Speed"
        runtime "Debug"
        runtimechecks "Off"

    filter "configurations:Release"
        optimize "Speed"
