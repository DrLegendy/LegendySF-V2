#include "StdAfx.h"

#include <stdio.h>
#include <time.h>
#include <winsock.h>
#include <imagehlp.h>

FILE * fException;

#define ENABLE_CRASH_MINIDUMP
#ifdef ENABLE_CRASH_MINIDUMP
#include "../UserInterface/Version.h"
#include <iomanip>
#include <sstream>
void make_minidump(EXCEPTION_POINTERS* e)
{
	auto hDbgHelp = LoadLibraryA("dbghelp");
	if (hDbgHelp == nullptr)
		return;
	auto pMiniDumpWriteDump = (decltype(&MiniDumpWriteDump))GetProcAddress(hDbgHelp, "MiniDumpWriteDump");
	if (pMiniDumpWriteDump == nullptr)
		return;
	// folder name
	std::string folder = "logs";
	CreateDirectoryA(folder.c_str(), nullptr);
	// time format
	auto t = std::time(nullptr);
	std::ostringstream timefmt;
	timefmt << std::put_time(std::localtime(&t), "%Y%m%d_%H%M%S");
	// filename
	std::string filename = folder + "\\"s + "metin2client_"s + std::to_string(METIN2_GET_VERSION()) + "_"s + timefmt.str() + ".dmp";

	auto hFile = CreateFileA(filename.c_str(), GENERIC_WRITE, FILE_SHARE_READ, 0, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
	if (hFile == INVALID_HANDLE_VALUE)
		return;

	MINIDUMP_EXCEPTION_INFORMATION exceptionInfo;
	exceptionInfo.ThreadId = GetCurrentThreadId();
	exceptionInfo.ExceptionPointers = e;
	exceptionInfo.ClientPointers = FALSE;

	auto dumped = pMiniDumpWriteDump(
		GetCurrentProcess(),
		GetCurrentProcessId(),
		hFile,
		MINIDUMP_TYPE(MiniDumpWithIndirectlyReferencedMemory | MiniDumpScanMemory),
		e ? &exceptionInfo : nullptr,
		nullptr,
		nullptr);

	CloseHandle(hFile);

	// std::string errMsg = "The application crashed. Send the generated file to the staff: "s + name;
	// MessageBox(nullptr, errMsg.c_str(), "Metin2Client", MB_ICONSTOP);

	return;
}
#endif

LONG __stdcall EterExceptionFilter(_EXCEPTION_POINTERS * pExceptionInfo)
{
#ifdef ENABLE_CRASH_MINIDUMP
	make_minidump(pExceptionInfo);
#else
	// eterlog trash
#endif
	return EXCEPTION_EXECUTE_HANDLER;
}

void SetEterExceptionHandler()
{
	SetUnhandledExceptionFilter(EterExceptionFilter);
}
