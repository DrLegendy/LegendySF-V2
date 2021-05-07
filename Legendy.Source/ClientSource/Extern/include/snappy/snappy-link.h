#pragma once
#include <snappy/snappy.h>

#ifdef _WIN32
	#ifdef _DEBUG
		#pragma comment( lib, "snappy_d.lib" )
	#else
		#pragma comment( lib, "snappy.lib" )
	#endif
#endif

