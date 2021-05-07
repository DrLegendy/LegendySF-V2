#pragma once

#ifdef ENABLE_ACCE_SYSTEM
#include "Packet.h"

class CPythonAcce : public CSingleton<CPythonAcce>
{
public:
	DWORD	dwPrice;
	typedef std::vector<TAcceMaterial> TAcceMaterials;

public:
	CPythonAcce();
	virtual ~CPythonAcce();

	void	Clear();
	void	AddMaterial(DWORD dwRefPrice, BYTE bPos, TItemPos tPos);
	void	AddResult(DWORD dwItemVnum, DWORD dwMinAbs, DWORD dwMaxAbs);
	void	RemoveMaterial(DWORD dwRefPrice, BYTE bPos);
	DWORD	GetPrice() {return dwPrice;}
	bool	GetAttachedItem(BYTE bPos, BYTE & bHere, WORD & wCell);
	void	GetResultItem(DWORD & dwItemVnum, DWORD & dwMinAbs, DWORD & dwMaxAbs);

protected:
	TAcceResult	m_vAcceResult;
	TAcceMaterials	m_vAcceMaterials;
};
#endif
