#include "StdAfx.h"
#include "Packet.h"
#include "ServerStateChecker.h"

#include "../eterLib/NetAddress.h"

#pragma pack(push)
#pragma pack(1)

typedef unsigned char ServerStateChecker_Header;
typedef unsigned long ServerStateChecker_Key;
typedef unsigned long ServerStateChecker_Index;
typedef unsigned char ServerStateChecker_State;

#pragma pack(pop)

CServerStateChecker::CServerStateChecker()
{
	Initialize();
}

CServerStateChecker::~CServerStateChecker()
{
	Initialize();
	m_poWnd = NULL;
}

void CServerStateChecker::Create(PyObject* poWnd)
{
	m_poWnd = poWnd;
}

void CServerStateChecker::AddChannel(UINT uServerIndex, const char* c_szAddr, UINT uPort)
{
	TChannel c;
	c.uServerIndex = uServerIndex;
	c.c_szAddr = c_szAddr;
	c.uPort = uPort;

	m_lstChannel.push_back(c);
}

void CServerStateChecker::Request()
{
	if (m_lstChannel.empty()) {
		return;
	}

	if (!m_kStream.Connect(m_lstChannel.begin()->c_szAddr, m_lstChannel.begin()->uPort))
	{
		for (std::list<TChannel>::const_iterator it = m_lstChannel.begin(); it != m_lstChannel.end(); ++it) {
			PyCallClassMemberFunc(m_poWnd, "NotifyChannelState", Py_BuildValue("(ii)", it->uServerIndex, 0));
		}
		return;
	}
	m_kStream.ClearRecvBuffer();
	m_kStream.SetSendBufferSize(1024);
	m_kStream.SetRecvBufferSize(1024);

	BYTE bHeader = HEADER_CG_STATE_CHECKER;
	if (!m_kStream.Send(sizeof(bHeader), &bHeader))
	{
		for (std::list<TChannel>::const_iterator it = m_lstChannel.begin(); it != m_lstChannel.end(); ++it) {
			PyCallClassMemberFunc(m_poWnd, "NotifyChannelState", Py_BuildValue("(ii)", it->uServerIndex, 0));
		}
		Initialize();
		return;
	}
}

void CServerStateChecker::Update()
{
	m_kStream.Process();

	BYTE bHeader;
	if (!m_kStream.Recv(sizeof(bHeader), &bHeader)) {
		return;
	}
	if (HEADER_GC_RESPOND_CHANNELSTATUS != bHeader) {
		return;
	}
	int nSize;
	if (!m_kStream.Recv(sizeof(nSize), &nSize)) {
		return;
	}
	for (int i = 0; i < nSize; i++) {
		TChannelStatus channelStatus;
		if (!m_kStream.Recv(sizeof(channelStatus), &channelStatus)) {
			return;
		}
		for (std::list<TChannel>::const_iterator it = m_lstChannel.begin(); it != m_lstChannel.end(); ++it) {
			if (channelStatus.nPort == it->uPort) {
				PyCallClassMemberFunc(m_poWnd, "NotifyChannelState", Py_BuildValue("(ii)", it->uServerIndex, channelStatus.bStatus));
				break;
			}
		}
	}
	Initialize();
}

void CServerStateChecker::Initialize()
{
	m_lstChannel.clear();
	m_kStream.Disconnect();
}