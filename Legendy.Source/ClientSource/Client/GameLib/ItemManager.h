#pragma once

#include "ItemData.h"


class CItemManager : public CSingleton<CItemManager>
{
	public:
		enum EItemDescCol
		{
			ITEMDESC_COL_VNUM,
			ITEMDESC_COL_NAME,
			ITEMDESC_COL_DESC,
			ITEMDESC_COL_SUMM,
			ITEMDESC_COL_NUM,
		};

#ifdef ENABLE_ACCE_SYSTEM
		enum EItemScaleColumn
		{
			ITEMSCALE_VNUM,
			ITEMSCALE_JOB,
			ITEMSCALE_SEX,
			ITEMSCALE_SCALE_X,
			ITEMSCALE_SCALE_Y,
			ITEMSCALE_SCALE_Z,
			ITEMSCALE_POSITION_X, // facultative
			ITEMSCALE_POSITION_Y, // facultative
			ITEMSCALE_POSITION_Z, // facultative
			ITEMSCALE_NUM,
			ITEMSCALE_REQ = ITEMSCALE_SCALE_Z + 1,
			ITEMSCALE_AURA_NUM = ITEMSCALE_POSITION_X + 1,
		};
#endif

	public:
		typedef std::map<DWORD, CItemData*> TItemMap;
		typedef std::map<std::string, CItemData*> TItemNameMap;

	public:
		CItemManager();
		virtual ~CItemManager();

		void			Destroy();

		BOOL			SelectItemData(DWORD dwIndex);
		CItemData *		GetSelectedItemDataPointer();

		BOOL			GetItemDataPointer(DWORD dwItemID, CItemData ** ppItemData);

		/////
		bool			LoadItemDesc(const char* c_szFileName);
		bool			LoadItemList(const char* c_szFileName);
		bool			LoadItemTable(const char* c_szFileName);
		CItemData *		MakeItemData(DWORD dwIndex);

#ifdef ENABLE_ACCE_SYSTEM
		bool			LoadItemScale(const char* c_szFileName);
#endif

	protected:
		TItemMap m_ItemMap;
		std::vector<CItemData*>  m_vec_ItemRange;
		CItemData * m_pSelectedItemData;

#ifdef ENABLE_AURA_SYSTEM
public:
	enum EAuraScaleCol
	{
		AURA_SCALE_COL_VNUM,
		AURA_SCALE_COL_JOB,
		AURA_SCALE_COL_SEX,
		AURA_SCALE_COL_MESH_SCALE_X,
		AURA_SCALE_COL_MESH_SCALE_Y,
		AURA_SCALE_COL_MESH_SCALE_Z,
		AURA_SCALE_COL_PARTICLE_SCALE,
		AURA_SCALE_COL_NUM,
	};

	bool	LoadAuraScale(const char* c_szFileName);
#endif
};
