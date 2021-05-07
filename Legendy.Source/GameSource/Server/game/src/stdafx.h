#ifndef __GAME_SRC_STDAFX_H__
#define __GAME_SRC_STDAFX_H__

// Basic features
// Enable or disable memory pooling for specific object types
//#define M2_USE_POOL
// Enable or disable heap allocation debugging
//#define DEBUG_ALLOC

#include "debug_allocator.h"

#include "../../libthecore/include/stdafx.h"

#include "../../common/singleton.h"
#include "../../common/utils.h"
#include "../../common/service.h"
#include "../../common/CommonDefines.h"

#include <algorithm>
#include <math.h>
#include <list>
#include <map>
#include <set>
#include <queue>
#include <string>
#include <vector>


#ifdef __GNUC__
#	include <float.h>
#	if defined(CXX11_ENABLED) || defined(__clang__)
#		include <unordered_map>
#		include <unordered_set>
#		define TR1_NS std
#		define TR1_NS_BEGIN namespace TR1_NS {
#		define TR1_NS_END }
#		define TR1_NS_BLOCK(x) namespace TR1_NS { x }
#	else
#		include <tr1/unordered_map>
#		include <tr1/unordered_set>
#		define TR1_NS std::tr1
#		define TR1_NS_BEGIN namespace std { namespace tr1 {
#		define TR1_NS_END } }
#		define TR1_NS_BLOCK(x) namespace std { namespace tr1 { x } }
#	endif
#else
#	include <boost/unordered_map.hpp>
#	include <boost/unordered_set.hpp>
#	define TR1_NS boost
#	define TR1_NS_BEGIN namespace TR1_NS {
#	define TR1_NS_END }
#	define TR1_NS_BLOCK(x) namespace TR1_NS { x }
#	define isdigit iswdigit
#	define isspace iswspace
#endif

#include "typedef.h"
#include "locale.hpp"
#include "event.h"

#define PASSES_PER_SEC(sec) ((sec) * passes_per_sec)

#ifndef M_PI
#define M_PI    3.14159265358979323846 /* pi */
#endif
#ifndef M_PI_2
#define M_PI_2  1.57079632679489661923 /* pi/2 */
#endif

#define IN
#define OUT

#endif

