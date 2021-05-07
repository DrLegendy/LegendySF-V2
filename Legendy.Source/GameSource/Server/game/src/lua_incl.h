#if !defined(_MSC_VER) && defined(__cplusplus)
extern "C" {
#endif


#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

#if LUA_V == 523
	#define luaL_reg		luaL_Reg

	#define lua_dobuffer	luaL_loadbuffer
	#define lua_dofile		luaL_dofile
	#define lua_dostring	luaL_dostring
	#define luaL_getn		lua_rawlen
	#define lua_resume(a,b)	lua_resume(a,0,b)


	#define lua_ref(L,lock)	((lock) ? luaL_ref(L, LUA_REGISTRYINDEX) : \
	  (lua_pushstring(L, "unlocked references are obsolete"), lua_error(L), 0))
	#define lua_unref(L,ref)	luaL_unref(L, LUA_REGISTRYINDEX, (ref))
#endif

// #ifdef ENABLE_NEWSTUFF
#ifndef lua_String
#define lua_String const char*
#endif

#ifndef ALUA
#define ALUA(name) int name(lua_State* L)
#endif
// #endif

#if !defined(_MSC_VER) && defined(__cplusplus)
}
#endif
