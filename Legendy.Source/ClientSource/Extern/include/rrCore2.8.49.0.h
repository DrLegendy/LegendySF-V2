// ========================================================================
// (C) Copyright 1994- 2010 RAD Game Tools, Inc.  Global types header file
// ========================================================================

//  __RAD16__ means 16 bit code (Win16)
//  __RAD32__ means 32 bit code (DOS, Win386, Win32s, Mac AND Win64)
//  __RAD64__ means 64 bit code (x64)

// Note oddness - __RAD32__ essentially means "at *least* 32-bit code".
// So, on 64-bit systems, both __RAD32__ and __RAD64__ will be defined.

//  __RADDOS__ means DOS code (16 or 32 bit)
//  __RADWIN__ means Windows API (Win16, Win386, Win32s, Win64, Xbox, Xenon)
//  __RADWINEXT__ means Windows 386 extender (Win386)
//  __RADNT__ means Win32 or Win64 code
//  __RADMAC__ means Macintosh
//  __RADCARBON__ means Carbon
//  __RADMACH__ means MachO
//  __RADXBOX__ means the XBox console
//  __RADXENON__ means the Xenon console
//  __RADNGC__ means the Nintendo GameCube
//  __RADWII__ means the Nintendo Wii
//  __RADNDS__ means the Nintendo DS
//  __RADTWL__ means the Nintendo DSi (__RADNDS__ also defined)
//  __RAD3DS__ means the Nintendo 3DS
//  __RADPS2__ means the Sony PlayStation 2
//  __RADPSP__ means the Sony PlayStation Portable
//  __RADPS3__ means the Sony PlayStation 3
//  __RADNTBUILDLINUX__ means building Linux on NT
//  __RADLINUX__ means actually building on Linux (most likely with GCC)
//  __RADPSP2__ means NGP

//  __RADX86__ means Intel x86
//  __RADMMX__ means Intel x86 MMX instructions are allowed
//  __RAD64__ means Intel/AMD x64 (NOT IA64=Itanium)
//  __RAD68K__ means 68K
//  __RADPPC__ means PowerPC
//  __RADMIPS__ means Mips (only R5900 right now)
//  __RADARM__ mean ARM processors

// __RADLITTLEENDIAN__ means processor is little-endian (x86)
// __RADBIGENDIAN__ means processor is big-endian (680x0, PPC)

// __RADNOVARARGMACROS__ means #defines can't use ...


#ifndef __RADRR_COREH__
#define __RADRR_COREH__
#define RADCOPYRIGHT "Copyright (C) 1994-2011, RAD Game Tools, Inc."

  #ifndef __RADRES__

    // Theoretically, this is to pad structs on platforms that don't support pragma pack or do it poorly. (PS3, PS2)
    // In general it is assumed that your padding is set via pragma, so this is just a struct.
    #define RADSTRUCT struct

    #ifdef __GNUC_MINOR__
    // make a combined GCC version for testing :

    #define __RAD_GCC_VERSION__ (__GNUC__ * 10000 \
                               + __GNUC_MINOR__ * 100 \
                               + __GNUC_PATCHLEVEL__)

          /* Test for GCC > 3.2.0 */
          // #if GCC_VERSION > 30200
    #endif

    #if defined(__RADX32__)

      #define __RADX86__
      #define __RADMMX__
      #define __RAD32__
      #define __RADLITTLEENDIAN__
      #define RADINLINE inline
      #define RADRESTRICT __restrict

      // known platforms under the RAD generic build type
      #if defined(_WIN32) || defined(_Windows) || defined(WIN32) || defined(__WINDOWS__) || defined(_WINDOWS)
        #define __RADNT__
        #define __RADWIN__
      #elif (defined(__MWERKS__) && !defined(__INTEL__)) || defined(__MRC__) || defined(THINK_C) || defined(powerc) || defined(macintosh) || defined(__powerc) || defined(__APPLE__) || defined(__MACH__)
        #define __RADMAC__
      #elif defined(linux)
        #define __RADLINUX__
      #endif

    #elif defined(_WIN64)

      #define __RADWIN__
      #define __RADNT__
      // See note at top for why both __RAD32__ and __RAD64__ are defined.
      #define __RAD32__
      #define __RAD64__
      #define __RADX64__
      #define __RADMMX__
      #define __RADX86__
      #define __RAD64REGS__
      #define __RADLITTLEENDIAN__
      #define RADINLINE __inline
      #define RADRESTRICT __restrict

    #elif defined(GENERIC_ARM)

      #define __RAD32__
      #define __RADARM__
      #define __RADLITTLEENDIAN__
      #define __RADFIXEDPOINT__
      #define RADINLINE inline
      #define __RADSTATIC__
      #ifdef __GCC__
        #define RADRESTRICT __restrict
      #else
        #define RADRESTRICT // __restrict not supported on cw
      #endif

    #elif defined(HOLLYWOOD_REV) || defined(REVOLUTION)

      #define __RADWII__
      #define __RAD32__
      #define __RADPPC__
      #define __RADBIGENDIAN__
      #define RADINLINE inline
      #define RADRESTRICT __restrict
      #define __RADSTATIC__

    #elif defined(NN_PLATFORM_CTR)

      #define __RAD3DS__
      #define __RAD32__
      #define __RADARM__
      #define __RADLITTLEENDIAN__
      #define __RADSTATIC__
      #define RADINLINE inline
      #define RADRESTRICT
      #undef RADSTRUCT
      #define RADSTRUCT struct __attribute__((__packed__))

    #elif defined(GEKKO)

      #define __RADNGC__
      #define __RAD32__
      #define __RADPPC__
      #define __RADBIGENDIAN__
      #define RADINLINE inline
      #define RADRESTRICT // __restrict not supported on cw
      #define __RADSTATIC__

    #elif defined(SDK_ARM9) || defined(SDK_TWL) || (defined(__arm) && defined(__MWERKS__))

      #define __RADNDS__
      #define __RAD32__
      #define __RADARM__
      #define __RADLITTLEENDIAN__
      #define __RADFIXEDPOINT__
      #define RADINLINE inline
      #define __RADSTATIC__
      #ifdef __GCC__
        #define RADRESTRICT __restrict
      #else
        #define RADRESTRICT // __restrict not supported on cw
      #endif

      #if defined(SDK_TWL)
        #define __RADTWL__
      #endif

    #elif defined(R5900)

      #define __RADPS2__
      #define __RAD32__
      #define __RADMIPS__
      #define __RADLITTLEENDIAN__
      #define RADINLINE inline
      #define RADRESTRICT __restrict
      #define __RAD64REGS__
      #define __RADSTATIC__
      #define U128 u_long128

      #if !defined(__MWERKS__)
        #undef RADSTRUCT
        #define RADSTRUCT struct __attribute__((__packed__))
      #endif

    #elif defined(__psp__)

      #define __RADPSP__
      #define __RAD32__
      #define __RADMIPS__
      #define __RADLITTLEENDIAN__
      #define RADINLINE inline
      #define RADRESTRICT __restrict
      #define __RADSTATIC__

      #if !defined(__MWERKS__)
        #undef RADSTRUCT
        #define RADSTRUCT struct __attribute__((__packed__))
      #endif

    #elif defined(__psp2__)

      #define __RADPSP2__
      #define __RAD32__
      #define __RADARM__
      #define __RADLITTLEENDIAN__
      #define RADINLINE inline
      #define RADRESTRICT __restrict
      #define __RADSTATIC__

      // need packed attribute for struct with snc?
    #elif defined(__CELLOS_LV2__)

      #define __RADSTATIC__
      // CB change : 10-29-10 : RAD64REGS on PPU but NOT SPU

      #ifdef __SPU__
        #define __RADSPU__
        #define __RAD32__
        #define __RADCELL__
        #define __RADBIGENDIAN__
        #define RADINLINE inline
        #define RADRESTRICT __restrict
      #else
        #define __RAD64REGS__
        #define __RADPS3__
        #define __RADPPC__
        #define __RAD32__
        #define __RADCELL__
        #define __RADBIGENDIAN__
        #define RADINLINE inline
        #define RADRESTRICT __restrict
        #define __RADALTIVEC__
      #endif

      #undef RADSTRUCT
      #define RADSTRUCT struct __attribute__((__packed__))

      #ifndef __LP32__
      #error "PS3 32bit ABI support only"
      #endif
    #elif (defined(__MWERKS__) && !defined(__INTEL__)) || defined(__MRC__) || defined(THINK_C) || defined(powerc) || defined(macintosh) || defined(__powerc) || defined(__APPLE__) || defined(__MACH__)
      #ifdef __APPLE__
        #include "TargetConditionals.h"
      #endif

      #if ((defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE) || (defined(TARGET_IPHONE_SIMULATOR) && TARGET_IPHONE_SIMULATOR))

        // iPhone/iPad/iOS
        #define __RADIPHONE__
        #define __RADMACAPI__

        #define __RAD32__
        #define __RADLITTLEENDIAN__
        #define RADINLINE inline
        #define __RADSTATIC__
        #define RADRESTRICT __restrict
        #define __RADMACH__

        #if defined(TARGET_IPHONE_SIMULATOR) && TARGET_IPHONE_SIMULATOR
          //#define __RADX86__
          #define __RADIPHONESIM__
        #elif defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE
          #define __RADARM__
        #endif
      #else

        // An actual MacOSX machine
        #define __RADMAC__
        #define __RADMACAPI__

        #if defined(powerc) || defined(__powerc) || defined(__ppc__)
          #define __RADPPC__
          #define __RADBIGENDIAN__
          #define __RADALTIVEC__
          #define RADRESTRICT
        #elif defined(__i386__)
          #define __RADX86__
          #define __RADMMX__
          #define __RADLITTLEENDIAN__
          #define RADRESTRICT __restrict
        #elif defined(__x86_64__)
          #define __RAD32__
          #define __RAD64__
          #define __RADX64__
          #define __RAD64REGS__
          #define __RADMMX__
          #define __RADLITTLEENDIAN__
          #define RADRESTRICT __restrict
        #else
          #define __RAD68K__
          #define __RADBIGENDIAN__
          #define __RADALTIVEC__
          #define RADRESTRICT
        #endif

        #define __RAD32__

        #if defined(__MWERKS__)
          #if (defined(__cplusplus) || ! __option(only_std_keywords))
            #define RADINLINE inline
          #endif
          #ifdef __MACH__
            #define __RADMACH__
          #endif
        #elif defined(__MRC__)
          #if defined(__cplusplus)
            #define RADINLINE inline
          #endif
        #elif defined(__GNUC__) || defined(__GNUG__) || defined(__MACH__)
          #define RADINLINE inline
          #define __RADMACH__

          #undef RADRESTRICT  /* could have been defined above... */
          #define RADRESTRICT __restrict
        #endif

        #ifdef __RADX86__
          #ifndef __RADCARBON__
            #define __RADCARBON__
          #endif
        #endif

        #ifdef TARGET_API_MAC_CARBON
          #if TARGET_API_MAC_CARBON
            #ifndef __RADCARBON__
              #define __RADCARBON__
            #endif
          #endif
        #endif
      #endif
  #elif defined(linux)

      #define __RADLINUX__
      #define __RADX86__
      #define __RADMMX__
      #define __RAD32__
      #define __RADLITTLEENDIAN__
      #define RADINLINE inline
      #define RADRESTRICT __restrict

    #else

       #if _MSC_VER >= 1400
           #undef RADRESTRICT
           #define RADRESTRICT __restrict
       #else
           #define RADRESTRICT
           #define __RADNOVARARGMACROS__
       #endif

      #if defined(_XENON) || ( defined(_XBOX_VER) && (_XBOX_VER == 200) )
        // Remember that Xenon also defines _XBOX
        #define __RADPPC__
        #define __RADBIGENDIAN__
        #define __RADALTIVEC__
      #else
        #define __RADX86__
        #define __RADMMX__
        #define __RADLITTLEENDIAN__
      #endif

      #ifdef __MWERKS__
        #define _WIN32
      #endif

      #ifdef __DOS__
        #define __RADDOS__
        #define S64_DEFINED // turn off these types
        #define U64_DEFINED
        #define S64 double  //should error
        #define U64 double  //should error
      #endif

      #ifdef __386__
        #define __RAD32__
      #endif

      #ifdef _Windows    //For Borland
        #ifdef __WIN32__
          #define WIN32
        #else
          #define __WINDOWS__
        #endif
      #endif

      #ifdef _WINDOWS    //For MS
        #ifndef _WIN32
          #define __WINDOWS__
        #endif
      #endif

      #ifdef _WIN32
        #if defined(_XENON) || ( defined(_XBOX_VER) && (_XBOX_VER == 200) )
          // Remember that Xenon also defines _XBOX
          #define __RADXENON__
          #define __RAD64REGS__
          #define __RADSTATIC__
        #elif defined(_XBOX)
          #define __RADXBOX__
          #define __RADSTATIC__
        #else
          #define __RADNT__
        #endif
        #define __RADWIN__
        #define __RAD32__
      #else
        #ifdef __NT__
          #if defined(_XENON) || (_XBOX_VER == 200)
          // Remember that Xenon also defines _XBOX
            #define __RADXENON__
            #define __RAD64REGS__
            #define __RADSTATIC__
          #elif defined(_XBOX)
            #define __RADXBOX__
            #define __RADSTATIC__
          #else
            #define __RADNT__
          #endif
          #define __RADWIN__
          #define __RAD32__
        #else
          #ifdef __WINDOWS_386__
            #define __RADWIN__
            #define __RADWINEXT__
            #define __RAD32__
            #define S64_DEFINED // turn off these types
            #define U64_DEFINED
            #define S64 double  //should error
            #define U64 double  //should error
          #else
            #ifdef __WINDOWS__
              #define __RADWIN__
              #define __RAD16__
            #else
              #ifdef WIN32
                #if defined(_XENON) || (_XBOX_VER == 200)
                  // Remember that Xenon also defines _XBOX
                  #define __RADXENON__
                #elif defined(_XBOX)
                  #define __RADXBOX__
                #else
                  #define __RADNT__
                #endif
                #define __RADWIN__
                #define __RAD32__
              #endif
            #endif
          #endif
        #endif
      #endif

      #ifdef __WATCOMC__
        #define RADINLINE
      #else
        #define RADINLINE __inline
      #endif
    #endif

    #if (!defined(__RADDOS__) && !defined(__RADWIN__) && !defined(__RADMAC__) &&      \
         !defined(__RADNGC__) && !defined(__RADNDS__) && !defined(__RADXBOX__) &&     \
         !defined(__RADXENON__) && !defined(__RADLINUX__) && !defined(__RADPS2__) &&  \
         !defined(__RADPSP__) && !defined(__RADPSP2__) && !defined(__RADPS3__)  && !defined(__RADSPU__) && \
         !defined(__RADWII__) && !defined(__RADIPHONE__) && !defined(__RADX32__) && !defined(__RADARM__))
#error "RAD.H did not detect your platform.  Define DOS, WINDOWS, WIN32, macintosh, powerpc, or appropriate console."
    #endif


    #ifdef __RADFINAL__
      #define RADTODO(str) { char __str[0]=str; }
    #else
      #define RADTODO(str)
    #endif

    #ifdef __RADX32__
      #if defined(_MSC_VER)
        #define RADLINK __stdcall
        #define RADEXPLINK __stdcall
      #else
        #define RADLINK __attribute__((stdcall))
        #define RADEXPLINK __attribute__((stdcall))
      #endif
      #define RADEXPFUNC RADDEFFUNC
    #elif (defined(__RADNGC__) || defined(__RADWII__) || defined( __RADPS2__) || \
           defined(__RADPSP__) || defined(__RADPSP2__) || defined(__RADPS3__) || \
           defined(__RADSPU__) || defined(__RADNDS__) || defined(__RADIPHONE__) || \
           defined(__RADARM__))

      #define RADLINK
      #define RADEXPLINK
      #define RADEXPFUNC RADDEFFUNC
      #define RADASMLINK

    #elif defined(__RADLINUX__)

      #define RADLINK __attribute__((cdecl))
      #define RADEXPLINK __attribute__((cdecl))
      #define RADEXPFUNC RADDEFFUNC
      #define RADASMLINK

    #elif defined(__RADMAC__)

      // this define is for CodeWarrior 11's stupid new libs (even though
      //   we don't use longlong's).

      #define __MSL_LONGLONG_SUPPORT__

      #define RADLINK
      #define RADEXPLINK

      #if defined(__CFM68K__) || defined(__MWERKS__)
        #ifdef __RADINDLL__
          #define RADEXPFUNC RADDEFFUNC __declspec(export)
        #else
          #define RADEXPFUNC RADDEFFUNC __declspec(import)
        #endif
      #else
        #if defined(__RADMACH__) && !defined(__MWERKS__)
          #ifdef __RADINDLL__
            #define RADEXPFUNC RADDEFFUNC __attribute__((visibility("default")))
          #else
            #define RADEXPFUNC RADDEFFUNC
          #endif
        #else
          #define RADEXPFUNC RADDEFFUNC
        #endif
      #endif
      #define RADASMLINK

    #else

      #ifdef __RADNT__
        #ifndef _WIN32
          #define _WIN32
        #endif
        #ifndef WIN32
          #define WIN32
        #endif
      #endif

      #ifdef __RADWIN__
        #ifdef __RAD32__
          #ifdef __RADXBOX__

             #define RADLINK __stdcall
             #define RADEXPLINK __stdcall
             #define RADEXPFUNC RADDEFFUNC

          #elif defined(__RADXENON__)

             #define RADLINK __stdcall
             #define RADEXPLINK __stdcall
             #define RADEXPFUNC RADDEFFUNC

          #elif defined(__RADNTBUILDLINUX__)

            #define RADLINK __cdecl
            #define RADEXPLINK __cdecl
            #define RADEXPFUNC RADDEFFUNC

          #else
            #ifdef __RADNT__

              #define RADLINK __stdcall
              #define RADEXPLINK __stdcall

              #ifdef __RADINEXE__
                #define RADEXPFUNC RADDEFFUNC
              #else
                #ifndef __RADINDLL__
                  #define RADEXPFUNC RADDEFFUNC __declspec(dllimport)
                  #ifdef __BORLANDC__
                    #if __BORLANDC__<=0x460
                      #undef RADEXPFUNC
                      #define RADEXPFUNC RADDEFFUNC
                    #endif
                  #endif
                #else
                  #define RADEXPFUNC RADDEFFUNC __declspec(dllexport)
                #endif
              #endif
            #else
              #define RADLINK __pascal
              #define RADEXPLINK __far __pascal
              #define RADEXPFUNC RADDEFFUNC
            #endif
          #endif
        #else
          #define RADLINK __pascal
          #define RADEXPLINK __far __pascal __export
          #define RADEXPFUNC RADDEFFUNC
        #endif
      #else
        #define RADLINK __pascal
        #define RADEXPLINK __pascal
        #define RADEXPFUNC RADDEFFUNC
      #endif

      #define RADASMLINK __cdecl

    #endif

    #if !defined(__RADXBOX__) && !defined(__RADXENON__)
      #ifdef __RADWIN__
        #ifndef _WINDOWS
          #define _WINDOWS
        #endif
      #endif
    #endif

    #ifdef __RADLITTLEENDIAN__
    #ifdef __RADBIGENDIAN__
      #error both endians !?
    #endif
    #endif

    #if !defined(__RADLITTLEENDIAN__) && !defined(__RADBIGENDIAN__)
      #error neither endian!
    #endif


    //-----------------------------------------------------------------

    #ifndef RADDEFFUNC

      #ifdef __cplusplus
        #define RADDEFFUNC extern "C"
        #define RADDEFSTART extern "C" {
        #define RADDEFEND }
        #define RADDEFINEDATA extern "C"
        #define RADDECLAREDATA extern "C"
        #define RADDEFAULT( val ) =val

        #define RR_NAMESPACE       rr
        #define RR_NAMESPACE_START namespace RR_NAMESPACE {
        #define RR_NAMESPACE_END   };
        #define RR_NAMESPACE_USE   using namespace RR_NAMESPACE;

      #else
        #define RADDEFFUNC
        #define RADDEFSTART
        #define RADDEFEND
        #define RADDEFINEDATA
        #define RADDECLAREDATA extern
        #define RADDEFAULT( val )

        #define RR_NAMESPACE
        #define RR_NAMESPACE_START
        #define RR_NAMESPACE_END
        #define RR_NAMESPACE_USE

      #endif

    #endif

   // probably s.b: RAD_DECLARE_ALIGNED(type, name, alignment)
    #if (defined(__RADWII__) || defined(__RADPSP__) || defined(__RADPSP2__) || \
         defined(__RADPS3__) || defined(__RADSPU__) || \
         defined(__RADLINUX__) || defined(__RADMAC__)) || defined(__RADNDS__) || defined(__RADIPHONE__)
      #define RAD_ALIGN(type,var,num) type __attribute__ ((aligned (num))) var
    #elif (defined(__RADNGC__) || defined(__RADPS2__))
      #define RAD_ALIGN(type,var,num) __attribute__ ((aligned (num))) type var
    #elif (_MSC_VER >= 1300)
      #define RAD_ALIGN(type,var,num) type __declspec(align(num)) var
    #else
      #define RAD_ALIGN(type,var,num) type var
    #endif

    #ifdef _MSC_VER
      #ifndef __RADINDLL__
        // note that you can't use this in windows DLLs
        #define RAD_TLS(type,var)   __declspec(thread) type var
      #endif
    #endif


     // Note that __RAD16__/__RAD32__/__RAD64__ refers to the size of a pointer.
    // The size of integers is specified explicitly in the code, i.e. u32 or whatever.

    #define RAD_S8 signed char
    #define RAD_U8 unsigned char

    #if defined(__RAD64__)
      // Remember that __RAD32__ will also be defined!
      #if defined(__RADX64__)
        // x64 still has 32-bit ints!
        #define RAD_U32 unsigned int
        #define RAD_S32 signed int
        // But pointers are 64 bits.
        #if (_MSC_VER >= 1300 && _Wp64)
          #define RAD_SINTa __w64 signed __int64
          #define RAD_UINTa __w64 unsigned __int64
        #else // non-vc.net compiler or /Wp64 turned off
          #define RAD_UINTa unsigned long long
          #define RAD_SINTa signed long long
        #endif
      #else
        #error Unknown 64-bit processor (see radbase.h)
      #endif
    #elif defined(__RAD32__)
      #define RAD_U32 unsigned int
      #define RAD_S32 signed int
      // Pointers are 32 bits.

      #if ( ( defined(_MSC_VER) && (_MSC_VER >= 1300 ) ) && ( defined(_Wp64) && ( _Wp64 ) ) )
        #define RAD_SINTa __w64 signed long
        #define RAD_UINTa __w64 unsigned long
      #else // non-vc.net compiler or /Wp64 turned off
        #ifdef _Wp64
          #define RAD_SINTa signed long
          #define RAD_UINTa unsigned long
        #else
          #define RAD_SINTa signed int
          #define RAD_UINTa unsigned int
        #endif
      #endif
    #else
      #define RAD_U32 unsigned long
      #define RAD_S32 signed long
      // Pointers in 16-bit land are still 32 bits.
      #define RAD_UINTa unsigned long
      #define RAD_SINTa signed long
    #endif

    #define RAD_F32 float
    #if defined(__RADPS2__) || defined(__RADPSP__)
      typedef RADSTRUCT RAD_F64  // do this so that we don't accidentally use doubles
      {                   //  while using the same space
        RAD_U32 vals[ 2 ];
      } RAD_F64;
      #define RAD_F64_OR_32  float    // type is F64 if available, otherwise F32
    #else
      #define RAD_F64 double
      #define RAD_F64_OR_32  double   // type is F64 if available, otherwise F32
    #endif

#if defined(__RADMAC__) || defined(__MRC__) || defined( __RADNGC__ ) || defined(__RADLINUX__) || defined( __RADWII__ ) || defined(__RADNDS__) || defined(__RADPSP__) || defined(__RADPS3__) || defined(__RADSPU__) || defined(__RADIPHONE__)
      #define RAD_U64 unsigned long long
      #define RAD_S64 signed long long
    #elif defined(__RADPS2__)
      #define RAD_U64 unsigned long
      #define RAD_S64 signed long
    #elif defined(__RADARM__)
      #define RAD_U64 unsigned long long
      #define RAD_S64 signed long long
    #elif defined(__RADX64__) || defined(__RAD32__)
      #define RAD_U64 unsigned __int64
      #define RAD_S64 signed __int64
    #else
      // 16-bit
      typedef RADSTRUCT RAD_U64  // do this so that we don't accidentally use U64s
      {                   //  while using the same space
        RAD_U32 vals[ 2 ];
      } RAD_U64;
      typedef RADSTRUCT RAD_S64  // do this so that we don't accidentally use S64s
      {                   //  while using the same space
        RAD_S32 vals[ 2 ];
      } RAD_S64;
    #endif

    #if defined(__RAD32__)
      #define PTR4
      #define RAD_U16 unsigned short
      #define RAD_S16 signed short
    #else
      #define PTR4 __far
      #define RAD_U16 unsigned int
      #define RAD_S16 signed int
    #endif

    //-------------------------------------------------
    // RAD_PTRBITS and such defined here without using sizeof()
    //   so that they can be used in align() and other macros

    #ifdef __RAD64__

        #define RAD_PTRBITS 64
        #define RAD_PTRBYTES 8
        #define RAD_TWOPTRBYTES 16

    #else

        #define RAD_PTRBITS 32
        #define RAD_PTRBYTES 4
        #define RAD_TWOPTRBYTES 8

    #endif


    //-------------------------------------------------
    // UINTr = int the size of a register

    #ifdef __RAD64REGS__

        #define RAD_UINTr RAD_U64
        #define RAD_SINTr RAD_S64

    #else

        #define RAD_UINTr RAD_U32
        #define RAD_SINTr RAD_S32

    #endif

    //===========================================================================

    /*
    // CB : meh this is enough of a mess that it's probably best to just let each
    #if defined(__RADX86__) && defined(_MSC_VER) && _MSC_VER >= 1300
      #define __RADX86INTRIN2003__
    #endif
    */

    // RADASSUME(expr) tells hte compiler that expr is always true
    // RADUNREACHABLE must never be reachable - even in event of error
    //  eg. it's okay for compiler to generate completely invalid code after RADUNREACHABLE

    #ifdef _MSC_VER
        #define RADFORCEINLINE __forceinline
        #if _MSC_VER >= 1300
        #define RADNOINLINE __declspec(noinline)
        #else
        #define RADNOINLINE
        #endif
        #define RADUNREACHABLE __assume(0)
        #define RADASSUME(exp) __assume(exp)
    #elif defined(__GCC__)
        #ifdef _DEBUG
        #define RADFORCEINLINE inline
        #else
        #define RADFORCEINLINE inline __attribute((always_inline))
        #endif
        #define RADNOINLINE __attribute__((noinline))

        #if __RAD_GCC_VERSION__ >= 40500
        #define RADUNREACHABLE __builtin_unreachable()
        #define RADASSUME(exp) __builtin_assume(exp)
        #else
        #define RADUNREACHABLE while(1) { RR_BREAK(); }
        #define RADASSUME(exp)
        #endif
    #elif defined(__CWCC__)
        #define RADFORCEINLINE inline
        #define RADNOINLINE __attribute__((never_inline))
    #else
        // ? #define RADFORCEINLINE ?
        #define RADFORCEINLINE inline
        #define RADNOINLINE
    #endif

    //===========================================================================

    // RAD_ALIGN_HINT tells the compiler how a given pointer is aligned
    //  it *must* be true, but the compiler may or may not use that information
    // it is not for cases where the pointer is to an inherently aligned data type,
    //  it's when the compiler cannot tell the alignment but you have extra information.
    // eg :
    //  U8 * ptr = rrMallocAligned(256,16);
    //  RAD_ALIGN_HINT(ptr,16,0);

    #ifdef __RADSPU__
    #define RAD_ALIGN_HINT(ptr,alignment,offset)        __align_hint(ptr,alignment,offset); RR_ASSERT( ((UINTa)(ptr) & ((alignment)-1)) == (UINTa)(offset) )
    #else
    #define RAD_ALIGN_HINT(ptr,alignment,offset)        RADASSUME( ((UINTa)(ptr) & ((alignment)-1)) == (UINTa)(offset) )
    #endif

    //===========================================================================

    // RAD_EXPECT is to tell the compiler the *likely* value of an expression
    //  different than RADASSUME in that expr might not have that value
    //  it's use for branch code layout and static branch prediction
    // condition can technically be a variable but should usually be 0 or 1

    #ifdef __GCC__

    // __builtin_expect returns value of expr
    #define RAD_EXPECT(expr,cond)   __builtin_expect(expr,cond)

    #else

    #define RAD_EXPECT(expr,cond)   (expr)

    #endif

    // helpers for doing an if ( ) with expect :
    // if ( RAD_LIKELY(expr) ) { ... }
    
    #define RAD_LIKELY(expr)            RAD_EXPECT(expr,1)
    #define RAD_UNLIKELY(expr)          RAD_EXPECT(expr,0)

    //===========================================================================

    // __RADX86ASM__ means you can use __asm {} style inline assembly
    #if defined(__RADX86__) && !defined(__RADX64__) && defined(_MSC_VER)
      #define __RADX86ASM__
    #endif

    //-------------------------------------------------
    // typedefs :

    #ifndef RADNOTYPEDEFS

    #ifndef S8_DEFINED
    #define S8_DEFINED
    typedef RAD_S8 S8;
    #endif

    #ifndef U8_DEFINED
    #define U8_DEFINED
    typedef RAD_U8 U8;
    #endif

    #ifndef S16_DEFINED
    #define S16_DEFINED
    typedef RAD_S16 S16;
    #endif

    #ifndef U16_DEFINED
    #define U16_DEFINED
    typedef RAD_U16 U16;
    #endif

    #ifndef S32_DEFINED
    #define S32_DEFINED
    typedef RAD_S32 S32;
    #endif

    #ifndef U32_DEFINED
    #define U32_DEFINED
    typedef RAD_U32 U32;
    #endif

    #ifndef S64_DEFINED
    #define S64_DEFINED
    typedef RAD_S64 S64;
    #endif

    #ifndef U64_DEFINED
    #define U64_DEFINED
    typedef RAD_U64 U64;
    #endif

    #ifndef F32_DEFINED
    #define F32_DEFINED
    typedef RAD_F32 F32;
    #endif

    #ifndef F64_DEFINED
    #define F64_DEFINED
    typedef RAD_F64 F64;
    #endif

    #ifndef F64_OR_32_DEFINED
    #define F64_OR_32_DEFINED
    typedef RAD_F64_OR_32 F64_OR_32;
    #endif

    // UINTa and SINTa are the ints big enough for an address

    #ifndef SINTa_DEFINED
    #define SINTa_DEFINED
    typedef RAD_SINTa SINTa;
    #endif

    #ifndef UINTa_DEFINED
    #define UINTa_DEFINED
    typedef RAD_UINTa UINTa;
    #endif

    #ifndef UINTr_DEFINED
    #define UINTr_DEFINED
    typedef RAD_UINTr UINTr;
    #endif

    #ifndef SINTr_DEFINED
    #define SINTr_DEFINED
    typedef RAD_SINTr SINTr;
    #endif

    #elif !defined(RADNOTYPEDEFINES)

    #ifndef S8_DEFINED
    #define S8_DEFINED
    #define S8 RAD_S8
    #endif

    #ifndef U8_DEFINED
    #define U8_DEFINED
    #define U8 RAD_U8
    #endif

    #ifndef S16_DEFINED
    #define S16_DEFINED
    #define S16 RAD_S16
    #endif

    #ifndef U16_DEFINED
    #define U16_DEFINED
    #define U16 RAD_U16
    #endif

    #ifndef S32_DEFINED
    #define S32_DEFINED
    #define S32 RAD_S32
    #endif

    #ifndef U32_DEFINED
    #define U32_DEFINED
    #define U32 RAD_U32
    #endif

    #ifndef S64_DEFINED
    #define S64_DEFINED
    #define S64 RAD_S64
    #endif

    #ifndef U64_DEFINED
    #define U64_DEFINED
    #define U64 RAD_U64
    #endif

    #ifndef F32_DEFINED
    #define F32_DEFINED
    #define F32 RAD_F32
    #endif

    #ifndef F64_DEFINED
    #define F64_DEFINED
    #define F64 RAD_F64
    #endif

    #ifndef F64_OR_32_DEFINED
    #define F64_OR_32_DEFINED
    #define F64_OR_32 RAD_F64_OR_32
    #endif

    // UINTa and SINTa are the ints big enough for an address (pointer)
    #ifndef SINTa_DEFINED
    #define SINTa_DEFINED
    #define SINTa RAD_SINTa
    #endif

    #ifndef UINTa_DEFINED
    #define UINTa_DEFINED
    #define UINTa RAD_UINTa
    #endif

    #ifndef UINTr_DEFINED
    #define UINTr_DEFINED
    #define UINTr RAD_UINTr
    #endif

    #ifndef SINTr_DEFINED
    #define SINTr_DEFINED
    #define SINTr RAD_SINTr
    #endif

    #endif

    /// Some error-checking.
    #if defined(__RAD64__) && !defined(__RAD32__)
      // See top of file for why this is.
      #error __RAD64__ must not be defined without __RAD32__ (see radbase.h)
    #endif

// Must be placed after variable declarations for code compiled as .c
#define RR_UNUSED_VARIABLE(x) (void)(sizeof(x))

//--------------------------------------------------

// RR_LINESTRING is the current line number as a string
#define RR_STRINGIZE( L )         #L
#define RR_DO_MACRO( M, X )       M(X)
#define RR_STRINGIZE_DELAY( X )   RR_DO_MACRO( RR_STRINGIZE, X )
#define RR_LINESTRING             RR_STRINGIZE_DELAY( __LINE__ )

#define RR_CAT(X,Y)                 X ## Y

// RR_STRING_JOIN joins strings in the preprocessor and works with LINESTRING
#define RR_STRING_JOIN(arg1, arg2)              RR_STRING_JOIN_DELAY(arg1, arg2)
#define RR_STRING_JOIN_DELAY(arg1, arg2)        RR_STRING_JOIN_IMMEDIATE(arg1, arg2)
#define RR_STRING_JOIN_IMMEDIATE(arg1, arg2)    arg1 ## arg2

// RR_NUMBERNAME is a macro to make a name unique, so that you can use it to declare
//    variable names and they won't conflict with each other
// using __LINE__ is broken in MSVC with /ZI , but __COUNTER__ is an MSVC extension that works

#ifdef _MSC_VER
  #define RR_NUMBERNAME(name) RR_STRING_JOIN(name,__COUNTER__)
#else
  #define RR_NUMBERNAME(name) RR_STRING_JOIN(name,__LINE__)
#endif

#define sizeof32(obj)   ((S32)sizeof(obj))

//--------------------------------------------------
// current plan is to use "rrbool" with plain old "true" and "false"
//  if true and false give us trouble we might have to go to rrtrue and rrfalse
// BTW there's a danger for evil bugs here !!  If you're checking == true
//  then the rrbool must be set to exactly "1" not just "not zero" !!

#ifndef RADNOTYPEDEFS
  #ifndef RRBOOL_DEFINED
    #define RRBOOL_DEFINED
    typedef S32 rrbool;
    typedef S32 RRBOOL;
  #endif
#elif !defined(RADNOTYPEDEFINES)
  #ifndef RRBOOL_DEFINED
    #define RRBOOL_DEFINED
    #define rrbool S32
    #define RRBOOL S32
  #endif
#endif

//--------------------------------------------------
// Range macros

  #ifndef RR_MIN
  #define RR_MIN(a,b)    ( (a) < (b) ? (a) : (b) )
  #endif

  #ifndef RR_MAX
  #define RR_MAX(a,b)    ( (a) > (b) ? (a) : (b) )
  #endif

  #ifndef RR_ABS
  #define RR_ABS(a)      ( ((a) < 0) ? -(a) : (a) )
  #endif

  #ifndef RR_CLAMP
  #define RR_CLAMP(val,lo,hi) RR_MAX( RR_MIN(val,hi), lo )
  #endif

//--------------------------------------------------
// Data layout macros

  #define RR_ARRAY_SIZE(array)  ( sizeof(array)/sizeof(array[0]) )

  // MEMBER_OFFSET tells you the offset of a member in a type
  #ifdef __RAD3DS__
  #define RR_MEMBER_OFFSET(type,member)  ( (char *) &(((type *)0)->member) - (char *) 0 )
  #else
  #define RR_MEMBER_OFFSET(type,member)  ( (size_t) (UINTa) &(((type *)0)->member) )
  #endif
  // MEMBER_SIZE tells you the size of a member in a type
  #define RR_MEMBER_SIZE(type,member)  ( sizeof( ((type *) 0)->member) )

  // MEMBER_TO_OWNER takes a pointer to a member and gives you back the base of the object
  //  you should then RR_ASSERT( &(ret->member) == ptr );
  #define RR_MEMBER_TO_OWNER(type,member,ptr)    (type *)( ((char *)ptr) - RR_MEMBER_OFFSET(type,member) )

//--------------------------------------------------
// LIGHTWEIGHT ASSERTS without rrAssert.h

RADDEFSTART

// set up RR_BREAK :

  #ifdef __RADNGC__

    #define RR_BREAK() asm(" .long 0x00000001")
    #define RR_CACHE_LINE_SIZE      xxx

  #elif defined(__RADWII__)

    #define RR_BREAK() __asm__ volatile("trap")
    #define RR_CACHE_LINE_SIZE      32

  #elif defined(__RAD3DS__)

    #define RR_BREAK() *((int volatile*)0)=0
    #define RR_CACHE_LINE_SIZE xxx

  #elif defined(__RADNDS__)

    #define RR_BREAK() asm("BKPT 0")
    #define RR_CACHE_LINE_SIZE      xxx

  #elif defined(__RADPS2__)

    #define RR_BREAK() __asm__ volatile("break")
    #define RR_CACHE_LINE_SIZE      xxx

  #elif defined(__RADPSP__)

    #define RR_BREAK() __asm__("break 0")
    #define RR_CACHE_LINE_SIZE      xxx

  #elif defined(__RADPSP2__)

    #define RR_BREAK() { __asm__ volatile("bkpt 0x0000"); }
    #define RR_CACHE_LINE_SIZE      xxx

  #elif defined(__RADSPU__)

    #define RR_BREAK() __asm volatile ("stopd 0,1,1")
    #define RR_CACHE_LINE_SIZE      128

  #elif defined(__RADPS3__)

    // #ifdef snPause // in LibSN.h
    // snPause
    // __asm__ volatile ( "tw 31,1,1" )

    #define RR_BREAK()  __asm__ volatile ( "tw 31,1,1" )
    //#define RR_BREAK() __asm__ volatile("trap");

    #define RR_CACHE_LINE_SIZE      128

  #elif defined(__RADMAC__) && !defined(__RADX86__)

    #if defined(__GNUG__) || defined(__GNUC__)
      // CB 5-27-10 : do not use clib assert.h !
      //#include <assert.h>
      #define RR_BREAK() __builtin_trap()
    #else
      #ifdef __RADMACH__
        void DebugStr(unsigned char const *);
      #else
        void pascal DebugStr(unsigned char const *);
      #endif
      #define RR_BREAK() DebugStr("\pRR_BREAK() was called")
    #endif

    #define RR_CACHE_LINE_SIZE      xxx

  #elif defined(__RADIPHONE__)
    #define RR_BREAK() __builtin_trap()
  #elif defined(__RADXENON__)
    #define RR_BREAK() {__debugbreak();}
    #define RR_CACHE_LINE_SIZE      128
  #else
    // x86 :
    #define RR_CACHE_LINE_SIZE      64

    #ifdef __RADLINUX__
      #define RR_BREAK() __asm__ volatile ( "int $3" )
    #elif defined(__WATCOMC__)

      void RR_BREAK( void );
      #pragma aux RR_BREAK = "int 0x3";

    #elif defined(__RADWIN__) && defined(_MSC_VER) && _MSC_VER >= 1300

      #define RR_BREAK __debugbreak

    #else

      #define RR_BREAK() do { __asm {int 3} } while(0)

    #endif

  #endif

// CB 5-27-10 : use RR_DO_ASSERTS for this :
#if (defined(_DEBUG) && !defined(NDEBUG)) || defined(ASSERT_IN_RELEASE)
  #define RR_DO_ASSERTS
#endif

// BH: This never gets compiled away except for __RADFINAL__
#ifndef __RADFINAL__
#define RR_ASSERT_ALWAYS_NO_SHIP(exp) do { if ( ! (exp) ) { RR_BREAK(); } } while(0)
#else
#define RR_ASSERT_ALWAYS_NO_SHIP(exp) (void)0
#endif

#ifdef RR_DO_ASSERTS
#define RR_ASSERT_LITE(exp)      do { if ( ! (exp) ) { RR_BREAK(); } } while(0)
  #define RR_ASSERT(exp)           RR_ASSERT_LITE(exp)
  #define RR_ASSERT_NO_ASSUME(exp) RR_ASSERT_LITE(exp)
  #define RR_DURING_ASSERT(exp)    exp
#else
  #ifdef _MSC_VER
    #define RR_ASSERT_LITE(cond) (void)0
    #define RR_ASSERT(cond)      (void)0 
    #define RR_ASSERT_NO_ASSUME(cond) (void)0
    #define RR_DURING_ASSERT(exp) (void)0
  #else
    #define RR_ASSERT_LITE(exp) (void)0
    #define RR_ASSERT(exp)      (void)0
    #define RR_ASSERT_NO_ASSUME(cond) (void)0
    #define RR_DURING_ASSERT(exp) (void)0
#endif
#endif

#define RR_ASSERT_ALWAYS(exp)      do { if ( ! (exp) ) { RR_BREAK(); } } while(0)

#define rrAssert  RR_ASSERT
#define rrassert  RR_ASSERT

#ifdef _MSC_VER
  // without this, our assert errors...
  #if _MSC_VER >= 1300
  #pragma warning( disable : 4127) // conditional expression is constant
  #endif
#endif

//---------------------------------------
// Get/Put from memory in little or big endian :
//
// val = RR_GET32_BE(ptr)
// RR_PUT32_BE(ptr,val)
//
//  available here :
//		RR_[GET/PUT][16/32]_[BE/LE][_UNALIGNED][_OFFSET]
//
//	if you don't specify _UNALIGNED , then ptr & offset shoud both be aligned to type size
//	_OFFSET is in *bytes* !

// native version of get/put is always trivial :

#define RR_GET16_NATIVE(ptr)     *((const U16 * RADRESTRICT)ptr)
#define RR_PUT16_NATIVE(ptr,val) *((U16 * RADRESTRICT)ptr) = (val)

// offset is in bytes
#define RR_U16_PTR_OFFSET(ptr,offset)          ((U16 * RADRESTRICT)((char *)(ptr) + offset))
#define RR_GET16_NATIVE_OFFSET(ptr,offset)     *( RR_U16_PTR_OFFSET(ptr,offset) )
#define RR_PUT16_NATIVE_OFFSET(ptr,val,offset) *( RR_U16_PTR_OFFSET(ptr,offset) = (val)

#define RR_GET32_NATIVE(ptr)     *((const U32 * RADRESTRICT)ptr)
#define RR_PUT32_NATIVE(ptr,val) *((U32 * RADRESTRICT)ptr) = (val)

// offset is in bytes
#define RR_U32_PTR_OFFSET(ptr,offset)          ((U32 * RADRESTRICT)((char *)(ptr) + offset))
#define RR_GET32_NATIVE_OFFSET(ptr,offset)     *( RR_U32_PTR_OFFSET(ptr,offset) )
#define RR_PUT32_NATIVE_OFFSET(ptr,val,offset) *( RR_U32_PTR_OFFSET(ptr,offset) = (val)

#ifdef __RADLITTLEENDIAN__

#define RR_GET16_LE     RR_GET16_NATIVE
#define RR_PUT16_LE     RR_PUT16_NATIVE

#define RR_GET16_LE_OFFSET     RR_GET16_NATIVE_OFFSET
#define RR_PUT16_LE_OFFSET     RR_PUT16_NATIVE_OFFSET

#define RR_GET32_LE     RR_GET32_NATIVE
#define RR_PUT32_LE     RR_PUT32_NATIVE

#define RR_GET32_LE_OFFSET     RR_GET32_NATIVE_OFFSET
#define RR_PUT32_LE_OFFSET     RR_PUT32_NATIVE_OFFSET

#else

#define RR_GET16_BE     RR_GET16_NATIVE
#define RR_PUT16_BE     RR_PUT16_NATIVE

#define RR_GET16_BE_OFFSET     RR_GET16_NATIVE_OFFSET
#define RR_PUT16_BE_OFFSET     RR_PUT16_NATIVE_OFFSET

#define RR_GET32_BE     RR_GET32_NATIVE
#define RR_PUT32_BE     RR_PUT32_NATIVE

#define RR_GET32_BE_OFFSET     RR_GET32_NATIVE_OFFSET
#define RR_PUT32_BE_OFFSET     RR_PUT32_NATIVE_OFFSET

#endif

//-------------------------
// non-native Get/Put implementations go here :

#if defined(_MSC_VER) && defined(__RADX86__)
// good implementation for X86 :

#if (_MSC_VER >= 1300)

unsigned short __cdecl _byteswap_ushort (unsigned short _Short);
unsigned long  __cdecl _byteswap_ulong  (unsigned long  _Long);
#pragma intrinsic(_byteswap_ushort, _byteswap_ulong)

#define RR_BSWAP16   _byteswap_ushort
#define RR_BSWAP32  _byteswap_ulong
#define RR_BSWAP64  _byteswap_uint64

#else // VC6

RADFORCEINLINE unsigned long RR_BSWAP16 (unsigned long _Long)
{
   __asm {
      mov eax, [_Long]
      rol ax, 8
      mov [_Long], eax;
   }
   return _Long;
}

RADFORCEINLINE unsigned long RR_BSWAP32 (unsigned long _Long)
{
   __asm {
      mov eax, [_Long]
      bswap eax
      mov [_Long], eax
   }
   return _Long;
}

#endif

#define RR_GET16_BE(ptr)        RR_BSWAP16(*((U16 *)ptr))
#define RR_PUT16_BE(ptr,val)    *((U16 *)ptr) = RR_BSWAP16(val)

#define RR_GET16_BE_OFFSET(ptr,offset)        RR_BSWAP16(*RR_U16_PTR_OFFSET(ptr,offset))
#define RR_PUT16_BE_OFFSET(ptr,val,offset)    *RR_U16_PTR_OFFSET(ptr,offset) = RR_BSWAP16(val)

#define RR_GET32_BE(ptr)        RR_BSWAP32(*((U32 *)ptr))
#define RR_PUT32_BE(ptr,val)    *((U32 *)ptr) = RR_BSWAP32(val)

#define RR_GET32_BE_OFFSET(ptr,offset)        RR_BSWAP32(*RR_U32_PTR_OFFSET(ptr,offset))
#define RR_PUT32_BE_OFFSET(ptr,val,offset)    *RR_U32_PTR_OFFSET(ptr,offset) = RR_BSWAP32(val)

// end _MSC_VER

#elif defined(__RADXENON__) // Xenon has built-in funcs for this

unsigned short __loadshortbytereverse(int offset, const void *base);
unsigned long  __loadwordbytereverse (int offset, const void *base);

void           __storeshortbytereverse(unsigned short val, int offset, void *base);
void           __storewordbytereverse (unsigned int   val, int offset, void *base);

#define RR_GET16_LE(ptr)        __loadshortbytereverse(0, ptr)
#define RR_PUT16_LE(ptr,val)    __storeshortbytereverse((U16) (val), 0, ptr)

#define RR_GET16_LE_OFFSET(ptr,offset)        __loadshortbytereverse(offset, ptr)
#define RR_PUT16_LE_OFFSET(ptr,val,offset)    __storeshortbytereverse((U16) (val), offset, ptr)

#define RR_GET32_LE(ptr)        __loadwordbytereverse(0, ptr)
#define RR_PUT32_LE(ptr,val)    __storewordbytereverse((U32) (val), 0, ptr)

#define RR_GET32_LE_OFFSET(ptr,offset)        __loadwordbytereverse(offset, ptr)
#define RR_PUT32_LE_OFFSET(ptr,val,offset)    __storewordbytereverse((U32) (val), offset, ptr)

#define RR_GET64_LE(ptr)        ( ((U64)RR_GET32_OFFSET_LE(ptr,4)<<32) | RR_GET32_LE(ptr) )
#define RR_PUT64_LE(ptr,val)    RR_PUT32_LE(ptr, (U32) (val)), RR_PUT32_OFFSET_LE(ptr, (U32) (val>>32),4)

#elif defined(__RADPS3__)

#include <ppu_intrinsics.h>

#define RR_GET16_LE(ptr)        __lhbrx(ptr)
#define RR_PUT16_LE(ptr,val)    __sthbrx(ptr, (U16) (val))

#define RR_GET16_LE_OFFSET(ptr,offset)        __lhbrx(RR_U16_PTR_OFFSET(ptr, offset))
#define RR_PUT16_LE_OFFSET(ptr,val,offset)    __sthbrx(RR_U16_PTR_OFFSET(ptr, offset), (U16) (val))

#define RR_GET32_LE(ptr)        __lwbrx(ptr)
#define RR_PUT32_LE(ptr,val)    __stwbrx(ptr, (U32) (val))

#define RR_GET64_LE(ptr)        __ldbrx(ptr)
#define RR_PUT64_LE(ptr,val)    __stdbrx(ptr, (U32) (val))

#define RR_GET32_LE_OFFSET(ptr,offset)        __lwbrx(RR_U32_PTR_OFFSET(ptr, offset))
#define RR_PUT32_LE_OFFSET(ptr,val,offset)    __stwbrx(RR_U32_PTR_OFFSET(ptr, offset), (U32) (val))

#elif defined(__RADWII__)

#define RR_GET16_LE(ptr)        __lhbrx(ptr, 0)
#define RR_PUT16_LE(ptr,val)    __sthbrx((U16) (val), ptr, 0)

#define RR_GET16_LE_OFFSET(ptr,offset)        __lhbrx(ptr, offset)
#define RR_PUT16_LE_OFFSET(ptr,val,offset)    __sthbrx((U16) (val), ptr, offset)

#define RR_GET32_LE(ptr)        __lwbrx(ptr, 0)
#define RR_PUT32_LE(ptr,val)    __stwbrx((U32) (val), ptr, 0)

#define RR_GET32_LE_OFFSET(ptr,offset)        __lwbrx(ptr, offset)
#define RR_PUT32_LE_OFFSET(ptr,val,offset)    __stwbrx((U32) (val), ptr, offset)

#elif defined(__RAD3DS__)

#define RR_GET16_BE(ptr)                    __rev16(*(U16 *) ptr)
#define RR_PUT16_BE(ptr,val)                *(U16 *) ptr = __rev16(val)

#define RR_GET16_BE_OFFSET(ptr,offset)      __rev16(RR_U16_PTR_OFFSET(ptr,offset))
#define RR_PUT16_BE_OFFSET(ptr,offset,val)  *RR_U16_PTR_OFFSET(ptr,offset) = __rev16(val)

#define RR_GET32_BE(ptr)                    __rev(*(U32 *) ptr)
#define RR_PUT32_BE(ptr,val)                *(U32 *) ptr = __rev(val)

#define RR_GET32_BE_OFFSET(ptr,offset)      __rev(RR_U32_PTR_OFFSET(ptr,offset))
#define RR_PUT32_BE_OFFSET(ptr,offset,val)  *RR_U32_PTR_OFFSET(ptr,offset) = __rev(val)

#else // other platforms ?

// fall back :

// Bswap is just here for use of implementing get/put
//  caller should use Get/Put , not bswap
#define RR_BSWAP16(u16) ( ((u16) >> 8) | ((u16) << 8) )
#define RR_BSWAP32(u32) ( ((u32) >> 24) | (((u32)<<8) && 0x00FF0000) | (((u32)>>8) && 0x0000FF00) | ((u32) << 24) )

#ifdef __RADLITTLEENDIAN__

// comment out fallbacks so users will get errors
//#define RR_GET16_BE(ptr)        RR_BSWAP16(*((U16 *)ptr))
//#define RR_PUT16_BE(ptr,val)    *((U16 *)ptr) = RR_BSWAP16(val)
//#define RR_GET32_BE(ptr)        RR_BSWAP32(*((U32 *)ptr))
//#define RR_PUT32_BE(ptr,val)    *((U32 *)ptr) = RR_BSWAP32(val)

#else

// comment out fallbacks so users will get errors
//#define RR_GET16_LE(ptr)        RR_BSWAP16(*((U16 *)ptr))
//#define RR_PUT16_LE(ptr,val)    *((U16 *)ptr) = RR_BSWAP16(val)
//#define RR_GET32_LE(ptr)        RR_BSWAP32(*((U32 *)ptr))
//#define RR_PUT32_LE(ptr,val)    *((U32 *)ptr) = RR_BSWAP32(val)

#endif

#endif

//===================================================================
// @@ TEMP : Aliases for old names : remove me when possible :

#define RR_GET32_OFFSET_LE	RR_GET32_LE_OFFSET
#define RR_GET32_OFFSET_BE	RR_GET32_BE_OFFSET
#define RR_PUT32_OFFSET_LE	RR_PUT32_LE_OFFSET
#define RR_PUT32_OFFSET_BE	RR_PUT32_BE_OFFSET
#define RR_GET16_OFFSET_LE	RR_GET16_LE_OFFSET
#define RR_GET16_OFFSET_BE	RR_GET16_BE_OFFSET
#define RR_PUT16_OFFSET_LE	RR_PUT16_LE_OFFSET
#define RR_PUT16_OFFSET_BE	RR_PUT16_BE_OFFSET


//===================================================================
// UNALIGNED VERSIONS :

#if defined(__RADX86__) || defined(__RADPPC__) // platforms where unaligned is fast :

#define RR_GET32_BE_UNALIGNED(ptr)                 RR_GET32_BE(ptr)
#define RR_GET32_BE_UNALIGNED_OFFSET(ptr,offset)   RR_GET32_BE_OFFSET(ptr,offset)
#define RR_GET16_BE_UNALIGNED(ptr)                 RR_GET16_BE(ptr)
#define RR_GET16_BE_UNALIGNED_OFFSET(ptr,offset)   RR_GET16_BE_OFFSET(ptr,offset)

#define RR_GET32_LE_UNALIGNED(ptr)                 RR_GET32_LE(ptr)
#define RR_GET32_LE_UNALIGNED_OFFSET(ptr,offset)   RR_GET32_LE_OFFSET(ptr,offset)
#define RR_GET16_LE_UNALIGNED(ptr)                 RR_GET16_LE(ptr)
#define RR_GET16_LE_UNALIGNED_OFFSET(ptr,offset)   RR_GET16_LE_OFFSET(ptr,offset)

#elif defined(__RAD3DS__)

// arm has a "__packed" qualifier to tell the compiler to do unaligned accesses
#define RR_U16_PTR_OFFSET_UNALIGNED(ptr,offset)          ((__packed U16 * RADRESTRICT)((char *)(ptr) + offset))
#define RR_U32_PTR_OFFSET_UNALIGNED(ptr,offset)          ((__packed U32 * RADRESTRICT)((char *)(ptr) + offset))

#define RR_GET32_BE_UNALIGNED(ptr)                 __rev(*RR_U32_PTR_OFFSET_UNALIGNED(ptr,0))
#define RR_GET32_BE_UNALIGNED_OFFSET(ptr,offset)   __rev(*RR_U32_PTR_OFFSET_UNALIGNED(ptr,offset))
#define RR_GET16_BE_UNALIGNED(ptr)                 __rev16(*RR_U16_PTR_OFFSET_UNALIGNED(ptr,0))
#define RR_GET16_BE_UNALIGNED_OFFSET(ptr,offset)   __rev16(*RR_U16_PTR_OFFSET_UNALIGNED(ptr,offset))

#define RR_GET32_LE_UNALIGNED(ptr)                 *RR_U32_PTR_OFFSET_UNALIGNED(ptr,0)
#define RR_GET32_LE_UNALIGNED_OFFSET(ptr,offset)   *RR_U32_PTR_OFFSET_UNALIGNED(ptr,offset)
#define RR_GET16_LE_UNALIGNED(ptr)                 *RR_U16_PTR_OFFSET_UNALIGNED(ptr,0)
#define RR_GET16_LE_UNALIGNED_OFFSET(ptr,offset)   *RR_U16_PTR_OFFSET_UNALIGNED(ptr,offset)


#else
// Unaligned via bytes :

#define RR_GET32_BE_UNALIGNED(ptr) ( \
	( (U32)(((const U8 * RADRESTRICT)ptr))[0] << 24 ) | \
	( (U32)(((const U8 * RADRESTRICT)ptr))[1] << 16 ) | \
	( (U32)(((const U8 * RADRESTRICT)ptr))[2] << 8  ) | \
	( (U32)(((const U8 * RADRESTRICT)ptr))[3] << 0  ) )

#define RR_GET32_BE_UNALIGNED_OFFSET(ptr,offset) ( \
	( (U32)(((const U8 * RADRESTRICT)ptr)+offset)[0] << 24 ) | \
	( (U32)(((const U8 * RADRESTRICT)ptr)+offset)[1] << 16 ) | \
	( (U32)(((const U8 * RADRESTRICT)ptr)+offset)[2] << 8  ) | \
	( (U32)(((const U8 * RADRESTRICT)ptr)+offset)[3] << 0  ) )

#define RR_GET16_BE_UNALIGNED(ptr) ( \
	( (U16)(((const U8 * RADRESTRICT)ptr))[0] << 8  ) | \
	( (U16)(((const U8 * RADRESTRICT)ptr))[1] << 0  ) )

#define RR_GET16_BE_UNALIGNED_OFFSET(ptr,offset) ( \
	( (U16)(((const U8 * RADRESTRICT)ptr)+offset)[0] << 8  ) | \
	( (U16)(((const U8 * RADRESTRICT)ptr)+offset)[1] << 0  ) )

#define RR_GET32_LE_UNALIGNED(ptr) ( \
	( (U32)(((const U8 * RADRESTRICT)ptr))[3] << 24 ) | \
	( (U32)(((const U8 * RADRESTRICT)ptr))[2] << 16 ) | \
	( (U32)(((const U8 * RADRESTRICT)ptr))[1] << 8  ) | \
	( (U32)(((const U8 * RADRESTRICT)ptr))[0] << 0  ) )

#define RR_GET32_LE_UNALIGNED_OFFSET(ptr,offset) ( \
	( (U32)(((const U8 * RADRESTRICT)ptr)+offset)[3] << 24 ) | \
	( (U32)(((const U8 * RADRESTRICT)ptr)+offset)[2] << 16 ) | \
	( (U32)(((const U8 * RADRESTRICT)ptr)+offset)[1] << 8  ) | \
	( (U32)(((const U8 * RADRESTRICT)ptr)+offset)[0] << 0  ) )

#define RR_GET16_LE_UNALIGNED(ptr) ( \
	( (U16)(((const U8 * RADRESTRICT)ptr))[1] << 8  ) | \
	( (U16)(((const U8 * RADRESTRICT)ptr))[0] << 0  ) )

#define RR_GET16_LE_UNALIGNED_OFFSET(ptr,offset) ( \
	( (U16)(((const U8 * RADRESTRICT)ptr)+offset)[1] << 8  ) | \
	( (U16)(((const U8 * RADRESTRICT)ptr)+offset)[0] << 0  ) )

#endif

//===================================================================
// RR_ROTL32 : 32-bit rotate
//

#ifdef _MSC_VER

unsigned long __cdecl _lrotl(unsigned long, int);
#pragma intrinsic(_lrotl)

#define RR_ROTL32(x,k)  _lrotl(x,k)

#elif defined(__RADCELL__) || defined(__RADWII__)

// PS3 GCC turns this into rotate correctly :
#define RR_ROTL32(u32,num)  ( ( (u32) << num ) | ( (u32) >> (32 - num)) )

#elif defined(__RAD3DS__)

#define RR_ROTL32(u32,num)  __ror(u32, (-num)&31)

#else

// comment out fallbacks so users will get errors
// fallback implementation using shift and or :
//#define RR_ROTL32(u32,num)  ( ( (u32) << num ) | ( (u32) >> (32 - num)) )

#endif


//===================================================================
// RR_ROTL64 : 64-bit rotate

#if ( defined(_MSC_VER) && _MSC_VER >= 1300)

unsigned __int64 __cdecl _rotl64(unsigned __int64 _Val, int _Shift);
#pragma intrinsic(_rotl64)

#define RR_ROTL64(x,k)  _rotl64(x,k)

#elif defined(__RADCELL__)

// PS3 GCC turns this into rotate correctly :
#define RR_ROTL64(u64,num)  ( ( (u64) << num ) | ( (u64) >> (64 - num)) )

#else

// comment out fallbacks so users will get errors
// fallback implementation using shift and or :
//#define RR_ROTL64(u64,num)  ( ( (u64) << num ) | ( (u64) >> (64 - num)) )

#endif

//===================================================================

RADDEFEND

//===================================================================

// RR_COMPILER_ASSERT
#ifdef __cplusplus
  #if defined(_MSC_VER) && (_MSC_VER >=1400)

  // better version of COMPILER_ASSERT using boost technique
  template <int x> struct RR_COMPILER_ASSERT_FAILURE;

  template <> struct RR_COMPILER_ASSERT_FAILURE<1> { enum { value = 1 }; };

  template<int x> struct rr_compiler_assert_test{};

  // __LINE__ macro broken when -ZI is used see Q199057
  #define RR_COMPILER_ASSERT( B ) \
     typedef rr_compiler_assert_test<\
        sizeof(RR_COMPILER_ASSERT_FAILURE< (B) ? 1 : 0 >)\
        > rr_compiler_assert_typedef_

  #endif
#endif

#ifndef RR_COMPILER_ASSERT
  // CB 5-27-10 : braces at file scope not liked
  // fallback old negative array size compiler assert :

  // this happens at declaration time, so if it's inside a function in a C file, drop {} around it
  #define RR_COMPILER_ASSERT(exp)   typedef char RR_STRING_JOIN(_dummy_array, __LINE__) [ (exp) ? 1 : -1 ]
#endif

//===================================================================
// some error checks :

    RR_COMPILER_ASSERT( sizeof(RAD_UINTa) == sizeof( RR_STRING_JOIN(RAD_U,RAD_PTRBITS) ) );
    RR_COMPILER_ASSERT( sizeof(RAD_UINTa) == RAD_PTRBYTES );
    RR_COMPILER_ASSERT( RAD_TWOPTRBYTES == 2* RAD_PTRBYTES );

//===================================================================

#endif

#endif
