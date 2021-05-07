#ifndef __GAME_SRC_GM_H__
#define __GAME_SRC_GM_H__
extern void gm_insert(const char * name, BYTE level);
extern BYTE gm_get_level(const char * name, const char * host = NULL, const char * account = NULL);
extern void gm_host_insert(const char * host);
extern void gm_new_clear();
extern void gm_new_insert( const tAdminInfo & c_rInfo );
extern void gm_new_host_inert( const char * host );

#include <set>
#include <string>
typedef struct sGM
{
	tAdminInfo Info;
	std::set<std::string> *pset_Host;
} tGM;

extern std::set<std::string> g_set_Host;
extern std::map<std::string, tGM> g_map_GM;
#endif

