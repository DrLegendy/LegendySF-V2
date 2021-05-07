#ifndef __INC_METIN_II_SHUTDOWNMANAGER_H__
#define __INC_METIN_II_SHUTDOWNMANAGER_H__


class CShutdownManager : public singleton<CShutdownManager>
{
public:
	CShutdownManager();
	virtual ~CShutdownManager();

	void AddDesc(LPDESC pDesc);
	void RemoveDesc(LPDESC pDesc);
	int SearchDesc(LPDESC pDesc);

	void Update();

private:
	std::list<LPDESC> m_lstDesc;
	struct tm* m_pTime; time_t m_lTime;
	bool m_bShutdownAlarm;

	void inline UpdateTime() { time(&m_lTime); m_pTime = localtime(&m_lTime); }

public:
	bool CheckShutdownAge(const char* szSocialID);
	bool CheckShutdownTime();
	bool CheckCorrectSocialID(const char* szSocialID);
	bool inline CheckLocale() { return gShutdownEnable; }

private:
	int inline CharToInt(char c) { if(c >= '0' && c <= '9') return c - '0'; else return 0;} // char -> int
};
#endif
