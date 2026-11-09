/*
 * Copyright © 2009-2020 Frictional Games
 *
 * This file is part of Amnesia: The Dark Descent.
 *
 * Amnesia: The Dark Descent is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Amnesia: The Dark Descent is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Amnesia: The Dark Descent.  If not, see <https://www.gnu.org/licenses/>.
 */

// Temporary bridge for the prebuilt 32-bit angelscript.lib (built with VS2010).
// That library imports _vsnprintf from the old DLL CRT (__imp___vsnprintf),
// which the Universal CRT no longer exports. Remove once AngelScript is built from source.

#if defined(_MSC_VER) && defined(_M_IX86)

#include <stdio.h>
#include <stdarg.h>

extern "C"
{
	static int __cdecl LegacyVsnprintf(char* apBuffer, size_t alCount, const char* asFormat, va_list aArgs)
	{
		return _vsnprintf(apBuffer, alCount, asFormat, aArgs);
	}

	// x86 C decoration adds a leading underscore: this becomes __imp___vsnprintf.
	int (__cdecl* _imp___vsnprintf)(char*, size_t, const char*, va_list) = LegacyVsnprintf;
}

#endif
