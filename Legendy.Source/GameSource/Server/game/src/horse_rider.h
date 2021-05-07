#ifndef __HORSE_H
#define __HORSE_H

#include "constants.h"
#include "cmd.h"

#ifdef ENABLE_NEWSTUFF
#include "lua_incl.h"
namespace quest { extern ALUA(horse_set_stat0); }
#endif

const int HORSE_MAX_LEVEL = 30;

struct THorseStat
{
	int iMinLevel;
	int iNPCRace;
	int iMaxHealth;
	int iMaxStamina;
	int iST;
	int iDX;
	int iHT;
	int iIQ;
	int iDamMean;
	int iDamMin;
	int iDamMax;
	int iArmor;
};

extern THorseStat c_aHorseStat[HORSE_MAX_LEVEL+1];

// #define ENABLE_INFINITE_HORSE_HEALTH_STAMINA
class CHorseRider
{
	public:
		CHorseRider();
		virtual ~CHorseRider();

		BYTE		GetHorseLevel() const { return m_Horse.bLevel; }
		BYTE		GetHorseGrade();
		short		GetHorseMaxHealth() const;
		short		GetHorseMaxStamina() const;
#ifdef ENABLE_INFINITE_HORSE_HEALTH_STAMINA
		short		GetHorseHealth() const	{ return GetHorseMaxHealth(); }
		short		GetHorseStamina() const	{ return GetHorseMaxStamina(); }
#else
		short		GetHorseHealth() const	{ return m_Horse.sHealth; }
		short		GetHorseStamina() const	{ return m_Horse.sStamina; }
#endif

		int		GetHorseST()		{ return c_aHorseStat[GetHorseLevel()].iST; }
		int		GetHorseDX()		{ return c_aHorseStat[GetHorseLevel()].iDX; }
		int		GetHorseHT()		{ return c_aHorseStat[GetHorseLevel()].iHT; }
		int		GetHorseIQ()		{ return c_aHorseStat[GetHorseLevel()].iIQ; }
		int		GetHorseArmor()		{ return c_aHorseStat[GetHorseLevel()].iArmor; }

		virtual bool ReviveHorse();
		void FeedHorse();
		virtual void HorseDie();

		bool IsHorseRiding() const		{ return m_Horse.bRiding; }

		void ResetHorseHealthDropTime();

		virtual void SetHorseLevel(int iLevel);

		void EnterHorse();

		virtual void SendHorseInfo() {}
		virtual void ClearHorseInfo() {}

		virtual void UpdateRideTime(int interval) {}

	protected:
		void SetHorseData(const THorseInfo& crInfo);
		const THorseInfo& GetHorseData() const { return m_Horse; }

		void UpdateHorseDataByLogoff(DWORD dwLogoffTime);

		virtual bool StartRiding();
		virtual bool StopRiding();

		virtual	DWORD GetMyHorseVnum() const { return 20030; }

	private:
		void UpdateHorseStamina(int iStamina, bool bSend = true);

		void StartStaminaConsumeEvent();
		void StartStaminaRegenEvent();

		void UpdateHorseHealth(int iHealth, bool bSend = true);
		void CheckHorseHealthDropTime(bool bSend = true);

		void Initialize();
		void Destroy();

		THorseInfo m_Horse;

		LPEVENT	m_eventStaminaRegen;
		LPEVENT	m_eventStaminaConsume;

		friend EVENTFUNC(horse_stamina_regen_event);
		friend EVENTFUNC(horse_stamina_consume_event);
		friend ACMD(do_horse_set_stat);
#ifdef ENABLE_NEWSTUFF
		friend ALUA(quest::horse_set_stat0);
#endif
};

#endif
