#pragma once
#include <lz4/lz4.h>

#ifdef _WIN32
#	ifdef _DEBUG
#		pragma comment(lib, "liblz4_static-Debug.lib")
#	else
#		pragma comment(lib, "liblz4_static-Release.lib")
#	endif
#endif

