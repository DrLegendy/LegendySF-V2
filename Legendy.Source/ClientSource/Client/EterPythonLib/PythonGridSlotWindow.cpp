#include "StdAfx.h"
#include "../eterBase/CRC32.h"
#include "PythonGridSlotWindow.h"

using namespace UI;

void CGridSlotWindow::OnRenderPickingSlot()
{
	if (!UI::CWindowManager::Instance().IsAttaching())
		return;

	BYTE byWidth, byHeight;
	UI::CWindowManager::Instance().GetAttachingIconSize(&byWidth, &byHeight);

	std::list<TSlot*> SlotList;
	if (GetPickedSlotList(byWidth, byHeight, &SlotList))
	{
		DWORD dwSlotNumber = UI::CWindowManager::Instance().GetAttachingSlotNumber();
		DWORD dwItemIndex = UI::CWindowManager::Instance().GetAttachingIndex();

		if (m_isUseMode)
		{
			TSlot * pSlot = *SlotList.begin();
			TSlot * pCenterSlot;
			if (GetSlotPointer(pSlot->dwCenterSlotNumber, &pCenterSlot))
			if (pCenterSlot->isItem)
			{
				if (m_isUsableItem)
					CPythonGraphic::Instance().SetDiffuseColor(1.0f, 1.0f, 0.0f, 0.5f);
				else
					CPythonGraphic::Instance().SetDiffuseColor(1.0f, 0.0f, 0.0f, 0.5f);

				CPythonGraphic::Instance().RenderBar2d(	m_rect.left + pCenterSlot->ixPosition,
														m_rect.top + pCenterSlot->iyPosition,
														m_rect.left + pCenterSlot->ixPosition + pCenterSlot->byxPlacedItemSize * ITEM_WIDTH,
														m_rect.top + pCenterSlot->iyPosition + pCenterSlot->byyPlacedItemSize * ITEM_HEIGHT);
				return;
			}
		}

		if (CheckMoving(dwSlotNumber, dwItemIndex, SlotList))
			CPythonGraphic::Instance().SetDiffuseColor(1.0f, 1.0f, 1.0f, 0.5f);
		else
			CPythonGraphic::Instance().SetDiffuseColor(1.0f, 0.0f, 0.0f, 0.5f);

		RECT Rect;
		Rect.left = m_rect.right;
		Rect.top = m_rect.bottom;
		Rect.right = 0;
		Rect.bottom = 0;

		for (std::list<TSlot*>::iterator itor = SlotList.begin(); itor != SlotList.end(); ++itor)
		{
			TSlot * pSlot = *itor;
			Rect.left = min(Rect.left, m_rect.left + pSlot->ixPosition);
			Rect.top = min(Rect.top, m_rect.top + pSlot->iyPosition);
			Rect.right = max(Rect.right, m_rect.left + pSlot->ixPosition + pSlot->byxPlacedItemSize*ITEM_WIDTH);
			Rect.bottom = max(Rect.bottom, m_rect.top + pSlot->iyPosition + pSlot->byxPlacedItemSize*ITEM_HEIGHT);
		}

		CPythonGraphic::Instance().RenderBar2d(Rect.left, Rect.top, Rect.right, Rect.bottom);
	}
}

BOOL CGridSlotWindow::GetPickedSlotPointer(TSlot ** ppSlot)
{
	if (!UI::CWindowManager::Instance().IsAttaching())
		return CSlotWindow::GetPickedSlotPointer(ppSlot);

	BYTE byWidth, byHeight;
	UI::CWindowManager::Instance().GetAttachingIconSize(&byWidth, &byHeight);

	std::list<TSlot*> SlotList;
	if (!GetPickedSlotList(byWidth, byHeight, &SlotList))
		return FALSE;

	TSlot * pMinSlot = NULL;
	//DWORD dwSlotNumber = UI::CWindowManager::Instance().GetAttachingSlotNumber();
	//DWORD dwAttachingItemIndex = UI::CWindowManager::Instance().GetAttachingIndex();

	for (std::list<TSlot*>::iterator itor = SlotList.begin(); itor != SlotList.end(); ++itor)
	{
		TSlot * pSlot = *itor;

		if (!pMinSlot)
		{
			pMinSlot = pSlot;
		}
		else
		{
			if (pSlot->dwSlotNumber < pMinSlot->dwSlotNumber)
			{
				pMinSlot = pSlot;
			}
			else
			{
				if (!pMinSlot->isItem && pSlot->isItem)
				{
					pMinSlot = pSlot;
				}
			}
		}
	}

	if (!pMinSlot)
	{
		return FALSE;
	}
	else
	{
		TSlot * pCenterSlot;
		if (!GetSlotPointer(pMinSlot->dwCenterSlotNumber, &pCenterSlot))
			return FALSE;

		*ppSlot = pCenterSlot;

		if (UI::CWindowManager::Instance().IsAttaching())
		{
			DWORD dwSlotNumber = UI::CWindowManager::Instance().GetAttachingSlotNumber();

			if (dwSlotNumber == pCenterSlot->dwSlotNumber)
			{
				*ppSlot = pMinSlot;
			}
		}
	}

	return TRUE;
}

BOOL CGridSlotWindow::GetPickedSlotList(int iWidth, int iHeight, std::list<TSlot*> * pSlotPointerList)
{
	long lx, ly;
	GetMouseLocalPosition(lx, ly);

	if (lx < 0)
		return FALSE;
	if (ly < 0)
		return FALSE;
	if (lx >= GetWidth())
		return FALSE;
	if (ly >= GetHeight())
		return FALSE;

	pSlotPointerList->clear();

	int ix, iy;
	if (GetPickedGridSlotPosition(lx, ly, &ix, &iy))
	{
		int ixHalfStep = (iWidth / 2);
		//int iyHalfStep = (iHeight / 2);

		int ixStart = int(ix) - int(ixHalfStep - (ixHalfStep % 2));
		int ixEnd = int(ix) + int(ixHalfStep);

		int iyStart = 0, iyEnd = 0;

		if (1 == iHeight)
		{
			iyStart = iy;
			iyEnd = iy;
		}
		else if (2 == iHeight)
		{
			iyStart = iy;
			iyEnd = iy + 1;
		}
		else if (3 == iHeight)
		{
			iyStart = iy - 1;
			iyEnd = iy + 1;
		}

		if (ixStart < 0)
		{
			ixEnd += -ixStart;
			ixStart = 0;
		}

		if (iyStart < 0)
		{
			iyEnd += -iyStart;
			iyStart = 0;
		}

		if (DWORD(ixEnd) >= m_dwxCount)
		{
			int ixTemporary = DWORD(ixEnd) - m_dwxCount + 1;
			ixStart -= ixTemporary;
			ixEnd -= ixTemporary;
		}

		if (DWORD(iyEnd) >= m_dwyCount)
		{
			int iyTemporary = DWORD(iyEnd) - m_dwyCount + 1;
			iyStart -= iyTemporary;
			iyEnd -= iyTemporary;
		}

		for (int i = ixStart; i <= ixEnd; ++i)
		for (int j = iyStart; j <= iyEnd; ++j)
		{
			TSlot * pSlot;
			if (GetGridSlotPointer(DWORD(i), DWORD(j), &pSlot))
			{
				pSlotPointerList->push_back(pSlot);
			}
		}

		if (m_isUseMode && 1 == pSlotPointerList->size())
		{
			TSlot * pMainSlot = *pSlotPointerList->begin();

			std::vector<TSlot *>::iterator itor = m_SlotVector.begin();
			for (; itor != m_SlotVector.end(); ++itor)
			{
				TSlot * pSlot = *itor;
				if (pSlot->dwCenterSlotNumber == pMainSlot->dwCenterSlotNumber)
				if (pSlotPointerList->end() == std::find(pSlotPointerList->begin(), pSlotPointerList->end(), pSlot))
				{
					pSlotPointerList->push_back(pSlot);
				}
			}
		}

		if (!pSlotPointerList->empty())
			return TRUE;
	}

	return FALSE;
}

BOOL CGridSlotWindow::GetGridSlotPointer(int ix, int iy, TSlot ** ppSlot)
{
	DWORD dwSlotIndex = ix + iy*m_dwxCount;
	if (dwSlotIndex >= m_SlotVector.size())
		return FALSE;

	*ppSlot = m_SlotVector[dwSlotIndex];

	return TRUE;
}

BOOL CGridSlotWindow::GetPickedGridSlotPosition(int ixLocal, int iyLocal, int * pix, int * piy)
{
	for (DWORD x = 0; x < m_dwxCount; ++x)
	for (DWORD y = 0; y < m_dwyCount; ++y)
	{
		TSlot * pSlot;
		if (!GetGridSlotPointer(x, y, &pSlot))
			continue;

		if (ixLocal >= pSlot->ixPosition)
		if (iyLocal >= pSlot->iyPosition)
		if (ixLocal <= pSlot->ixPosition + pSlot->ixCellSize)
		if (iyLocal <= pSlot->iyPosition + pSlot->iyCellSize)
		{
			*pix = x;
			*piy = y;
			return TRUE;
		}
	}

	return FALSE;
}

void CGridSlotWindow::ArrangeGridSlot(DWORD dwStartIndex, DWORD dwxCount, DWORD dwyCount, int ixSlotSize, int iySlotSize, int ixTemporarySize, int iyTemporarySize)
{
	Destroy();

	m_dwxCount = dwxCount;
	m_dwyCount = dwyCount;

	m_SlotVector.clear();
	m_SlotVector.resize(dwxCount*dwyCount);

	for (DWORD x = 0; x < dwxCount; ++x)
	for (DWORD y = 0; y < dwyCount; ++y)
	{
		DWORD dwIndex = dwStartIndex + x + y * dwxCount;
		int ixPosition = x * (ixSlotSize + ixTemporarySize);
		int iyPosition = y * (iySlotSize + iyTemporarySize);

		AppendSlot(dwIndex, ixPosition, iyPosition, ixSlotSize, iySlotSize);

		m_SlotVector[x+y*dwxCount] = &(*m_SlotList.rbegin());
	}

	int iWidth = dwxCount * (ixSlotSize + ixTemporarySize);
	int iHeight = dwyCount * (iySlotSize + iyTemporarySize);
	SetSize(iWidth, iHeight);
}

void CGridSlotWindow::OnRefreshSlot()
{
	DWORD x, y;

	for (x = 0; x < m_dwxCount; ++x)
	for (y = 0; y < m_dwyCount; ++y)
	{
		TSlot * pSlot;
		if (!GetGridSlotPointer(x, y, &pSlot))
			continue;

		pSlot->dwCenterSlotNumber = pSlot->dwSlotNumber;
	}

	for (x = 0; x < m_dwxCount; ++x)
	for (y = 0; y < m_dwyCount; ++y)
	{
		TSlot * pSlot;
		if (!GetGridSlotPointer(x, y, &pSlot))
			continue;

		if (pSlot->isItem)
		{
			for (DWORD xSub = 0; xSub < pSlot->byxPlacedItemSize; ++xSub)
			for (DWORD ySub = 0; ySub < pSlot->byyPlacedItemSize; ++ySub)
			{
				TSlot * pSubSlot;
				if (!GetGridSlotPointer(x+xSub, y+ySub, &pSubSlot))
					continue;

				pSubSlot->dwCenterSlotNumber = pSlot->dwSlotNumber;
				pSubSlot->dwItemIndex = pSlot->dwItemIndex;
			}
		}
		else
		{
			pSlot->dwItemIndex = 0;
		}
	}
}

BOOL CGridSlotWindow::CheckMoving(DWORD dwSlotNumber, DWORD dwItemIndex, const std::list<TSlot*> & c_rSlotList)
{
	if (m_dwSlotStyle != SLOT_STYLE_PICK_UP)
		return TRUE;

	for (std::list<TSlot*>::const_iterator itor = c_rSlotList.begin(); itor != c_rSlotList.end(); ++itor)
	{
		TSlot * pSlot = *itor;

		if (dwSlotNumber != pSlot->dwCenterSlotNumber)
		{
			if (0 != pSlot->dwItemIndex || pSlot->dwCenterSlotNumber != pSlot->dwSlotNumber)
			{
				if (dwItemIndex != pSlot->dwItemIndex)
					return false;
			}
		}
	}

	return true;
}

void CGridSlotWindow::Destroy()
{
	CSlotWindow::Destroy();

	m_SlotVector.clear();

	__Initialize();
}

void CGridSlotWindow::__Initialize()
{
	m_dwxCount = 0;
	m_dwyCount = 0;
}

DWORD CGridSlotWindow::Type()
{
	static int s_Type = GetCRC32("CGridSlotWindow", strlen("CGridSlotWindow"));
	return s_Type;
}

BOOL CGridSlotWindow::OnIsType(DWORD dwType)
{
	if (CGridSlotWindow::Type() == dwType)
		return TRUE;

	return CSlotWindow::OnIsType(dwType);
}

CGridSlotWindow::CGridSlotWindow(PyObject * ppyObject) : CSlotWindow(ppyObject)
{
}

CGridSlotWindow::~CGridSlotWindow()
{
}
