#include "stdafx.h"
#include "utils.h"
#include "config.h"
#include "char.h"
#include "sectree_manager.h"
#include "battle.h"
#include "affect.h"
#include "shop_manager.h"

int	OnClickShop(TRIGGERPARAM);
int	OnClickTalk(TRIGGERPARAM);

int	OnIdleDefault(TRIGGERPARAM);
int	OnAttackDefault(TRIGGERPARAM);

typedef struct STriggerFunction
{
	int (*func) (TRIGGERPARAM);
} TTriggerFunction;

TTriggerFunction OnClickTriggers[ON_CLICK_MAX_NUM] =
{
	{ NULL,          	},	// ON_CLICK_NONE,
	{ OnClickShop,	},	// ON_CLICK_SHOP,
};

void CHARACTER::AssignTriggers(const TMobTable * table)
{
	if (table->bOnClickType >= ON_CLICK_MAX_NUM)
	{
		sys_err("%s has invalid OnClick value %d", GetName(), table->bOnClickType);
		abort();
	}

	m_triggerOnClick.bType = table->bOnClickType;
	m_triggerOnClick.pFunc = OnClickTriggers[table->bOnClickType].func;
}

/*
 * ON_CLICK
 */
int OnClickShop(TRIGGERPARAM)
{
	CShopManager::instance().StartShopping(causer, ch);
	return 1;
}


int OnIdleDefault(TRIGGERPARAM)
{
	if (ch->OnIdle())
		return PASSES_PER_SEC(1);

	return PASSES_PER_SEC(1);
}

class FuncFindMobVictim
{
	public:
		FuncFindMobVictim(LPCHARACTER pkChr, int iMaxDistance) :
			m_pkChr(pkChr),
			m_iMinDistance(~(1L << 31)),
			m_iMaxDistance(iMaxDistance),
			m_lx(pkChr->GetX()),
			m_ly(pkChr->GetY()),
			m_pkChrVictim(NULL),
			m_pkChrBuilding(NULL)
	{
	};

		bool operator () (LPENTITY ent)
		{
			if (!ent->IsType(ENTITY_CHARACTER))
				return false;

			LPCHARACTER pkChr = (LPCHARACTER) ent;

			if (pkChr->IsBuilding() &&
				(pkChr->IsAffectFlag(AFF_BUILDING_CONSTRUCTION_SMALL) ||
				 pkChr->IsAffectFlag(AFF_BUILDING_CONSTRUCTION_LARGE) ||
				 pkChr->IsAffectFlag(AFF_BUILDING_UPGRADE)))
			{
				m_pkChrBuilding = pkChr;
			}

			if (pkChr->IsNPC())
			{
				if ( !pkChr->IsMonster() || !m_pkChr->IsAttackMob() || m_pkChr->IsAggressive()  )
					return false;

			}

			if (pkChr->IsDead())
				return false;

			if (pkChr->IsAffectFlag(AFF_EUNHYUNG) ||
					pkChr->IsAffectFlag(AFF_INVISIBILITY) ||
					pkChr->IsAffectFlag(AFF_REVIVE_INVISIBLE))
				return false;

			if (pkChr->IsAffectFlag(AFF_TERROR) && m_pkChr->IsImmune(IMMUNE_TERROR) == false )
			{
				if ( pkChr->GetLevel() >= m_pkChr->GetLevel() )
					return false;
			}

		 	if ( m_pkChr->IsNoAttackShinsu() )
			{
				if ( pkChr->GetEmpire() == 1 )
					return false;
			}

			if ( m_pkChr->IsNoAttackChunjo() )
			{
				if ( pkChr->GetEmpire() == 2 )
					return false;
			}


			if ( m_pkChr->IsNoAttackJinno() )
			{
				if ( pkChr->GetEmpire() == 3 )
					return false;
			}

			int iDistance = DISTANCE_APPROX(m_lx - pkChr->GetX(), m_ly - pkChr->GetY());

			if (iDistance < m_iMinDistance && iDistance <= m_iMaxDistance)
			{
				m_pkChrVictim = pkChr;
				m_iMinDistance = iDistance;
			}
			return true;
		}

		LPCHARACTER GetVictim()
		{

			if ((m_pkChrBuilding && ((m_pkChr->GetHP() * 2) > m_pkChr->GetMaxHP())) || !m_pkChrVictim)
			{
				return m_pkChrBuilding;
			}

			return (m_pkChrVictim);
		}

	private:
		LPCHARACTER	m_pkChr;

		int		m_iMinDistance;
		int		m_iMaxDistance;
		long		m_lx;
		long		m_ly;

		LPCHARACTER	m_pkChrVictim;
		LPCHARACTER	m_pkChrBuilding;
};

LPCHARACTER FindVictim(LPCHARACTER pkChr, int iMaxDistance)
{
	FuncFindMobVictim f(pkChr, iMaxDistance);
	if (pkChr->GetSectree() != NULL) {
		pkChr->GetSectree()->ForEachAround(f);
	}
	return f.GetVictim();
}

