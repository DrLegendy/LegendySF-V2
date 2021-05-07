
#ifndef HACK_SHIELD_IMPL_H_
#define HACK_SHIELD_IMPL_H_

#ifdef ENABLE_HSHIELD_SYSTEM
#include <boost/unordered_map.hpp>
#endif

#ifdef __FreeBSD__
// Live build only
#define UNIX
#ifdef ENABLE_HSHIELD_SYSTEM
#include <AntiCpXSvr.h>
#endif
#undef UNIX
#endif

#pragma pack(1)

typedef struct SPacketGCHSCheck
{
	BYTE	bHeader;
#ifdef __FreeBSD__
#ifdef ENABLE_HSHIELD_SYSTEM
	AHNHS_TRANS_BUFFER Req;
#endif
#endif
} TPacketGCHSCheck;

#pragma pack()

class CHackShieldImpl
{
	public:
		bool Initialize ();
		void Release ();

		bool CreateClientHandle (DWORD dwPlayerID);
		void DeleteClientHandle (DWORD dwPlayerID);

		bool SendCheckPacket (LPCHARACTER ch);
		bool VerifyAck (LPCHARACTER ch, TPacketGCHSCheck* buf);

	private:
#ifdef __FreeBSD__
#ifdef ENABLE_HSHIELD_SYSTEM
		AHNHS_SERVER_HANDLE handle_;

		typedef boost::unordered_map<DWORD, AHNHS_CLIENT_HANDLE> ClientHandleContainer;
		ClientHandleContainer CliehtHandleMap_;

		typedef boost::unordered_map<DWORD, bool> ClientCheckContainer;
		ClientCheckContainer ClientCheckMap_;
#endif
#endif
};

#endif /* HACK_SHIELD_IMPL_H_ */

