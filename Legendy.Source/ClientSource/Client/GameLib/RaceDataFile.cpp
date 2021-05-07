#include "StdAfx.h"
#include "../eterLib/ResourceManager.h"

#include "RaceData.h"
#include "RaceMotionData.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define ENABLE_SKIN_EXTENDED
BOOL CRaceData::LoadRaceData(const char * c_szFileName)
{
	CTextFileLoader TextFileLoader;
	if (!TextFileLoader.Load(c_szFileName))
		return FALSE;

	TextFileLoader.SetTop();

	TextFileLoader.GetTokenString("basemodelfilename", &m_strBaseModelFileName);
	TextFileLoader.GetTokenString("treefilename", &m_strTreeFileName);
	TextFileLoader.GetTokenString("attributefilename", &m_strAttributeFileName);
	TextFileLoader.GetTokenString("smokebonename", &m_strSmokeBoneName);
	TextFileLoader.GetTokenString("motionlistfilename", &m_strMotionListFileName);

	if (!m_strTreeFileName.empty())
	{
		CFileNameHelper::StringPath(m_strTreeFileName);
	}

	CTokenVector* pSmokeTokenVector;
	if (TextFileLoader.GetTokenVector("smokefilename", &pSmokeTokenVector))
	{
		if (pSmokeTokenVector->size()%2!=0)
		{
			TraceError("SmokeFileName ArgCount[%d]%2==0", pSmokeTokenVector->size());
			return FALSE;
		}

		UINT uLineCount=pSmokeTokenVector->size()/2;

		for (UINT uLine=0; uLine<uLineCount; ++uLine)
		{
			int eSmoke=atoi(pSmokeTokenVector->at(uLine*2+0).c_str());
			if (eSmoke<0 || eSmoke>=SMOKE_NUM)
			{
				TraceError("SmokeFileName SmokeNum[%d] OUT OF RANGE", eSmoke);
				return FALSE;
			}

			const std::string& c_rstrEffectFileName = pSmokeTokenVector->at(uLine*2+1);

			DWORD& rdwCRCEft=m_adwSmokeEffectID[eSmoke];
			if (!CEffectManager::Instance().RegisterEffect2(c_rstrEffectFileName.c_str(), &rdwCRCEft))
			{
				TraceError("CRaceData::RegisterEffect2(%s) ERROR", c_rstrEffectFileName.c_str());
				rdwCRCEft=0;
				return false;
			}
		}
	}

	if (TextFileLoader.SetChildNode("shapedata"))
	{
		std::string strPathName;
		DWORD dwShapeDataCount = 0;
		if (TextFileLoader.GetTokenString("pathname", &strPathName) &&
			TextFileLoader.GetTokenDoubleWord("shapedatacount", &dwShapeDataCount))
		{
			for (DWORD i = 0; i < dwShapeDataCount; ++i)
			{
				if (!TextFileLoader.SetChildNode("shapedata", i))
				{
					continue;
				}

				/////////////////////////
				TextFileLoader.GetTokenString("specialpath", &strPathName);
				/////////////////////////

				DWORD dwShapeIndex;
				if (!TextFileLoader.GetTokenDoubleWord("shapeindex", &dwShapeIndex))
				{
					continue;
				}

				// LOCAL_PATH_SUPPORT
				std::string strModel;
				if (TextFileLoader.GetTokenString("model", &strModel))
				{
					SetShapeModel(dwShapeIndex, (strPathName + strModel).c_str());
				}
				else
				{
					if (!TextFileLoader.GetTokenString("local_model", &strModel))
						continue;

					SetShapeModel(dwShapeIndex, strModel.c_str());
				}
				// END_OF_LOCAL_PATH_SUPPORT



				std::string strSourceSkin;
				std::string strTargetSkin;
#ifdef ENABLE_SKIN_EXTENDED
				static char __szSkin1[11+1];
				static char __szSkin2[11+1];
#endif
				// LOCAL_PATH_SUPPORT
				if (TextFileLoader.GetTokenString("local_sourceskin", &strSourceSkin) &&
					TextFileLoader.GetTokenString("local_targetskin", &strTargetSkin))
				{
					AppendShapeSkin(dwShapeIndex, 0, strSourceSkin.c_str(), strTargetSkin.c_str());
				}
				// END_OF_LOCAL_PATH_SUPPORT

				if (TextFileLoader.GetTokenString("sourceskin", &strSourceSkin) &&
					TextFileLoader.GetTokenString("targetskin", &strTargetSkin))
				{
					AppendShapeSkin(dwShapeIndex, 0, (strPathName + strSourceSkin).c_str(), (strPathName + strTargetSkin).c_str());
				}
#ifdef ENABLE_SKIN_EXTENDED
				for (DWORD i=2; i<=9; i++)
				{
					_snprintf(__szSkin1, sizeof(__szSkin1), "sourceskin%u", i);
					_snprintf(__szSkin2, sizeof(__szSkin2), "targetskin%u", i);
					if (TextFileLoader.GetTokenString(__szSkin1, &strSourceSkin) &&
						TextFileLoader.GetTokenString(__szSkin2, &strTargetSkin))
					{
						AppendShapeSkin(dwShapeIndex, 0, (strPathName + strSourceSkin).c_str(), (strPathName + strTargetSkin).c_str());
					}
				}
#else
				if (TextFileLoader.GetTokenString("sourceskin2", &strSourceSkin) &&
					TextFileLoader.GetTokenString("targetskin2", &strTargetSkin))
				{
					AppendShapeSkin(dwShapeIndex, 0, (strPathName + strSourceSkin).c_str(), (strPathName + strTargetSkin).c_str());
				}
#endif
				TextFileLoader.SetParentNode();
			}
		}

		TextFileLoader.SetParentNode();
	}

	if (TextFileLoader.SetChildNode("hairdata"))
	{
		std::string strPathName;
		DWORD dwHairDataCount = 0;
		if (TextFileLoader.GetTokenString("pathname", &strPathName) &&
			TextFileLoader.GetTokenDoubleWord("hairdatacount", &dwHairDataCount))
		{

			for (DWORD i = 0; i < dwHairDataCount; ++i)
			{
				if (!TextFileLoader.SetChildNode("hairdata", i))
				{
					continue;
				}

				/////////////////////////
				TextFileLoader.GetTokenString("specialpath", &strPathName);
				/////////////////////////

				DWORD dwShapeIndex;
				if (!TextFileLoader.GetTokenDoubleWord("hairindex", &dwShapeIndex))
				{
					continue;
				}

				std::string strModel;
				std::string strSourceSkin;
				std::string strTargetSkin;
				if (TextFileLoader.GetTokenString("model", &strModel) &&
					TextFileLoader.GetTokenString("sourceskin", &strSourceSkin) &&
					TextFileLoader.GetTokenString("targetskin", &strTargetSkin))
				{
					SetHairSkin(dwShapeIndex, 0, (strPathName + strModel).c_str(), (strPathName + strSourceSkin).c_str(), (strPathName + strTargetSkin).c_str());
				}

				TextFileLoader.SetParentNode();
			}
		}

		TextFileLoader.SetParentNode();
	}


	if (TextFileLoader.SetChildNode("attachingdata"))
	{
		if (!NRaceData::LoadAttachingData(TextFileLoader, &m_AttachingDataVector))
			return FALSE;

		TextFileLoader.SetParentNode();
	}

	return TRUE;
}
