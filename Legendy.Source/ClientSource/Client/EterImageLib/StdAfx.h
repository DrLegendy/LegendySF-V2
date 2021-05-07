// stdafx.h : include file for standard system include files,
//  or project specific include files that are used frequently, but
//      are changed infrequently
//

#if !defined(AFX_STDAFX_H__BCF68E23_E7D8_4BF3_A905_AFDBEF92B0F6__INCLUDED_)
#define AFX_STDAFX_H__BCF68E23_E7D8_4BF3_A905_AFDBEF92B0F6__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#pragma warning(disable:4786)

#define WIN32_LEAN_AND_MEAN		// Exclude rarely-used stuff from Windows headers

//#include <crtdbg.h>
#include "../UserInterface/Locale_inc.h"
#include <windows.h>
#include <assert.h>

#pragma warning(push, 3)
#include <string>
#include <vector>
#pragma warning(pop)

inline void _TraceForImage(const char* c_szFormat, ...)
{
	va_list args;
	va_start(args, c_szFormat);

	static char szBuf[1024];
	_vsnprintf(szBuf, sizeof(szBuf), c_szFormat, args);
#ifdef _DEBUG
	OutputDebugString(szBuf);
#endif
	va_end(args);
	printf(szBuf);
}

#pragma warning(default:4018)

// TODO: reference additional headers your program requires here

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDAFX_H__BCF68E23_E7D8_4BF3_A905_AFDBEF92B0F6__INCLUDED_)
