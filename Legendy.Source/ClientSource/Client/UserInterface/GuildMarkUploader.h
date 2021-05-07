#pragma once

#include "../EterLib/NetStream.h"
#include "MarkImage.h"

#ifdef __VTUNE__

class CGuildMarkUploader : public CNetworkStream, public CSingleton<CGuildMarkUploader>
{
	public:
		enum
		{
			ERROR_NONE,
			ERROR_CONNECT,
			ERROR_LOAD,
			ERROR_WIDTH,
			ERROR_HEIGHT,
		};

	public:
		CGuildMarkUploader() {}
		virtual ~CGuildMarkUploader() {}

		void Disconnect() {}
		bool Connect(const CNetworkAddress& c_rkNetAddr, DWORD dwHandle, DWORD dwRandomKey, DWORD dwGuildID, const char* c_szFileName, UINT* peError) {return false;}
		bool ConnectToSendSymbol(const CNetworkAddress& c_rkNetAddr, DWORD dwHandle, DWORD dwRandomKey, DWORD dwGuildID, const char* c_szFileName, UINT* peError) {return false;}
		void Process() {}
};

#else

#include <il/il.h>

class CGuildMarkUploader : public CNetworkStream, public CSingleton<CGuildMarkUploader>
{
	public:
		enum
		{
			ERROR_NONE,
			ERROR_CONNECT,
			ERROR_LOAD,
			ERROR_WIDTH,
			ERROR_HEIGHT,
		};

		enum
		{
			SEND_TYPE_MARK,
			SEND_TYPE_SYMBOL,
		};

	public:
		CGuildMarkUploader();
		virtual ~CGuildMarkUploader();

		void Disconnect();
		bool Connect(const CNetworkAddress& c_rkNetAddr, DWORD dwHandle, DWORD dwRandomKey, DWORD dwGuildID, const char* c_szFileName, UINT* peError);
		bool ConnectToSendSymbol(const CNetworkAddress& c_rkNetAddr, DWORD dwHandle, DWORD dwRandomKey, DWORD dwGuildID, const char* c_szFileName, UINT* peError);
		bool IsCompleteUploading();

		void Process();

	private:
		enum
		{
			STATE_OFFLINE,
			STATE_LOGIN,
			STATE_COMPLETE,
		};

	private:
		void OnConnectFailure();
		void OnConnectSuccess();
		void OnRemoteDisconnect();
		void OnDisconnect();

		bool __Load(const char* c_szFileName, UINT* peError);
		bool __LoadSymbol(const char* c_szFileName, UINT* peError);

		bool __Save(const char* c_szFileName);

		void __Inialize();
		bool __StateProcess();

		void __OfflineState_Set();
		void __CompleteState_Set();

		void __LoginState_Set();
		bool __LoginState_Process();
		bool __LoginState_RecvPhase();
		bool __LoginState_RecvHandshake();
		bool __LoginState_RecvPing();
#ifdef _IMPROVED_PACKET_ENCRYPTION_
		bool __LoginState_RecvKeyAgreement();
		bool __LoginState_RecvKeyAgreementCompleted();
#endif

		bool __AnalyzePacket(UINT uHeader, UINT uPacketSize, bool (CGuildMarkUploader::*pfnDispatchPacket)());

		bool __SendMarkPacket();
		bool __SendSymbolPacket();

	private:
		UINT m_eState;

		DWORD m_dwSendType;
		DWORD m_dwHandle;
		DWORD m_dwRandomKey;
		DWORD m_dwGuildID;

		SGuildMark m_kMark;

		DWORD m_dwSymbolBufSize;
		DWORD m_dwSymbolCRC32;
		BYTE * m_pbySymbolBuf;
};

#endif