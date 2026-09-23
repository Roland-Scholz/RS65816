;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;/*----------------------------------------------------------------------------/
;/  FatFs - Generic FAT Filesystem Module  R0.16                               /
;/-----------------------------------------------------------------------------/
;/
;/ Copyright (C) 2025, ChaN, all right reserved.
;/
;/ FatFs module is an open source software. Redistribution and use of FatFs in
;/ source and binary forms, with or without modification, are permitted provided
;/ that the following condition is met:
;/
;/ 1. Redistributions of source code must retain the above copyright notice,
;/    this condition and the following disclaimer.
;/
;/ This software is provided by the copyright holder and contributors "AS IS"
;/ and any warranties related to this software are DISCLAIMED.
;/ The copyright owner or contributors be NOT LIABLE for any damages caused
;/ by use of this software.
;/
;/----------------------------------------------------------------------------*/
;
;
;#include <string.h>
;#include "ff.h"			/* Basic definitions and declarations of API */
;#include "diskio.h"		/* Declarations of MAI */
;
;/*--------------------------------------------------------------------------
;
;   Module Private Definitions
;
;---------------------------------------------------------------------------*/
;
;#if FF_DEFINED != 80386	/* Revision ID */
;#error Wrong include file (ff.h).
;#endif
;
;
;/* Limits and boundaries */
;#define MAX_DIR		0x200000		/* Max size of FAT directory (byte) */
;#define MAX_DIR_EX	0x10000000		/* Max size of exFAT directory (byte) */
;#define MAX_FAT12	0xFF5			/* Max FAT12 clusters (differs from specs, but right for real DOS/Windows behavior) */
;#define MAX_FAT16	0xFFF5			/* Max FAT16 clusters (differs from specs, but right for real DOS/Windows behavior) */
;#define MAX_FAT32	0x0FFFFFF5		/* Max FAT32 clusters (not defined in specs, practical limit) */
;#define MAX_EXFAT	0x7FFFFFFD		/* Max exFAT clusters (differs from specs, implementation limit) */
;
;
;/* Character code support macros */
;#define IsUpper(c)		((c) >= 'A' && (c) <= 'Z')
;#define IsLower(c)		((c) >= 'a' && (c) <= 'z')
;#define IsDigit(c)		((c) >= '0' && (c) <= '9')
;#define IsSeparator(c)	((c) == '/' || (c) == '\\')
;#define IsTerminator(c)	((UINT)(c) < (FF_USE_LFN ? ' ' : '!'))
;#define IsSurrogate(c)	((c) >= 0xD800 && (c) <= 0xDFFF)
;#define IsSurrogateH(c)	((c) >= 0xD800 && (c) <= 0xDBFF)
;#define IsSurrogateL(c)	((c) >= 0xDC00 && (c) <= 0xDFFF)
;
;
;/* Additional file access control and file status flags for internal use */
;#define FA_SEEKEND	0x20	/* Seek to end of the file on file open */
;#define FA_MODIFIED	0x40	/* File has been modified */
;#define FA_DIRTY	0x80	/* FIL.buf[] needs to be written-back */
;
;
;/* Additional file attribute bits for internal use */
;#define AM_VOL		0x08	/* Volume label */
;#define AM_LFN		0x0F	/* LFN entry */
;#define AM_MASK		0x3F	/* Mask of defined bits in FAT */
;#define AM_MASKX	0x37	/* Mask of defined bits in exFAT */
;
;
;/* Name status flags in fn[11] */
;#define NSFLAG		11		/* Index of the name status byte */
;#define NS_LOSS		0x01	/* Out of 8.3 format */
;#define NS_LFN		0x02	/* Force to create LFN entry */
;#define NS_LAST		0x04	/* Last segment */
;#define NS_BODY		0x08	/* Lower case flag (body) */
;#define NS_EXT		0x10	/* Lower case flag (ext) */
;#define NS_DOT		0x20	/* Dot entry */
;#define NS_NOLFN	0x40	/* Do not find LFN */
;#define NS_NONAME	0x80	/* Not followed */
;
;
;/* exFAT directory entry types */
;#define	ET_BITMAP	0x81	/* Allocation bitmap */
;#define	ET_UPCASE	0x82	/* Up-case table */
;#define	ET_VLABEL	0x83	/* Volume label */
;#define	ET_FILEDIR	0x85	/* File and directory */
;#define	ET_STREAM	0xC0	/* Stream extension */
;#define	ET_FILENAME	0xC1	/* Name extension */
;
;
;/* FatFs refers the FAT structures as simple byte array instead of structure member
;/ because the C structure is not binary compatible between different platforms */
;
;#define BS_JmpBoot			0		/* x86 jump instruction (3-byte) */
;#define BS_OEMName			3		/* OEM name (8-byte) */
;#define BPB_BytsPerSec		11		/* Sector size [byte] (WORD) */
;#define BPB_SecPerClus		13		/* Cluster size [sector] (BYTE) */
;#define BPB_RsvdSecCnt		14		/* Size of reserved area [sector] (WORD) */
;#define BPB_NumFATs			16		/* Number of FATs (BYTE) */
;#define BPB_RootEntCnt		17		/* Size of root directory area for FAT [entry] (WORD) */
;#define BPB_TotSec16		19		/* Volume size (16-bit) [sector] (WORD) */
;#define BPB_Media			21		/* Media descriptor byte (BYTE) */
;#define BPB_FATSz16			22		/* FAT size (16-bit) [sector] (WORD) */
;#define BPB_SecPerTrk		24		/* Number of sectors per track for int13h [sector] (WORD) */
;#define BPB_NumHeads		26		/* Number of heads for int13h (WORD) */
;#define BPB_HiddSec			28		/* Volume offset from top of the drive (DWORD) */
;#define BPB_TotSec32		32		/* Volume size (32-bit) [sector] (DWORD) */
;#define BS_DrvNum			36		/* Physical drive number for int13h (BYTE) */
;#define BS_NTres			37		/* WindowsNT error flag (BYTE) */
;#define BS_BootSig			38		/* Extended boot signature (BYTE) */
;#define BS_VolID			39		/* Volume serial number (DWORD) */
;#define BS_VolLab			43		/* Volume label string (8-byte) */
;#define BS_FilSysType		54		/* Filesystem type string (8-byte) */
;#define BS_BootCode			62		/* Boot code (448-byte) */
;#define BS_55AA				510		/* Boot signature (WORD, for VBR and MBR) */
;
;#define BPB_FATSz32			36		/* FAT32: FAT size [sector] (DWORD) */
;#define BPB_ExtFlags32		40		/* FAT32: Extended flags (WORD) */
;#define BPB_FSVer32			42		/* FAT32: Filesystem version (WORD) */
;#define BPB_RootClus32		44		/* FAT32: Root directory cluster (DWORD) */
;#define BPB_FSInfo32		48		/* FAT32: Offset of FSINFO sector (WORD) */
;#define BPB_BkBootSec32		50		/* FAT32: Offset of backup boot sector (WORD) */
;#define BS_DrvNum32			64		/* FAT32: Physical drive number for int13h (BYTE) */
;#define BS_NTres32			65		/* FAT32: Error flag (BYTE) */
;#define BS_BootSig32		66		/* FAT32: Extended boot signature (BYTE) */
;#define BS_VolID32			67		/* FAT32: Volume serial number (DWORD) */
;#define BS_VolLab32			71		/* FAT32: Volume label string (8-byte) */
;#define BS_FilSysType32		82		/* FAT32: Filesystem type string (8-byte) */
;#define BS_BootCode32		90		/* FAT32: Boot code (420-byte) */
;
;#define BPB_ZeroedEx		11		/* exFAT: MBZ field (53-byte) */
;#define BPB_VolOfsEx		64		/* exFAT: Volume offset from top of the drive [sector] (QWORD) */
;#define BPB_TotSecEx		72		/* exFAT: Volume size [sector] (QWORD) */
;#define BPB_FatOfsEx		80		/* exFAT: FAT offset from top of the volume [sector] (DWORD) */
;#define BPB_FatSzEx			84		/* exFAT: FAT size [sector] (DWORD) */
;#define BPB_DataOfsEx		88		/* exFAT: Data offset from top of the volume [sector] (DWORD) */
;#define BPB_NumClusEx		92		/* exFAT: Number of clusters (DWORD) */
;#define BPB_RootClusEx		96		/* exFAT: Root directory start cluster (DWORD) */
;#define BPB_VolIDEx			100		/* exFAT: Volume serial number (DWORD) */
;#define BPB_FSVerEx			104		/* exFAT: Filesystem version (WORD) */
;#define BPB_VolFlagEx		106		/* exFAT: Volume flags (WORD, out of check sum calculation) */
;#define BPB_BytsPerSecEx	108		/* exFAT: Log2 of sector size in unit of byte (BYTE) */
;#define BPB_SecPerClusEx	109		/* exFAT: Log2 of cluster size in unit of sector (BYTE) */
;#define BPB_NumFATsEx		110		/* exFAT: Number of FATs (BYTE) */
;#define BPB_DrvNumEx		111		/* exFAT: Physical drive number for int13h (BYTE) */
;#define BPB_PercInUseEx		112		/* exFAT: Percent in use (BYTE, out of check sum calculation) */
;#define BPB_RsvdEx			113		/* exFAT: Reserved (7-byte) */
;#define BS_BootCodeEx		120		/* exFAT: Boot code (390-byte) */
;
;#define DIR_Name			0		/* Short file name (11-byte) */
;#define DIR_Attr			11		/* Attribute (BYTE) */
;#define DIR_NTres			12		/* Low case flags of SFN (BYTE) */
;#define DIR_CrtTime10		13		/* Created time sub-second (BYTE) */
;#define DIR_CrtTime			14		/* Created time (DWORD) */
;#define DIR_LstAccDate		18		/* Last accessed date (WORD) */
;#define DIR_FstClusHI		20		/* Higher 16-bit of first cluster (WORD) */
;#define DIR_ModTime			22		/* Modified time (DWORD) */
;#define DIR_FstClusLO		26		/* Lower 16-bit of first cluster (WORD) */
;#define DIR_FileSize		28		/* File size (DWORD) */
;#define LDIR_Ord			0		/* LFN: LFN order and LLE flag (BYTE) */
;#define LDIR_Attr			11		/* LFN: LFN attribute (BYTE) */
;#define LDIR_Type			12		/* LFN: Entry type (BYTE) */
;#define LDIR_Chksum			13		/* LFN: Checksum of the SFN (BYTE) */
;#define LDIR_FstClusLO		26		/* LFN: MBZ field (WORD) */
;#define XDIR_Type			0		/* exFAT: Type of exFAT directory entry (BYTE) */
;#define XDIR_NumLabel		1		/* exFAT: Number of volume label characters (BYTE) */
;#define XDIR_Label			2		/* exFAT: Volume label (11-WORD) */
;#define XDIR_CaseSum		4		/* exFAT: Sum of case conversion table (DWORD) */
;#define XDIR_NumSec			1		/* exFAT: Number of secondary entries (BYTE) */
;#define XDIR_SetSum			2		/* exFAT: Sum of the set of directory entries (WORD) */
;#define XDIR_Attr			4		/* exFAT: File attribute (WORD) */
;#define XDIR_CrtTime		8		/* exFAT: Created time (DWORD) */
;#define XDIR_ModTime		12		/* exFAT: Modified time (DWORD) */
;#define XDIR_AccTime		16		/* exFAT: Last accessed time (DWORD) */
;#define XDIR_CrtTime10		20		/* exFAT: Created time subsecond (BYTE) */
;#define XDIR_ModTime10		21		/* exFAT: Modified time subsecond (BYTE) */
;#define XDIR_CrtTZ			22		/* exFAT: Created timezone (BYTE) */
;#define XDIR_ModTZ			23		/* exFAT: Modified timezone (BYTE) */
;#define XDIR_AccTZ			24		/* exFAT: Last accessed timezone (BYTE) */
;#define XDIR_GenFlags		33		/* exFAT: General secondary flags (BYTE) */
;#define XDIR_NumName		35		/* exFAT: Number of file name characters (BYTE) */
;#define XDIR_NameHash		36		/* exFAT: Hash of file name (WORD) */
;#define XDIR_ValidFileSize	40		/* exFAT: Valid file size (QWORD) */
;#define XDIR_FstClus		52		/* exFAT: First cluster of the file data (DWORD) */
;#define XDIR_FileSize		56		/* exFAT: File/Directory size (QWORD) */
;
;#define SZDIRE				32		/* Size of a directory entry */
;#define DDEM				0xE5	/* Deleted directory entry mark set to DIR_Name[0] */
;#define RDDEM				0x05	/* Replacement of the character collides with DDEM */
;#define LLEF				0x40	/* Last long entry flag in LDIR_Ord */
;
;#define FSI_LeadSig			0		/* FAT32 FSI: Leading signature (DWORD) */
;#define FSI_StrucSig		484		/* FAT32 FSI: Structure signature (DWORD) */
;#define FSI_Free_Count		488		/* FAT32 FSI: Number of free clusters (DWORD) */
;#define FSI_Nxt_Free		492		/* FAT32 FSI: Last allocated cluster (DWORD) */
;#define FSI_TrailSig		508		/* FAT32 FSI: Trailing signature (DWORD) */
;
;#define MBR_Table			446		/* MBR: Offset of partition table in the MBR */
;#define SZ_PTE				16		/* MBR: Size of a partition table entry */
;#define PTE_Boot			0		/* MBR PTE: Boot indicator */
;#define PTE_StHead			1		/* MBR PTE: Start head in CHS */
;#define PTE_StSec			2		/* MBR PTE: Start sector in CHS */
;#define PTE_StCyl			3		/* MBR PTE: Start cylinder in CHS */
;#define PTE_System			4		/* MBR PTE: System ID */
;#define PTE_EdHead			5		/* MBR PTE: End head in CHS */
;#define PTE_EdSec			6		/* MBR PTE: End sector in CHS */
;#define PTE_EdCyl			7		/* MBR PTE: End cylinder in CHS */
;#define PTE_StLba			8		/* MBR PTE: Start in LBA */
;#define PTE_SizLba			12		/* MBR PTE: Size in LBA */
;
;#define GPTH_Sign			0		/* GPT HDR: Signature (8-byte) */
;#define GPTH_Rev			8		/* GPT HDR: Revision (DWORD) */
;#define GPTH_Size			12		/* GPT HDR: Header size (DWORD) */
;#define GPTH_Bcc			16		/* GPT HDR: Header BCC (DWORD) */
;#define GPTH_CurLba			24		/* GPT HDR: This header LBA (QWORD) */
;#define GPTH_BakLba			32		/* GPT HDR: Another header LBA (QWORD) */
;#define GPTH_FstLba			40		/* GPT HDR: First LBA for partition data (QWORD) */
;#define GPTH_LstLba			48		/* GPT HDR: Last LBA for partition data (QWORD) */
;#define GPTH_DskGuid		56		/* GPT HDR: Disk GUID (16-byte) */
;#define GPTH_PtOfs			72		/* GPT HDR: Partition table LBA (QWORD) */
;#define GPTH_PtNum			80		/* GPT HDR: Number of table entries (DWORD) */
;#define GPTH_PteSize		84		/* GPT HDR: Size of table entry (DWORD) */
;#define GPTH_PtBcc			88		/* GPT HDR: Partition table BCC (DWORD) */
;#define SZ_GPTE				128		/* GPT PTE: Size of a GPT partition table entry */
;#define GPTE_PtGuid			0		/* GPT PTE: Partition type GUID (16-byte) */
;#define GPTE_UpGuid			16		/* GPT PTE: Partition unique GUID (16-byte) */
;#define GPTE_FstLba			32		/* GPT PTE: First LBA of partition (QWORD) */
;#define GPTE_LstLba			40		/* GPT PTE: Last LBA of partition (QWORD) */
;#define GPTE_Flags			48		/* GPT PTE: Partition flags (QWORD) */
;#define GPTE_Name			56		/* GPT PTE: Partition name */
;
;
;/* Post process on fatal error in the file operations */
;#define ABORT(fs, res)		{ fp->err = (BYTE)(res); LEAVE_FF(fs, res); }
;
;
;/* Re-entrancy related */
;#if FF_FS_REENTRANT
;#if FF_USE_LFN == 1
;#error Static LFN work area cannot be used in thread-safe configuration
;#endif
;#define LEAVE_FF(fs, res)	{ unlock_volume(fs, res); return res; }
;#else
;#define LEAVE_FF(fs, res)	return res
;#endif
;
;
;/* Definitions of logical drive to physical location conversion */
;#if FF_MULTI_PARTITION
;#define LD2PD(vol) VolToPart[vol].pd	/* Get physical drive number from the mapping table */
;#define LD2PT(vol) VolToPart[vol].pt	/* Get partition number from the mapping table (0:auto search, 1-:forced partition number) */
;#else
;#define LD2PD(vol) (BYTE)(vol)	/* Each logical drive is associated with the same physical drive number */
;#define LD2PT(vol) 0			/* Auto partition search */
;#endif
;
;
;/* Definitions of sector size */
;#if (FF_MAX_SS < FF_MIN_SS) || (FF_MAX_SS != 512 && FF_MAX_SS != 1024 && FF_MAX_SS != 2048 && FF_MAX_SS != 4096) || (FF_MIN_SS != 512 && FF_MIN_SS != 1024 && FF_MIN_SS != 2048 && FF_MIN_SS != 4096)
;#error Wrong sector size configuration
;#endif
;#if FF_MAX_SS == FF_MIN_SS
;#define SS(fs)	((UINT)FF_MAX_SS)	/* Fixed sector size */
;#else
;#define SS(fs)	((fs)->ssize)	/* Variable sector size */
;#endif
;
;
;/* Timestamp */
;#if FF_FS_NORTC == 1
;#if FF_NORTC_YEAR < 1980 || FF_NORTC_YEAR > 2107 || FF_NORTC_MON < 1 || FF_NORTC_MON > 12 || FF_NORTC_MDAY < 1 || FF_NORTC_MDAY > 31
;#error Invalid FF_FS_NORTC settings
;#endif
;#define GET_FATTIME()	((DWORD)(FF_NORTC_YEAR - 1980) << 25 | (DWORD)FF_NORTC_MON << 21 | (DWORD)FF_NORTC_MDAY << 16)
;#else
;#define GET_FATTIME()	get_fattime()
;#endif
;
;
;/* File lock controls */
;#if FF_FS_LOCK
;#if FF_FS_READONLY
;#error FF_FS_LOCK must be 0 at read-only configuration
;#endif
;typedef struct {	/* Open object identifier with status */
;	FATFS* fs;		/*  Object ID 1, volume (NULL:blank entry) */
;	DWORD clu;		/*  Object ID 2, containing directory (0:root) */
;	DWORD ofs;		/*  Object ID 3, offset in the directory */
;	UINT ctr;		/*  Object open status, 0:none, 0x01..0xFF:read mode open count, 0x100:write mode */
;} FILESEM;
;#endif
;
;
;/* SBCS up-case tables (\x80-\xFF) */
;#define TBL_CT437  {0x80,0x9A,0x45,0x41,0x8E,0x41,0x8F,0x80,0x45,0x45,0x45,0x49,0x49,0x49,0x8E,0x8F, \
;					0x90,0x92,0x92,0x4F,0x99,0x4F,0x55,0x55,0x59,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \
;					0x41,0x49,0x4F,0x55,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \
;					0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF, \
;					0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
;#define TBL_CT720  {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F, \
;					0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \
;					0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \
;					0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF, \
;					0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
;#define TBL_CT737  {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F, \
;					0x90,0x92,0x92,0x93,0x94,0x95,0x96,0x97,0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87, \
;					0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0xAA,0x92,0x93,0x94,0x95,0x96, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \
;					0x97,0xEA,0xEB,0xEC,0xE4,0xED,0xEE,0xEF,0xF5,0xF0,0xEA,0xEB,0xEC,0xED,0xEE,0xEF, \
;					0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
;#define TBL_CT771  {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F, \
;					0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \
;					0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDC,0xDE,0xDE, \
;					0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \
;					0xF0,0xF0,0xF2,0xF2,0xF4,0xF4,0xF6,0xF6,0xF8,0xF8,0xFA,0xFA,0xFC,0xFC,0xFE,0xFF}
;#define TBL_CT775  {0x80,0x9A,0x91,0xA0,0x8E,0x95,0x8F,0x80,0xAD,0xED,0x8A,0x8A,0xA1,0x8D,0x8E,0x8F, \
;					0x90,0x92,0x92,0xE2,0x99,0x95,0x96,0x97,0x97,0x99,0x9A,0x9D,0x9C,0x9D,0x9E,0x9F, \
;					0xA0,0xA1,0xE0,0xA3,0xA3,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xB5,0xB6,0xB7,0xB8,0xBD,0xBE,0xC6,0xC7,0xA5,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \
;					0xE0,0xE1,0xE2,0xE3,0xE5,0xE5,0xE6,0xE3,0xE8,0xE8,0xEA,0xEA,0xEE,0xED,0xEE,0xEF, \
;					0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
;#define TBL_CT850  {0x43,0x55,0x45,0x41,0x41,0x41,0x41,0x43,0x45,0x45,0x45,0x49,0x49,0x49,0x41,0x41, \
;					0x45,0x92,0x92,0x4F,0x4F,0x4F,0x55,0x55,0x59,0x4F,0x55,0x4F,0x9C,0x4F,0x9E,0x9F, \
;					0x41,0x49,0x4F,0x55,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0x41,0x41,0x41,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0x41,0x41,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD1,0xD1,0x45,0x45,0x45,0x49,0x49,0x49,0x49,0xD9,0xDA,0xDB,0xDC,0xDD,0x49,0xDF, \
;					0x4F,0xE1,0x4F,0x4F,0x4F,0x4F,0xE6,0xE8,0xE8,0x55,0x55,0x55,0x59,0x59,0xEE,0xEF, \
;					0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
;#define TBL_CT852  {0x80,0x9A,0x90,0xB6,0x8E,0xDE,0x8F,0x80,0x9D,0xD3,0x8A,0x8A,0xD7,0x8D,0x8E,0x8F, \
;					0x90,0x91,0x91,0xE2,0x99,0x95,0x95,0x97,0x97,0x99,0x9A,0x9B,0x9B,0x9D,0x9E,0xAC, \
;					0xB5,0xD6,0xE0,0xE9,0xA4,0xA4,0xA6,0xA6,0xA8,0xA8,0xAA,0x8D,0xAC,0xB8,0xAE,0xAF, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBD,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC6,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD1,0xD1,0xD2,0xD3,0xD2,0xD5,0xD6,0xD7,0xB7,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \
;					0xE0,0xE1,0xE2,0xE3,0xE3,0xD5,0xE6,0xE6,0xE8,0xE9,0xE8,0xEB,0xED,0xED,0xDD,0xEF, \
;					0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xEB,0xFC,0xFC,0xFE,0xFF}
;#define TBL_CT855  {0x81,0x81,0x83,0x83,0x85,0x85,0x87,0x87,0x89,0x89,0x8B,0x8B,0x8D,0x8D,0x8F,0x8F, \
;					0x91,0x91,0x93,0x93,0x95,0x95,0x97,0x97,0x99,0x99,0x9B,0x9B,0x9D,0x9D,0x9F,0x9F, \
;					0xA1,0xA1,0xA3,0xA3,0xA5,0xA5,0xA7,0xA7,0xA9,0xA9,0xAB,0xAB,0xAD,0xAD,0xAE,0xAF, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB6,0xB6,0xB8,0xB8,0xB9,0xBA,0xBB,0xBC,0xBE,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC7,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD1,0xD1,0xD3,0xD3,0xD5,0xD5,0xD7,0xD7,0xDD,0xD9,0xDA,0xDB,0xDC,0xDD,0xE0,0xDF, \
;					0xE0,0xE2,0xE2,0xE4,0xE4,0xE6,0xE6,0xE8,0xE8,0xEA,0xEA,0xEC,0xEC,0xEE,0xEE,0xEF, \
;					0xF0,0xF2,0xF2,0xF4,0xF4,0xF6,0xF6,0xF8,0xF8,0xFA,0xFA,0xFC,0xFC,0xFD,0xFE,0xFF}
;#define TBL_CT857  {0x80,0x9A,0x90,0xB6,0x8E,0xB7,0x8F,0x80,0xD2,0xD3,0xD4,0xD8,0xD7,0x49,0x8E,0x8F, \
;					0x90,0x92,0x92,0xE2,0x99,0xE3,0xEA,0xEB,0x98,0x99,0x9A,0x9D,0x9C,0x9D,0x9E,0x9E, \
;					0xB5,0xD6,0xE0,0xE9,0xA5,0xA5,0xA6,0xA6,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC7,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD0,0xD1,0xD2,0xD3,0xD4,0x49,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \
;					0xE0,0xE1,0xE2,0xE3,0xE5,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xDE,0xED,0xEE,0xEF, \
;					0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
;#define TBL_CT860  {0x80,0x9A,0x90,0x8F,0x8E,0x91,0x86,0x80,0x89,0x89,0x92,0x8B,0x8C,0x98,0x8E,0x8F, \
;					0x90,0x91,0x92,0x8C,0x99,0xA9,0x96,0x9D,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \
;					0x86,0x8B,0x9F,0x96,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \
;					0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF, \
;					0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
;#define TBL_CT861  {0x80,0x9A,0x90,0x41,0x8E,0x41,0x8F,0x80,0x45,0x45,0x45,0x8B,0x8B,0x8D,0x8E,0x8F, \
;					0x90,0x92,0x92,0x4F,0x99,0x8D,0x55,0x97,0x97,0x99,0x9A,0x9D,0x9C,0x9D,0x9E,0x9F, \
;					0xA4,0xA5,0xA6,0xA7,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \
;					0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF, \
;					0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
;#define TBL_CT862  {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F, \
;					0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \
;					0x41,0x49,0x4F,0x55,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \
;					0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF, \
;					0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
;#define TBL_CT863  {0x43,0x55,0x45,0x41,0x41,0x41,0x86,0x43,0x45,0x45,0x45,0x49,0x49,0x8D,0x41,0x8F, \
;					0x45,0x45,0x45,0x4F,0x45,0x49,0x55,0x55,0x98,0x4F,0x55,0x9B,0x9C,0x55,0x55,0x9F, \
;					0xA0,0xA1,0x4F,0x55,0xA4,0xA5,0xA6,0xA7,0x49,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \
;					0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF, \
;					0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
;#define TBL_CT864  {0x80,0x9A,0x45,0x41,0x8E,0x41,0x8F,0x80,0x45,0x45,0x45,0x49,0x49,0x49,0x8E,0x8F, \
;					0x90,0x92,0x92,0x4F,0x99,0x4F,0x55,0x55,0x59,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \
;					0x41,0x49,0x4F,0x55,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \
;					0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF, \
;					0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
;#define TBL_CT865  {0x80,0x9A,0x90,0x41,0x8E,0x41,0x8F,0x80,0x45,0x45,0x45,0x49,0x49,0x49,0x8E,0x8F, \
;					0x90,0x92,0x92,0x4F,0x99,0x4F,0x55,0x55,0x59,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \
;					0x41,0x49,0x4F,0x55,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \
;					0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF, \
;					0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
;#define TBL_CT866  {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F, \
;					0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \
;					0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \
;					0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \
;					0xF0,0xF0,0xF2,0xF2,0xF4,0xF4,0xF6,0xF6,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
;#define TBL_CT869  {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F, \
;					0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x86,0x9C,0x8D,0x8F,0x90, \
;					0x91,0x90,0x92,0x95,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF, \
;					0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \
;					0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF, \
;					0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xA4,0xA5,0xA6,0xD9,0xDA,0xDB,0xDC,0xA7,0xA8,0xDF, \
;					0xA9,0xAA,0xAC,0xAD,0xB5,0xB6,0xB7,0xB8,0xBD,0xBE,0xC6,0xC7,0xCF,0xCF,0xD0,0xEF, \
;					0xF0,0xF1,0xD1,0xD2,0xD3,0xF5,0xD4,0xF7,0xF8,0xF9,0xD5,0x96,0x95,0x98,0xFE,0xFF}
;
;
;/* DBCS code range |----- 1st byte -----|  |----------- 2nd byte -----------| */
;/*                  <------>    <------>    <------>    <------>    <------>  */
;#define TBL_DC932 {0x81, 0x9F, 0xE0, 0xFC, 0x40, 0x7E, 0x80, 0xFC, 0x00, 0x00}
;#define TBL_DC936 {0x81, 0xFE, 0x00, 0x00, 0x40, 0x7E, 0x80, 0xFE, 0x00, 0x00}
;#define TBL_DC949 {0x81, 0xFE, 0x00, 0x00, 0x41, 0x5A, 0x61, 0x7A, 0x81, 0xFE}
;#define TBL_DC950 {0x81, 0xFE, 0x00, 0x00, 0x40, 0x7E, 0xA1, 0xFE, 0x00, 0x00}
;
;
;/* Macros for table definitions */
;#define MERGE_2STR(a, b) a ## b
;#define MKCVTBL(hd, cp) MERGE_2STR(hd, cp)
;
;
;
;
;/*--------------------------------------------------------------------------
;
;   Module Private Work Area
;
;---------------------------------------------------------------------------*/
;/* Remark: Variables defined here without initial value shall be guaranteed
;/  zero/null at start-up. If not, the linker option or start-up routine is
;/  not compliance with C standard. */
;
;/*--------------------------------*/
;/* File/Volume controls           */
;/*--------------------------------*/
;
;#if FF_VOLUMES < 1 || FF_VOLUMES > 10
;#error Wrong FF_VOLUMES setting
;#endif
;static FATFS *FatFs[FF_VOLUMES];	/* Pointer to the filesystem objects (logical drives) */
;static WORD Fsid;					/* Filesystem mount ID */
;
;#if FF_FS_RPATH
;static BYTE CurrVol;				/* Current drive number set by f_chdrive() */
;#endif
;
;#if FF_FS_LOCK
;static FILESEM Files[FF_FS_LOCK];	/* Open object lock semaphores */
;#if FF_FS_REENTRANT
;static volatile BYTE SysLock;		/* System lock flag to protect Files[] (0:no mutex, 1:unlocked, 2:locked) */
;static volatile BYTE SysLockVolume;	/* Volume id who is locking Files[] */
;#endif
;#endif
;
;#if FF_STR_VOLUME_ID
;#ifdef FF_VOLUME_STRS
;static const char *const VolumeStr[FF_VOLUMES] = {FF_VOLUME_STRS};	/* Pre-defined volume ID */
;#endif
;#endif
;
;#if FF_LBA64
;#if FF_MIN_GPT > 0x100000000
;#error Wrong FF_MIN_GPT setting
;#endif
;static const BYTE GUID_MS_Basic[16] = {0xA2,0xA0,0xD0,0xEB,0xE5,0xB9,0x33,0x44,0x87,0xC0,0x68,0xB6,0xB7,0x26,0x99,0xC7};
;#endif
;
;
;
;/*--------------------------------*/
;/* LFN/Directory working buffer   */
;/*--------------------------------*/
;
;#if FF_USE_LFN == 0		/* Non-LFN configuration */
;#if FF_FS_EXFAT
;#error LFN must be enabled when enable exFAT
;#endif
;#define DEF_NAMEBUFF
;#define INIT_NAMEBUFF(fs)
;#define FREE_NAMEBUFF()
;#define LEAVE_MKFS(res)	return res
;
;#else					/* LFN configurations */
;#if FF_MAX_LFN < 12 || FF_MAX_LFN > 255
;#error Wrong setting of FF_MAX_LFN
;#endif
;#if FF_LFN_BUF < FF_SFN_BUF || FF_SFN_BUF < 12
;#error Wrong setting of FF_LFN_BUF or FF_SFN_BUF
;#endif
;#if FF_LFN_UNICODE < 0 || FF_LFN_UNICODE > 3
;#error Wrong setting of FF_LFN_UNICODE
;#endif
;static const BYTE LfnOfs[] = {1,3,5,7,9,14,16,18,20,22,24,28,30};	/* FAT: Offset of LFN characters in the directory entry */
;#define MAXDIRB(nc)	((nc + 44U) / 15 * SZDIRE)	/* exFAT: Size of directory entry block scratchpad buffer needed for the name length */
;
;#if FF_USE_LFN == 1		/* LFN enabled with static working buffer */
;#if FF_FS_EXFAT
;static BYTE	DirBuf[MAXDIRB(FF_MAX_LFN)];	/* Directory entry block scratchpad buffer */
;#endif
;static WCHAR LfnBuf[FF_MAX_LFN + 1];		/* LFN working buffer */
;#define DEF_NAMEBUFF
;#define INIT_NAMEBUFF(fs)
;#define FREE_NAMEBUFF()
;#define LEAVE_MKFS(res)	return res
;
;#elif FF_USE_LFN == 2 	/* LFN enabled with dynamic working buffer on the stack */
;#if FF_FS_EXFAT
;#define DEF_NAMEBUFF		WCHAR lbuf[FF_MAX_LFN+1]; BYTE dbuf[MAXDIRB(FF_MAX_LFN)];	/* LFN working buffer and directory entry block scratchpad buffer */
;#define INIT_NAMEBUFF(fs)	{ (fs)->lfnbuf = lbuf; (fs)->dirbuf = dbuf; }
;#define FREE_NAMEBUFF()
;#else
;#define DEF_NAMEBUFF		WCHAR lbuf[FF_MAX_LFN+1];	/* LFN working buffer */
;#define INIT_NAMEBUFF(fs)	{ (fs)->lfnbuf = lbuf; }
;#define FREE_NAMEBUFF()
;#endif
;#define LEAVE_MKFS(res)	return res
;
;#elif FF_USE_LFN == 3 	/* LFN enabled with dynamic working buffer on the heap */
;#if FF_FS_EXFAT
;#define DEF_NAMEBUFF		WCHAR *lfn;	/* Pointer to LFN working buffer and directory entry block scratchpad buffer */
;#define INIT_NAMEBUFF(fs)	{ lfn = ff_memalloc((FF_MAX_LFN+1)*2 + MAXDIRB(FF_MAX_LFN)); if (!lfn) LEAVE_FF(fs, FR_NOT_ENOUGH_CORE); (fs)->lfnbuf = lfn; (fs)->dirbuf = (BYTE*)(lfn+FF_MAX_LFN+1); }
;#define FREE_NAMEBUFF()	ff_memfree(lfn)
;#else
;#define DEF_NAMEBUFF		WCHAR *lfn;	/* Pointer to LFN working buffer */
;#define INIT_NAMEBUFF(fs)	{ lfn = ff_memalloc((FF_MAX_LFN+1)*2); if (!lfn) LEAVE_FF(fs, FR_NOT_ENOUGH_CORE); (fs)->lfnbuf = lfn; }
;#define FREE_NAMEBUFF()	ff_memfree(lfn)
;#endif
;#define LEAVE_MKFS(res)	{ if (!work) ff_memfree(buf); return res; }
;#define MAX_MALLOC	0x8000	/* Must be >=FF_MAX_SS */
;
;#else
;#error Wrong setting of FF_USE_LFN
;
;#endif	/* FF_USE_LFN == 1 */
;#endif	/* FF_USE_LFN == 0 */
;
;
;
;/*--------------------------------*/
;/* Code conversion tables         */
;/*--------------------------------*/
;
;#if FF_CODE_PAGE == 0	/* Run-time code page configuration */
;#define CODEPAGE CodePage
;static WORD CodePage;	/* Current code page */
;static const BYTE* ExCvt;	/* Pointer to SBCS up-case table Ct???[] (null:disabled) */
;static const BYTE* DbcTbl;	/* Pointer to DBCS code range table Dc???[] (null:disabled) */
;
;static const BYTE Ct437[] = TBL_CT437;
;static const BYTE Ct720[] = TBL_CT720;
;static const BYTE Ct737[] = TBL_CT737;
;static const BYTE Ct771[] = TBL_CT771;
;static const BYTE Ct775[] = TBL_CT775;
;static const BYTE Ct850[] = TBL_CT850;
;static const BYTE Ct852[] = TBL_CT852;
;static const BYTE Ct855[] = TBL_CT855;
;static const BYTE Ct857[] = TBL_CT857;
;static const BYTE Ct860[] = TBL_CT860;
;static const BYTE Ct861[] = TBL_CT861;
;static const BYTE Ct862[] = TBL_CT862;
;static const BYTE Ct863[] = TBL_CT863;
;static const BYTE Ct864[] = TBL_CT864;
;static const BYTE Ct865[] = TBL_CT865;
;static const BYTE Ct866[] = TBL_CT866;
;static const BYTE Ct869[] = TBL_CT869;
;static const BYTE Dc932[] = TBL_DC932;
;static const BYTE Dc936[] = TBL_DC936;
;static const BYTE Dc949[] = TBL_DC949;
;static const BYTE Dc950[] = TBL_DC950;
;
;#elif FF_CODE_PAGE < 900	/* Static code page configuration (SBCS) */
;#define CODEPAGE FF_CODE_PAGE
;static const BYTE ExCvt[] = MKCVTBL(TBL_CT, FF_CODE_PAGE);
	data
_~ExCvt:
	db	$43,$55,$45,$41,$41,$41,$41,$43,$45,$45
	db	$45,$49,$49,$49,$41,$41,$45,$92,$92,$4F
	db	$4F,$4F,$55,$55,$59,$4F,$55,$4F,$9C,$4F
	db	$9E,$9F,$41,$49,$4F,$55,$A5,$A5,$A6,$A7
	db	$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF,$B0,$B1
	db	$B2,$B3,$B4,$41,$41,$41,$B8,$B9,$BA,$BB
	db	$BC,$BD,$BE,$BF,$C0,$C1,$C2,$C3,$C4,$C5
	db	$41,$41,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF
	db	$D1,$D1,$45,$45,$45,$49,$49,$49,$49,$D9
	db	$DA,$DB,$DC,$DD,$49,$DF,$4F,$E1,$4F,$4F
	db	$4F,$4F,$E6,$E8,$E8,$55,$55,$55,$59,$59
	db	$EE,$EF,$F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7
	db	$F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF
	ends
;
;#else					/* Static code page configuration (DBCS) */
;#define CODEPAGE FF_CODE_PAGE
;static const BYTE DbcTbl[] = MKCVTBL(TBL_DC, FF_CODE_PAGE);
;
;#endif
;
;
;
;
;/*--------------------------------------------------------------------------
;
;   Module Private Functions
;
;---------------------------------------------------------------------------*/
;
;
;/*-----------------------------------------------------------------------*/
;/* Load/Store multi-byte word in the FAT structure                       */
;/*-----------------------------------------------------------------------*/
;
;static WORD ld_16 (const BYTE* ptr)	/*	 Load a 2-byte little-endian word */
;{
	code
	func
_~ld_16:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
ptr_0	set	3
;	WORD rv;
;
;	rv = ptr[1];
rv_1	set	0
	ldy	#$1
	lda	[<L2+ptr_0],Y
	and	#$ff
	sta	<L3+rv_1
;	rv = rv << 8 | ptr[0];
	xba
	and	#$ff00
	sta	<R0
	lda	[<L2+ptr_0]
	and	#$ff
	ora	<R0
	sta	<L3+rv_1
;	return rv;
	tay
	lda	<L2+1
	sta	<L2+1+4
	pld
	tsc
	clc
	adc	#L2+4
	tcs
	tya
	rts
;}
L2	equ	10
L3	equ	9
	ends
	efunc
;
;static DWORD ld_32 (const BYTE* ptr)	/* Load a 4-byte little-endian word */
;{
	code
	func
_~ld_32:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
ptr_0	set	3
;	DWORD rv;
;
;	rv = ptr[3];
rv_1	set	0
	ldy	#$3
	lda	[<L5+ptr_0],Y
	and	#$ff
	sta	<L6+rv_1
	stz	<L6+rv_1+2
;	rv = rv << 8 | ptr[2];
	pei	<L6+rv_1+2
	pei	<L6+rv_1
	lda	#$8
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	ldy	#$2
	lda	[<L5+ptr_0],Y
	and	#$ff
	sta	<R1
	stz	<R1+2
	lda	<R1
	ora	<R0
	sta	<L6+rv_1
	lda	<R1+2
	ora	<R0+2
	sta	<L6+rv_1+2
;	rv = rv << 8 | ptr[1];
	pha
	pei	<L6+rv_1
	lda	#$8
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	ldy	#$1
	lda	[<L5+ptr_0],Y
	and	#$ff
	sta	<R1
	stz	<R1+2
	lda	<R1
	ora	<R0
	sta	<L6+rv_1
	lda	<R1+2
	ora	<R0+2
	sta	<L6+rv_1+2
;	rv = rv << 8 | ptr[0];
	pha
	pei	<L6+rv_1
	lda	#$8
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	[<L5+ptr_0]
	and	#$ff
	sta	<R1
	stz	<R1+2
	lda	<R1
	ora	<R0
	sta	<L6+rv_1
	lda	<R1+2
	ora	<R0+2
	sta	<L6+rv_1+2
;	return rv;
	ldx	<L6+rv_1+2
	lda	<L6+rv_1
	tay
	lda	<L5+1
	sta	<L5+1+4
	pld
	tsc
	clc
	adc	#L5+4
	tcs
	tya
	rts
;}
L5	equ	12
L6	equ	9
	ends
	efunc
;
;#if FF_FS_EXFAT
;static QWORD ld_64 (const BYTE* ptr)	/* Load an 8-byte little-endian word */
;{
;	QWORD rv;
;
;	rv = ptr[7];
;	rv = rv << 8 | ptr[6];
;	rv = rv << 8 | ptr[5];
;	rv = rv << 8 | ptr[4];
;	rv = rv << 8 | ptr[3];
;	rv = rv << 8 | ptr[2];
;	rv = rv << 8 | ptr[1];
;	rv = rv << 8 | ptr[0];
;	return rv;
;}
;#endif
;
;#if !FF_FS_READONLY
;static void st_16 (BYTE* ptr, WORD val)	/* Store a 2-byte word in little-endian */
;{
	code
	func
_~st_16:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
ptr_0	set	3
val_0	set	7
;	*ptr++ = (BYTE)val; val >>= 8;
	sep	#$20
	longa	off
	lda	<L8+val_0
	sta	[<L8+ptr_0]
	rep	#$20
	longa	on
	inc	<L8+ptr_0
	bne	L10
	inc	<L8+ptr_0+2
L10:
	lda	<L8+val_0
	xba
	and	#$00ff
	sta	<L8+val_0
;	*ptr++ = (BYTE)val;
	sep	#$20
	longa	off
	sta	[<L8+ptr_0]
	rep	#$20
	longa	on
	inc	<L8+ptr_0
	bne	L12
	inc	<L8+ptr_0+2
;}
L12:
	lda	<L8+1
	sta	<L8+1+6
	pld
	tsc
	clc
	adc	#L8+6
	tcs
	rts
L8	equ	0
L9	equ	1
	ends
	efunc
;
;static void st_32 (BYTE* ptr, DWORD val)	/* Store a 4-byte word in little-endian */
;{
	code
	func
_~st_32:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L13
	tcs
	phd
	tcd
ptr_0	set	3
val_0	set	7
;	*ptr++ = (BYTE)val; val >>= 8;
	sep	#$20
	longa	off
	lda	<L13+val_0
	sta	[<L13+ptr_0]
	rep	#$20
	longa	on
	inc	<L13+ptr_0
	bne	L15
	inc	<L13+ptr_0+2
L15:
	pei	<L13+val_0+2
	pei	<L13+val_0
	lda	#$8
	xref	_~~llsr
	jsr	_~~llsr
	sta	<L13+val_0
	stx	<L13+val_0+2
;	*ptr++ = (BYTE)val; val >>= 8;
	sep	#$20
	longa	off
	lda	<L13+val_0
	sta	[<L13+ptr_0]
	rep	#$20
	longa	on
	inc	<L13+ptr_0
	bne	L16
	inc	<L13+ptr_0+2
L16:
	pei	<L13+val_0+2
	pei	<L13+val_0
	lda	#$8
	xref	_~~llsr
	jsr	_~~llsr
	sta	<L13+val_0
	stx	<L13+val_0+2
;	*ptr++ = (BYTE)val; val >>= 8;
	sep	#$20
	longa	off
	lda	<L13+val_0
	sta	[<L13+ptr_0]
	rep	#$20
	longa	on
	inc	<L13+ptr_0
	bne	L17
	inc	<L13+ptr_0+2
L17:
	pei	<L13+val_0+2
	pei	<L13+val_0
	lda	#$8
	xref	_~~llsr
	jsr	_~~llsr
	sta	<L13+val_0
	stx	<L13+val_0+2
;	*ptr++ = (BYTE)val;
	sep	#$20
	longa	off
	lda	<L13+val_0
	sta	[<L13+ptr_0]
	rep	#$20
	longa	on
	inc	<L13+ptr_0
	bne	L19
	inc	<L13+ptr_0+2
;}
L19:
	lda	<L13+1
	sta	<L13+1+8
	pld
	tsc
	clc
	adc	#L13+8
	tcs
	rts
L13	equ	0
L14	equ	1
	ends
	efunc
;
;#if FF_FS_EXFAT
;static void st_64 (BYTE* ptr, QWORD val)	/* Store an 8-byte word in little-endian */
;{
;	*ptr++ = (BYTE)val; val >>= 8;
;	*ptr++ = (BYTE)val; val >>= 8;
;	*ptr++ = (BYTE)val; val >>= 8;
;	*ptr++ = (BYTE)val; val >>= 8;
;	*ptr++ = (BYTE)val; val >>= 8;
;	*ptr++ = (BYTE)val; val >>= 8;
;	*ptr++ = (BYTE)val; val >>= 8;
;	*ptr++ = (BYTE)val;
;}
;#endif
;#endif	/* !FF_FS_READONLY */
;
;
;
;/*-----------------------------------------------------------------------*/
;/* String functions                                                      */
;/*-----------------------------------------------------------------------*/
;
;/* Test if the byte is DBC 1st byte */
;static int dbc_1st (BYTE c)
;{
	code
	func
_~dbc_1st:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L20
	tcs
	phd
	tcd
c_0	set	3
;#if FF_CODE_PAGE == 0		/* Variable code page */
;	if (DbcTbl && c >= DbcTbl[0]) {
;		if (c <= DbcTbl[1]) return 1;					/* 1st byte range 1 */
;		if (c >= DbcTbl[2] && c <= DbcTbl[3]) return 1;	/* 1st byte range 2 */
;	}
;#elif FF_CODE_PAGE >= 900	/* DBCS fixed code page */
;	if (c >= DbcTbl[0]) {
;		if (c <= DbcTbl[1]) return 1;
;		if (c >= DbcTbl[2] && c <= DbcTbl[3]) return 1;
;	}
;#else						/* SBCS fixed code page */
;	if (c != 0) return 0;	/* Always false */
	lda	<L20+c_0
	and	#$ff
	beq	L20000
L20000:
	lda	#$0
	tay
	lda	<L20+1
	sta	<L20+1+2
	pld
	tsc
	clc
	adc	#L20+2
	tcs
	tya
	rts
;#endif
;	return 0;
;}
L20	equ	0
L21	equ	1
	ends
	efunc
;
;
;/* Test if the byte is DBC 2nd byte */
;static int dbc_2nd (BYTE c)
;{
	code
	func
_~dbc_2nd:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L24
	tcs
	phd
	tcd
c_0	set	3
;#if FF_CODE_PAGE == 0		/* Variable code page */
;	if (DbcTbl && c >= DbcTbl[4]) {
;		if (c <= DbcTbl[5]) return 1;					/* 2nd byte range 1 */
;		if (c >= DbcTbl[6] && c <= DbcTbl[7]) return 1;	/* 2nd byte range 2 */
;		if (c >= DbcTbl[8] && c <= DbcTbl[9]) return 1;	/* 2nd byte range 3 */
;	}
;#elif FF_CODE_PAGE >= 900	/* DBCS fixed code page */
;	if (c >= DbcTbl[4]) {
;		if (c <= DbcTbl[5]) return 1;
;		if (c >= DbcTbl[6] && c <= DbcTbl[7]) return 1;
;		if (c >= DbcTbl[8] && c <= DbcTbl[9]) return 1;
;	}
;#else						/* SBCS fixed code page */
;	if (c != 0) return 0;	/* Always false */
	lda	<L24+c_0
	and	#$ff
	beq	L20001
L20001:
	lda	#$0
	tay
	lda	<L24+1
	sta	<L24+1+2
	pld
	tsc
	clc
	adc	#L24+2
	tcs
	tya
	rts
;#endif
;	return 0;
;}
L24	equ	0
L25	equ	1
	ends
	efunc
;
;
;#if FF_USE_LFN
;
;/* Get a Unicode code point from the TCHAR string in defined API encodeing */
;static DWORD tchar2uni (	/* Returns a character in UTF-16 encoding (>=0x10000 on surrogate pair, 0xFFFFFFFF on decode error) */
;	const TCHAR** str		/* Pointer to pointer to TCHAR string in configured encoding */
;)
;{
;	DWORD uc;
;	const TCHAR *p = *str;
;
;#if FF_LFN_UNICODE == 1		/* UTF-16 input */
;	WCHAR wc;
;
;	uc = *p++;	/* Get an encoding unit */
;	if (IsSurrogate(uc)) {	/* Surrogate? */
;		wc = *p++;		/* Get low surrogate */
;		if (!IsSurrogateH(uc) || !IsSurrogateL(wc)) return 0xFFFFFFFF;	/* Wrong surrogate? */
;		uc = uc << 16 | wc;
;	}
;
;#elif FF_LFN_UNICODE == 2	/* UTF-8 input */
;	BYTE tb;
;	int nf;
;
;	uc = (BYTE)*p++;	/* Get an encoding unit */
;	if (uc & 0x80) {	/* Multiple byte code? */
;		if        ((uc & 0xE0) == 0xC0) {	/* 2-byte sequence? */
;			uc &= 0x1F; nf = 1;
;		} else if ((uc & 0xF0) == 0xE0) {	/* 3-byte sequence? */
;			uc &= 0x0F; nf = 2;
;		} else if ((uc & 0xF8) == 0xF0) {	/* 4-byte sequence? */
;			uc &= 0x07; nf = 3;
;		} else {							/* Wrong sequence */
;			return 0xFFFFFFFF;
;		}
;		do {	/* Get and merge trailing bytes */
;			tb = (BYTE)*p++;
;			if ((tb & 0xC0) != 0x80) return 0xFFFFFFFF;	/* Wrong sequence? */
;			uc = uc << 6 | (tb & 0x3F);
;		} while (--nf != 0);
;		if (uc < 0x80 || IsSurrogate(uc) || uc >= 0x110000) return 0xFFFFFFFF;	/* Wrong code? */
;		if (uc >= 0x010000) uc = 0xD800DC00 | ((uc - 0x10000) << 6 & 0x3FF0000) | (uc & 0x3FF);	/* Make a surrogate pair if needed */
;	}
;
;#elif FF_LFN_UNICODE == 3	/* UTF-32 input */
;	uc = (TCHAR)*p++;	/* Get a unit */
;	if (uc >= 0x110000 || IsSurrogate(uc)) return 0xFFFFFFFF;	/* Wrong code? */
;	if (uc >= 0x010000) uc = 0xD800DC00 | ((uc - 0x10000) << 6 & 0x3FF0000) | (uc & 0x3FF);	/* Make a surrogate pair if needed */
;
;#else		/* ANSI/OEM input */
;	BYTE sb;
;	WCHAR wc;
;
;	wc = (BYTE)*p++;			/* Get a byte */
;	if (dbc_1st((BYTE)wc)) {	/* Is it a DBC 1st byte? */
;		sb = (BYTE)*p++;		/* Get 2nd byte */
;		if (!dbc_2nd(sb)) return 0xFFFFFFFF;	/* Invalid code? */
;		wc = (wc << 8) + sb;	/* Make a DBC */
;	}
;	if (wc != 0) {
;		wc = ff_oem2uni(wc, CODEPAGE);	/* ANSI/OEM ==> Unicode */
;		if (wc == 0) return 0xFFFFFFFF;	/* Invalid code? */
;	}
;	uc = wc;
;
;#endif
;	*str = p;	/* Next read pointer */
;	return uc;
;}
;
;
;/* Store a Unicode char in defined API encoding */
;static UINT put_utf (	/* Returns number of encoding units written (0:buffer overflow or wrong encoding) */
;	DWORD chr,	/* UTF-16 encoded character (Surrogate pair if >=0x10000) */
;	TCHAR* buf,	/* Output buffer */
;	UINT szb	/* Size of the buffer */
;)
;{
;#if FF_LFN_UNICODE == 1	/* UTF-16 output */
;	WCHAR hs, wc;
;
;	hs = (WCHAR)(chr >> 16);
;	wc = (WCHAR)chr;
;	if (hs == 0) {	/* Single encoding unit? */
;		if (szb < 1 || IsSurrogate(wc)) return 0;	/* Buffer overflow or wrong code? */
;		*buf = wc;
;		return 1;
;	}
;	if (szb < 2 || !IsSurrogateH(hs) || !IsSurrogateL(wc)) return 0;	/* Buffer overflow or wrong surrogate? */
;	*buf++ = hs;
;	*buf++ = wc;
;	return 2;
;
;#elif FF_LFN_UNICODE == 2	/* UTF-8 output */
;	DWORD hc;
;
;	if (chr < 0x80) {	/* Single byte code? */
;		if (szb < 1) return 0;	/* Buffer overflow? */
;		*buf = (TCHAR)chr;
;		return 1;
;	}
;	if (chr < 0x800) {	/* 2-byte sequence? */
;		if (szb < 2) return 0;	/* Buffer overflow? */
;		*buf++ = (TCHAR)(0xC0 | (chr >> 6 & 0x1F));
;		*buf++ = (TCHAR)(0x80 | (chr >> 0 & 0x3F));
;		return 2;
;	}
;	if (chr < 0x10000) {	/* 3-byte sequence? */
;		if (szb < 3 || IsSurrogate(chr)) return 0;	/* Buffer overflow or wrong code? */
;		*buf++ = (TCHAR)(0xE0 | (chr >> 12 & 0x0F));
;		*buf++ = (TCHAR)(0x80 | (chr >> 6 & 0x3F));
;		*buf++ = (TCHAR)(0x80 | (chr >> 0 & 0x3F));
;		return 3;
;	}
;	/* 4-byte sequence */
;	if (szb < 4) return 0;	/* Buffer overflow? */
;	hc = ((chr & 0xFFFF0000) - 0xD8000000) >> 6;	/* Get high 10 bits */
;	chr = (chr & 0xFFFF) - 0xDC00;					/* Get low 10 bits */
;	if (hc >= 0x100000 || chr >= 0x400) return 0;	/* Wrong surrogate? */
;	chr = (hc | chr) + 0x10000;
;	*buf++ = (TCHAR)(0xF0 | (chr >> 18 & 0x07));
;	*buf++ = (TCHAR)(0x80 | (chr >> 12 & 0x3F));
;	*buf++ = (TCHAR)(0x80 | (chr >> 6 & 0x3F));
;	*buf++ = (TCHAR)(0x80 | (chr >> 0 & 0x3F));
;	return 4;
;
;#elif FF_LFN_UNICODE == 3	/* UTF-32 output */
;	DWORD hc;
;
;	if (szb < 1) return 0;	/* Buffer overflow? */
;	if (chr >= 0x10000) {	/* Out of BMP? */
;		hc = ((chr & 0xFFFF0000) - 0xD8000000) >> 6;	/* Get high 10 bits */
;		chr = (chr & 0xFFFF) - 0xDC00;					/* Get low 10 bits */
;		if (hc >= 0x100000 || chr >= 0x400) return 0;	/* Wrong surrogate? */
;		chr = (hc | chr) + 0x10000;
;	}
;	*buf++ = (TCHAR)chr;
;	return 1;
;
;#else						/* ANSI/OEM output */
;	WCHAR wc;
;
;	wc = ff_uni2oem(chr, CODEPAGE);
;	if (wc >= 0x100) {	/* Is this a DBC? */
;		if (szb < 2) return 0;
;		*buf++ = (char)(wc >> 8);	/* Store DBC 1st byte */
;		*buf++ = (TCHAR)wc;			/* Store DBC 2nd byte */
;		return 2;
;	}
;	if (wc == 0 || szb < 1) return 0;	/* Invalid character or buffer overflow? */
;	*buf++ = (TCHAR)wc;					/* Store the character */
;	return 1;
;#endif
;}
;#endif	/* FF_USE_LFN */
;
;
;#if FF_FS_REENTRANT
;/*-----------------------------------------------------------------------*/
;/* Request/Release grant to access the volume                            */
;/*-----------------------------------------------------------------------*/
;
;static int lock_volume (	/* 1:Ok, 0:timeout */
;	FATFS* fs,				/* Filesystem object to lock */
;	int syslock				/* System lock required */
;)
;{
	code
	func
_~lock_volume:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L28
	tcs
	phd
	tcd
fs_0	set	3
syslock_0	set	7
;	int rv;
;
;
;#if FF_FS_LOCK
;	rv = ff_mutex_take(fs->ldrv);	/* Lock the volume */
rv_1	set	0
	ldy	#$2
	lda	[<L28+fs_0],Y
	and	#$ff
	pha
	jsr	_~ff_mutex_take
	sta	<L29+rv_1
;	if (rv && syslock) {			/* System lock reqiered? */
	lda	<L29+rv_1
	beq	L10003
	lda	<L28+syslock_0
	beq	L10003
;		rv = ff_mutex_take(FF_VOLUMES);	/* Lock the system */
	pea	#<$1
	jsr	_~ff_mutex_take
	sta	<L29+rv_1
;		if (rv) {
	lda	<L29+rv_1
	beq	L10004
;			SysLockVolume = fs->ldrv;
	sep	#$20
	longa	off
	ldy	#$2
	lda	[<L28+fs_0],Y
	sta	|_~SysLockVolume	; volatile
;			SysLock = 2;				/* System lock succeeded */
	tya
	sta	|_~SysLock	; volatile
	rep	#$20
	longa	on
;		} else {
	bra	L10003
L10004:
;			ff_mutex_give(fs->ldrv);	/* Failed system lock */
	ldy	#$2
	lda	[<L28+fs_0],Y
	and	#$ff
	pha
	jsr	_~ff_mutex_give
;		}
;	}
;#else
;	rv = syslock ? ff_mutex_take(fs->ldrv) : ff_mutex_take(fs->ldrv);	/* Lock the volume (this is to prevent compiler warning) */
;#endif
;	return rv;
L10003:
	lda	<L29+rv_1
	tay
	lda	<L28+1
	sta	<L28+1+6
	pld
	tsc
	clc
	adc	#L28+6
	tcs
	tya
	rts
;}
L28	equ	2
L29	equ	1
	ends
	efunc
;
;
;static void unlock_volume (
;	FATFS* fs,		/* Filesystem object */
;	FRESULT res		/* Result code to be returned */
;)
;{
	code
	func
_~unlock_volume:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L34
	tcs
	phd
	tcd
fs_0	set	3
res_0	set	7
;	if (fs && res != FR_NOT_ENABLED && res != FR_INVALID_DRIVE && res != FR_TIMEOUT) {
	lda	<L34+fs_0
	ora	<L34+fs_0+2
	beq	L42
	lda	<L34+res_0
	cmp	#<$c
	beq	L42
	lda	<L34+res_0
	cmp	#<$b
	beq	L42
	lda	<L34+res_0
	cmp	#<$f
	beq	L42
;#if FF_FS_LOCK
;		if (SysLock == 2 && SysLockVolume == fs->ldrv) {	/* Unlock system if it has been locked by this task */
	sep	#$20
	longa	off
	lda	|_~SysLock	; volatile
	cmp	#<$2
	rep	#$20
	longa	on
	bne	L10007
	sep	#$20
	longa	off
	lda	|_~SysLockVolume	; volatile
	ldy	#$2
	cmp	[<L34+fs_0],Y
	rep	#$20
	longa	on
	bne	L10007
;			SysLock = 1;
	sep	#$20
	longa	off
	lda	#$1
	sta	|_~SysLock	; volatile
	rep	#$20
	longa	on
;			ff_mutex_give(FF_VOLUMES);
	pea	#<$1
	jsr	_~ff_mutex_give
;		}
;#endif
;		ff_mutex_give(fs->ldrv);	/* Unlock the volume */
L10007:
	ldy	#$2
	lda	[<L34+fs_0],Y
	and	#$ff
	pha
	jsr	_~ff_mutex_give
;	}
;}
L42:
	lda	<L34+1
	sta	<L34+1+6
	pld
	tsc
	clc
	adc	#L34+6
	tcs
	rts
L34	equ	0
L35	equ	1
	ends
	efunc
;
;#endif
;
;
;
;#if FF_FS_LOCK
;/*-----------------------------------------------------------------------*/
;/* File sharing control functions                                       */
;/*-----------------------------------------------------------------------*/
;
;static FRESULT chk_share (	/* Check if the file can be accessed */
;	DIR* dp,		/* Directory object pointing the file to be checked */
;	int acc			/* Desired access type (0:Read mode open, 1:Write mode open, 2:Delete or rename) */
;)
;{
	code
	func
_~chk_share:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L43
	tcs
	phd
	tcd
dp_0	set	3
acc_0	set	7
;	UINT i, be;
;
;	/* Search open object table for the object */
;	be = 0;
i_1	set	0
be_1	set	2
	stz	<L44+be_1
;	for (i = 0; i < FF_FS_LOCK; i++) {
	stz	<L44+i_1
L10010:
;		if (Files[i].fs) {	/* Existing entry */
	lda	<L44+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~Files
	sta	<R1
	lda	(<R1)
	ldy	#$2
	ora	(<R1),Y
	bne	*+5
	brl	L10011
;			if (Files[i].fs == dp->obj.fs &&	 	/* Check if the object matches with an open object */
;				Files[i].clu == dp->obj.sclust &&
;				Files[i].ofs == dp->dptr) break;
	lda	<L44+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~Files
	sta	<R1
	lda	(<R1)
	cmp	[<L43+dp_0]
	bne	L47
	ldy	#$2
	lda	(<R1),Y
	cmp	[<L43+dp_0],Y
L47:
	bne	L10008
	lda	<L44+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$4
	clc
	adc	#<_~Files
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	ldy	#$8
	cmp	[<L43+dp_0],Y
	bne	L49
	ldy	#$2
	lda	(<R2),Y
	ldy	#$a
	cmp	[<L43+dp_0],Y
L49:
	bne	L10008
	lda	<L44+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$8
	clc
	adc	#<_~Files
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	ldy	#$12
	cmp	[<L43+dp_0],Y
	bne	L51
	ldy	#$2
	lda	(<R2),Y
	ldy	#$14
	cmp	[<L43+dp_0],Y
L51:
	bne	L10008
L10009:
;	if (i == FF_FS_LOCK) {	/* The object has not been opened */
	lda	<L44+i_1
	cmp	#<$20
	beq	L54
	lda	<L43+acc_0
	beq	L62
L61:
	lda	#$10
	bra	L59
;		} else {			/* Blank entry */
L10011:
;			be = 1;
	lda	#$1
	sta	<L44+be_1
;		}
;	}
L10008:
	inc	<L44+i_1
	lda	<L44+i_1
	cmp	#<$20
	bcs	L10009
	brl	L10010
L54:
;		return (!be && acc != 2) ? FR_TOO_MANY_OPEN_FILES : FR_OK;	/* Is there a blank entry for new object? */
	lda	<L44+be_1
	bne	L55
	lda	<L43+acc_0
	cmp	#<$2
	beq	L55
	lda	#$12
	bra	L59
;	}
;
;	/* The object was opened. Reject any open against writing file and all write mode open */
;	return (acc != 0 || Files[i].ctr == 0x100) ? FR_LOCKED : FR_OK;
L62:
	lda	<L44+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~Files+12,X
	cmp	#<$100
	beq	L61
L55:
	lda	#$0
L59:
	tay
	lda	<L43+1
	sta	<L43+1+6
	pld
	tsc
	clc
	adc	#L43+6
	tcs
	tya
	rts
;}
L43	equ	16
L44	equ	13
	ends
	efunc
;
;
;static int enq_share (void)	/* Check if an entry is available for a new object */
;{
	code
	func
_~enq_share:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L65
	tcs
	phd
	tcd
;	UINT i;
;
;	for (i = 0; i < FF_FS_LOCK && Files[i].fs; i++) ;	/* Find a free entry */
i_1	set	0
	stz	<L66+i_1
	bra	L10017
L10014:
	inc	<L66+i_1
L10017:
	lda	<L66+i_1
	cmp	#<$20
	bcs	L10015
	lda	<L66+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~Files
	sta	<R1
	lda	(<R1)
	ldy	#$2
	ora	(<R1),Y
	bne	L10014
L10015:
;	return (i == FF_FS_LOCK) ? 0 : 1;
	lda	<L66+i_1
	cmp	#<$20
	bne	L70
	lda	#$0
	bra	L73
L70:
	lda	#$1
L73:
	tay
	pld
	tsc
	clc
	adc	#L65
	tcs
	tya
	rts
;}
L65	equ	10
L66	equ	9
	ends
	efunc
;
;
;static UINT inc_share (	/* Increment object open counter and returns its index (0:Internal error) */
;	DIR* dp,	/* Directory object pointing the file to register or increment */
;	int acc		/* Desired access (0:Read, 1:Write, 2:Delete/Rename) */
;)
;{
	code
	func
_~inc_share:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L74
	tcs
	phd
	tcd
dp_0	set	3
acc_0	set	7
;	UINT i;
;
;
;	for (i = 0; i < FF_FS_LOCK; i++) {	/* Find the object */
i_1	set	0
	stz	<L75+i_1
L10020:
;		if (Files[i].fs == dp->obj.fs
;		 && Files[i].clu == dp->obj.sclust
;		 && Files[i].ofs == dp->dptr) break;
	lda	<L75+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~Files
	sta	<R1
	lda	(<R1)
	cmp	[<L74+dp_0]
	bne	L77
	ldy	#$2
	lda	(<R1),Y
	cmp	[<L74+dp_0],Y
L77:
	bne	L10018
	lda	<L75+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$4
	clc
	adc	#<_~Files
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	ldy	#$8
	cmp	[<L74+dp_0],Y
	bne	L79
	ldy	#$2
	lda	(<R2),Y
	ldy	#$a
	cmp	[<L74+dp_0],Y
L79:
	bne	L10018
	lda	<L75+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$8
	clc
	adc	#<_~Files
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	ldy	#$12
	cmp	[<L74+dp_0],Y
	bne	L81
	ldy	#$2
	lda	(<R2),Y
	ldy	#$14
	cmp	[<L74+dp_0],Y
L81:
	beq	L10019
;	}
L10018:
	inc	<L75+i_1
	lda	<L75+i_1
	cmp	#<$20
	bcc	L10020
L10019:
;
;	if (i == FF_FS_LOCK) {			/* Not opened. Register it as new. */
	lda	<L75+i_1
	cmp	#<$20
	beq	*+5
	brl	L10021
;		for (i = 0; i < FF_FS_LOCK && Files[i].fs; i++) ;	/* Find a free entry */
	stz	<L75+i_1
	bra	L10025
L10022:
	inc	<L75+i_1
L10025:
	lda	<L75+i_1
	cmp	#<$20
	bcs	L10023
	lda	<L75+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~Files
	sta	<R1
	lda	(<R1)
	ldy	#$2
	ora	(<R1),Y
	bne	L10022
L10023:
;		if (i == FF_FS_LOCK) return 0;	/* No free entry to register (int err) */
	lda	<L75+i_1
	cmp	#<$20
	bne	L10026
L20002:
	lda	#$0
L89:
	tay
	lda	<L74+1
	sta	<L74+1+6
	pld
	tsc
	clc
	adc	#L74+6
	tcs
	tya
	rts
;		Files[i].fs = dp->obj.fs;
L10026:
	lda	<L75+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~Files
	sta	<R1
	lda	[<L74+dp_0]
	sta	(<R1)
	ldy	#$2
	lda	[<L74+dp_0],Y
	sta	(<R1),Y
;		Files[i].clu = dp->obj.sclust;
	lda	<L75+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$4
	clc
	adc	#<_~Files
	clc
	adc	<R0
	sta	<R2
	ldy	#$8
	lda	[<L74+dp_0],Y
	sta	(<R2)
	iny
	iny
	lda	[<L74+dp_0],Y
	ldy	#$2
	sta	(<R2),Y
;		Files[i].ofs = dp->dptr;
	lda	<L75+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$8
	clc
	adc	#<_~Files
	clc
	adc	<R0
	sta	<R2
	ldy	#$12
	lda	[<L74+dp_0],Y
	sta	(<R2)
	iny
	iny
	lda	[<L74+dp_0],Y
	ldy	#$2
	sta	(<R2),Y
;		Files[i].ctr = 0;
	lda	<L75+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	#$0
	sta	|_~Files+12,X
;	}
;
;	if (acc >= 1 && Files[i].ctr) return 0;	/* Access violation (int err) */
L10021:
	sec
	lda	<L74+acc_0
	sbc	#<$1
	bvs	L90
	eor	#$8000
L90:
	bpl	L10027
	lda	<L75+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~Files+12,X
	beq	*+5
	brl	L20002
;
;	Files[i].ctr = acc ? 0x100 : Files[i].ctr + 1;	/* Set semaphore value */
L10027:
	lda	<L75+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	<L74+acc_0
	beq	L93
	lda	#$100
	bra	L95
L93:
	lda	<L75+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~Files+12,X
	ina
L95:
	sta	|_~Files+12,X
;
;	return i + 1;	/* Index number origin from 1 */
	lda	<L75+i_1
	ina
	brl	L89
;}
L74	equ	14
L75	equ	13
	ends
	efunc
;
;
;static FRESULT dec_share (	/* Decrement object open counter */
;	UINT i			/* Semaphore index (1..) */
;)
;{
	code
	func
_~dec_share:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L96
	tcs
	phd
	tcd
i_0	set	3
;	UINT n;
;	FRESULT res;
;
;
;	if (--i < FF_FS_LOCK) {	/* Index number origin from 0 */
n_1	set	0
res_1	set	2
	dec	<L96+i_0
	lda	<L96+i_0
	cmp	#<$20
	bcs	L10028
;		n = Files[i].ctr;
	lda	<L96+i_0
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~Files+12,X
	sta	<L97+n_1
;		if (n == 0x100) n = 0;	/* If write mode open, delete the object semaphore */
	cmp	#<$100
	bne	L10029
	stz	<L97+n_1
;		if (n > 0) n--;			/* Decrement read mode open count */
L10029:
	lda	#$0
	cmp	<L97+n_1
	bcs	L10030
	dec	<L97+n_1
;		Files[i].ctr = n;
L10030:
	lda	<L96+i_0
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	<L97+n_1
	sta	|_~Files+12,X
;		if (n == 0) {			/* Delete the object semaphore if open count becomes zero */
	lda	<L97+n_1
	bne	L10031
;			Files[i].fs = 0;	/* Free the entry <<<If this memory write operation is not in atomic, FF_FS_REENTRANT == 1 and FF_VOLUMES > 1, there is a potential error in this process >>> */
	lda	<L96+i_0
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~Files
	sta	<R1
	lda	#$0
	sta	(<R1)
	ldy	#$2
	sta	(<R1),Y
;		}
;		res = FR_OK;
L10031:
	stz	<L97+res_1
;	} else {
	bra	L10032
L10028:
;		res = FR_INT_ERR;		/* Invalid index number */
	lda	#$2
	sta	<L97+res_1
;	}
L10032:
;	return res;
	lda	<L97+res_1
	tay
	lda	<L96+1
	sta	<L96+1+2
	pld
	tsc
	clc
	adc	#L96+2
	tcs
	tya
	rts
;}
L96	equ	12
L97	equ	9
	ends
	efunc
;
;
;static void clear_share (	/* Clear all lock entries of the volume */
;	FATFS* fs
;)
;{
	code
	func
_~clear_share:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L103
	tcs
	phd
	tcd
fs_0	set	3
;	UINT i;
;
;	for (i = 0; i < FF_FS_LOCK; i++) {
i_1	set	0
	stz	<L104+i_1
L10035:
;		if (Files[i].fs == fs) Files[i].fs = 0;
	lda	<L104+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~Files
	sta	<R1
	lda	(<R1)
	cmp	<L103+fs_0
	bne	L105
	ldy	#$2
	lda	(<R1),Y
	cmp	<L103+fs_0+2
L105:
	bne	L10033
	lda	<L104+i_1
	ldx	#<$e
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~Files
	sta	<R1
	lda	#$0
	sta	(<R1)
	ldy	#$2
	sta	(<R1),Y
;	}
L10033:
	inc	<L104+i_1
	lda	<L104+i_1
	cmp	#<$20
	bcc	L10035
;}
	lda	<L103+1
	sta	<L103+1+4
	pld
	tsc
	clc
	adc	#L103+4
	tcs
	rts
L103	equ	10
L104	equ	9
	ends
	efunc
;
;#endif	/* FF_FS_LOCK */
;
;
;
;/*-----------------------------------------------------------------------*/
;/* Move/Flush disk access window in the filesystem object                */
;/*-----------------------------------------------------------------------*/
;#if !FF_FS_READONLY
;static FRESULT sync_window (	/* Returns FR_OK or FR_DISK_ERR */
;	FATFS* fs			/* Filesystem object */
;)
;{
	code
	func
_~sync_window:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L109
	tcs
	phd
	tcd
fs_0	set	3
;	FRESULT res = FR_OK;
;
;
;	if (fs->wflag) {	/* Is the disk access window dirty? */
res_1	set	0
	stz	<L110+res_1
	ldy	#$4
	lda	[<L109+fs_0],Y
	and	#$ff
	bne	*+5
	brl	L10037
;		if (disk_write(fs->pdrv, fs->win, fs->winsect, 1) == RES_OK) {	/* Write it back into the volume */
	pea	#<$1
	ldy	#$22
	lda	[<L109+fs_0],Y
	pha
	dey
	dey
	lda	[<L109+fs_0],Y
	pha
	lda	#$34
	clc
	adc	<L109+fs_0
	sta	<R0
	lda	#$0
	adc	<L109+fs_0+2
	pha
	pei	<R0
	ldy	#$1
	lda	[<L109+fs_0],Y
	pha
	jsr	_~disk_write
	tax
	bne	L10038
;			fs->wflag = 0;	/* Clear window dirty flag */
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$4
	sta	[<L109+fs_0],Y
	rep	#$20
	longa	on
;			if (fs->winsect - fs->fatbase < fs->fsize) {	/* Is it in the 1st FAT? */
	sec
	ldy	#$20
	lda	[<L109+fs_0],Y
	ldy	#$28
	sbc	[<L109+fs_0],Y
	sta	<R0
	ldy	#$22
	lda	[<L109+fs_0],Y
	ldy	#$2a
	sbc	[<L109+fs_0],Y
	sta	<R0+2
	lda	<R0
	ldy	#$1c
	cmp	[<L109+fs_0],Y
	lda	<R0+2
	iny
	iny
	sbc	[<L109+fs_0],Y
	bcs	L10037
;				if (fs->n_fats == 2) disk_write(fs->pdrv, fs->win, fs->winsect + fs->fsize, 1);	/* Reflect it to 2nd FAT if needed */
	sep	#$20
	longa	off
	ldy	#$3
	lda	[<L109+fs_0],Y
	cmp	#<$2
	rep	#$20
	longa	on
	bne	L10037
	pea	#<$1
	clc
	ldy	#$20
	lda	[<L109+fs_0],Y
	ldy	#$1c
	adc	[<L109+fs_0],Y
	sta	<R0
	ldy	#$22
	lda	[<L109+fs_0],Y
	ldy	#$1e
	adc	[<L109+fs_0],Y
	pha
	pei	<R0
	lda	#$34
	clc
	adc	<L109+fs_0
	sta	<R1
	lda	#$0
	adc	<L109+fs_0+2
	pha
	pei	<R1
	ldy	#$1
	lda	[<L109+fs_0],Y
	pha
	jsr	_~disk_write
;			}
;		} else {
	bra	L10037
L10038:
;			res = FR_DISK_ERR;
	lda	#$1
	sta	<L110+res_1
;		}
;	}
;	return res;
L10037:
	lda	<L110+res_1
	tay
	lda	<L109+1
	sta	<L109+1+4
	pld
	tsc
	clc
	adc	#L109+4
	tcs
	tya
	rts
;}
L109	equ	10
L110	equ	9
	ends
	efunc
;#endif
;
;
;static FRESULT move_window (	/* Returns FR_OK or FR_DISK_ERR */
;	FATFS* fs,		/* Filesystem object */
;	LBA_t sect		/* Sector LBA to make appearance in the fs->win[] */
;)
;{
	code
	func
_~move_window:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L116
	tcs
	phd
	tcd
fs_0	set	3
sect_0	set	7
;	FRESULT res = FR_OK;
;
;
;	if (sect != fs->winsect) {	/* Window offset changed? */
res_1	set	0
	stz	<L117+res_1
	lda	<L116+sect_0
	ldy	#$20
	cmp	[<L116+fs_0],Y
	bne	L118
	lda	<L116+sect_0+2
	iny
	iny
	cmp	[<L116+fs_0],Y
L118:
	beq	L10042
;#if !FF_FS_READONLY
;		res = sync_window(fs);		/* Flush the window */
	pei	<L116+fs_0+2
	pei	<L116+fs_0
	jsr	_~sync_window
	sta	<L117+res_1
;#endif
;		if (res == FR_OK) {			/* Fill sector window with new data */
	lda	<L117+res_1
	bne	L10042
;			if (disk_read(fs->pdrv, fs->win, sect, 1) != RES_OK) {
	pea	#<$1
	pei	<L116+sect_0+2
	pei	<L116+sect_0
	lda	#$34
	clc
	adc	<L116+fs_0
	sta	<R0
	lda	#$0
	adc	<L116+fs_0+2
	pha
	pei	<R0
	ldy	#$1
	lda	[<L116+fs_0],Y
	pha
	jsr	_~disk_read
	tax
	beq	L10044
;				sect = (LBA_t)0 - 1;	/* Invalidate window if read data is not valid */
	lda	#$ffff
	sta	<L116+sect_0
	sta	<L116+sect_0+2
;				res = FR_DISK_ERR;
	lda	#$1
	sta	<L117+res_1
;			}
;			fs->winsect = sect;
L10044:
	lda	<L116+sect_0
	ldy	#$20
	sta	[<L116+fs_0],Y
	lda	<L116+sect_0+2
	iny
	iny
	sta	[<L116+fs_0],Y
;		}
;	}
;	return res;
L10042:
	lda	<L117+res_1
	tay
	lda	<L116+1
	sta	<L116+1+8
	pld
	tsc
	clc
	adc	#L116+8
	tcs
	tya
	rts
;}
L116	equ	6
L117	equ	5
	ends
	efunc
;
;
;
;
;#if !FF_FS_READONLY
;/*-----------------------------------------------------------------------*/
;/* Synchronize filesystem and data on the storage                        */
;/*-----------------------------------------------------------------------*/
;
;static FRESULT sync_fs (	/* Returns FR_OK or FR_DISK_ERR */
;	FATFS* fs		/* Filesystem object */
;)
;{
	code
	func
_~sync_fs:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L123
	tcs
	phd
	tcd
fs_0	set	3
;	FRESULT res;
;
;
;	res = sync_window(fs);
res_1	set	0
	pei	<L123+fs_0+2
	pei	<L123+fs_0
	jsr	_~sync_window
	sta	<L124+res_1
;	if (res == FR_OK) {
	lda	<L124+res_1
	beq	*+5
	brl	L10045
;		if (fs->fsi_flag == 1) {	/* Allocation changed? */
	sep	#$20
	longa	off
	ldy	#$5
	lda	[<L123+fs_0],Y
	cmp	#<$1
	rep	#$20
	longa	on
	beq	*+5
	brl	L10046
;			fs->fsi_flag = 0;
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L123+fs_0],Y
;			if (fs->fs_type == FS_FAT32) {	/* FAT32: Update FSInfo sector */
	lda	[<L123+fs_0]
	cmp	#<$3
	rep	#$20
	longa	on
	beq	*+5
	brl	L10046
;				/* Create FSInfo structure */
;				memset(fs->win, 0, sizeof fs->win);
	pea	#<$200
	pea	#<$0
	lda	#$34
	clc
	adc	<L123+fs_0
	sta	<R0
	lda	#$0
	adc	<L123+fs_0+2
	pha
	pei	<R0
	jsr	_~memset
;				st_32(fs->win + FSI_LeadSig, 0x41615252);		/* Leading signature */
	pea	#^$41615252
	pea	#<$41615252
	lda	#$34
	clc
	adc	<L123+fs_0
	sta	<R0
	lda	#$0
	adc	<L123+fs_0+2
	pha
	pei	<R0
	jsr	_~st_32
;				st_32(fs->win + FSI_StrucSig, 0x61417272);		/* Structure signature */
	pea	#^$61417272
	pea	#<$61417272
	lda	#$218
	clc
	adc	<L123+fs_0
	sta	<R0
	lda	#$0
	adc	<L123+fs_0+2
	pha
	pei	<R0
	jsr	_~st_32
;				st_32(fs->win + FSI_Free_Count, fs->free_clst);	/* Number of free clusters */
	ldy	#$12
	lda	[<L123+fs_0],Y
	pha
	dey
	dey
	lda	[<L123+fs_0],Y
	pha
	lda	#$21c
	clc
	adc	<L123+fs_0
	sta	<R0
	lda	#$0
	adc	<L123+fs_0+2
	pha
	pei	<R0
	jsr	_~st_32
;				st_32(fs->win + FSI_Nxt_Free, fs->last_clst);	/* Last allocated culuster */
	ldy	#$e
	lda	[<L123+fs_0],Y
	pha
	dey
	dey
	lda	[<L123+fs_0],Y
	pha
	lda	#$220
	clc
	adc	<L123+fs_0
	sta	<R0
	lda	#$0
	adc	<L123+fs_0+2
	pha
	pei	<R0
	jsr	_~st_32
;				st_32(fs->win + FSI_TrailSig, 0xAA550000);		/* Trailing signature */
	pea	#^$aa550000
	pea	#<$aa550000
	lda	#$230
	clc
	adc	<L123+fs_0
	sta	<R0
	lda	#$0
	adc	<L123+fs_0+2
	pha
	pei	<R0
	jsr	_~st_32
;				disk_write(fs->pdrv, fs->win, fs->winsect = fs->volbase + 1, 1);	/* Write it into the FSInfo sector (Next to VBR) */
	pea	#<$1
	clc
	lda	#$1
	ldy	#$24
	adc	[<L123+fs_0],Y
	sta	<R0
	lda	#$0
	iny
	iny
	adc	[<L123+fs_0],Y
	sta	<R0+2
	lda	<R0
	ldy	#$20
	sta	[<L123+fs_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L123+fs_0],Y
	pei	<R0+2
	pei	<R0
	lda	#$34
	clc
	adc	<L123+fs_0
	sta	<R1
	lda	#$0
	adc	<L123+fs_0+2
	pha
	pei	<R1
	ldy	#$1
	lda	[<L123+fs_0],Y
	pha
	jsr	_~disk_write
;			}
;#if FF_FS_EXFAT
;			else if (fs->fs_type == FS_EXFAT) {	/* exFAT: Update PercInUse field in BPB */
;				if (disk_read(fs->pdrv, fs->win, fs->winsect = fs->volbase, 1) == RES_OK) {	/* Load VBR */
;					BYTE perc_inuse = (fs->free_clst <= fs->n_fatent - 2) ? (BYTE)((QWORD)(fs->n_fatent - 2 - fs->free_clst) * 100 / (fs->n_fatent - 2)) : 0xFF;	/* Precent in use 0-100 or 0xFF(unknown) */
;
;					if (fs->win[BPB_PercInUseEx] != perc_inuse) {	/* Write it back into VBR if needed */
;						fs->win[BPB_PercInUseEx] = perc_inuse;
;						disk_write(fs->pdrv, fs->win, fs->winsect, 1);
;					}
;				}
;			}
;#endif
;		}
;		/* Make sure that no pending write process in the lower layer */
;		if (disk_ioctl(fs->pdrv, CTRL_SYNC, 0) != RES_OK) res = FR_DISK_ERR;
L10046:
	pea	#^$0
	pea	#<$0
	pea	#<$0
	ldy	#$1
	lda	[<L123+fs_0],Y
	pha
	jsr	_~disk_ioctl
	tax
	beq	L10045
	lda	#$1
	sta	<L124+res_1
;	}
;
;	return res;
L10045:
	lda	<L124+res_1
	tay
	lda	<L123+1
	sta	<L123+1+4
	pld
	tsc
	clc
	adc	#L123+4
	tcs
	tya
	rts
;}
L123	equ	10
L124	equ	9
	ends
	efunc
;
;#endif
;
;
;
;/*-----------------------------------------------------------------------*/
;/* Get physical sector number from cluster number                        */
;/*-----------------------------------------------------------------------*/
;
;static LBA_t clst2sect (	/* !=0:Sector number, 0:Failed (invalid cluster#) */
;	FATFS* fs,		/* Filesystem object */
;	DWORD clst		/* Cluster# to be converted */
;)
;{
	code
	func
_~clst2sect:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L130
	tcs
	phd
	tcd
fs_0	set	3
clst_0	set	7
;	clst -= 2;		/* Cluster number is origin from 2 */
	lda	#$fffe
	clc
	adc	<L130+clst_0
	sta	<L130+clst_0
	lda	#$ffff
	adc	<L130+clst_0+2
	sta	<L130+clst_0+2
;	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
	clc
	lda	#$fffe
	ldy	#$18
	adc	[<L130+fs_0],Y
	sta	<R0
	lda	#$ffff
	iny
	iny
	adc	[<L130+fs_0],Y
	sta	<R0+2
	lda	<L130+clst_0
	cmp	<R0
	lda	<L130+clst_0+2
	sbc	<R0+2
	bcc	L10049
	lda	#$0
	tax
L133:
	tay
	lda	<L130+1
	sta	<L130+1+8
	pld
	tsc
	clc
	adc	#L130+8
	tcs
	tya
	rts
;	return fs->database + (LBA_t)fs->csize * clst;	/* Start sector number of the cluster */
L10049:
	ldy	#$a
	lda	[<L130+fs_0],Y
	sta	<R0
	stz	<R0+2
	pei	<L130+clst_0+2
	pei	<L130+clst_0
	pei	<R0+2
	pei	<R0
	xref	_~~lmul
	jsr	_~~lmul
	sta	<R0
	stx	<R0+2
	clc
	lda	<R0
	ldy	#$30
	adc	[<L130+fs_0],Y
	sta	<R1
	lda	<R0+2
	iny
	iny
	adc	[<L130+fs_0],Y
	sta	<R1+2
	ldx	<R1+2
	lda	<R1
	bra	L133
;}
L130	equ	8
L131	equ	9
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* FAT access - Read value of an FAT entry                               */
;/*-----------------------------------------------------------------------*/
;
;static DWORD get_fat (		/* 0xFFFFFFFF:Disk error, 1:Internal error, 2..0x7FFFFFFF:Cluster status */
;	FFOBJID* obj,	/* Corresponding object */
;	DWORD clst		/* Cluster number to get the value */
;)
;{
	code
	func
_~get_fat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L134
	tcs
	phd
	tcd
obj_0	set	3
clst_0	set	7
;	UINT wc, bc;
;	DWORD val;
;	FATFS *fs = obj->fs;
;
;
;	if (clst < 2 || clst >= fs->n_fatent) {	/* Check if in valid range */
wc_1	set	0
bc_1	set	2
val_1	set	4
fs_1	set	8
	lda	[<L134+obj_0]
	sta	<L135+fs_1
	ldy	#$2
	lda	[<L134+obj_0],Y
	sta	<L135+fs_1+2
	lda	<L134+clst_0
	cmp	#<$2
	lda	<L134+clst_0+2
	sbc	#^$2
	bcc	L136
	lda	<L134+clst_0
	ldy	#$18
	cmp	[<L135+fs_1],Y
	lda	<L134+clst_0+2
	iny
	iny
	sbc	[<L135+fs_1],Y
	bcc	L10050
L136:
;		val = 1;	/* Internal error */
	lda	#$1
	sta	<L135+val_1
	dea
L20004:
	sta	<L135+val_1+2
;
;	} else {
L10051:
;
;	return val;
	ldx	<L135+val_1+2
	lda	<L135+val_1
	tay
	lda	<L134+1
	sta	<L134+1+8
	pld
	tsc
	clc
	adc	#L134+8
	tcs
	tya
	rts
L10050:
;		val = 0xFFFFFFFF;	/* Default value falls on disk error */
	lda	#$ffff
	sta	<L135+val_1
	sta	<L135+val_1+2
;
;		switch (fs->fs_type) {
	lda	[<L135+fs_1]
	and	#$ff
	xref	_~~swt
	jsr	_~~swt
	dw	3
	dw	1
	dw	L10054-1
	dw	2
	dw	L10055-1
	dw	3
	dw	L10056-1
	dw	L136-1
;		case FS_FAT12 :
L10054:
;			bc = (UINT)clst; bc += bc / 2;
	lda	<L134+clst_0
	sta	<L135+bc_1
	lsr	A
	clc
	adc	<L135+bc_1
	sta	<L135+bc_1
;			if (move_window(fs, fs->fatbase + (bc / SS(fs))) != FR_OK) break;
	ldx	#<$9
	xref	_~~lsr
	jsr	_~~lsr
	sta	<R0
	stz	<R0+2
	clc
	lda	<R0
	ldy	#$28
	adc	[<L135+fs_1],Y
	sta	<R1
	lda	<R0+2
	iny
	iny
	adc	[<L135+fs_1],Y
	pha
	pei	<R1
	pei	<L135+fs_1+2
	pei	<L135+fs_1
	jsr	_~move_window
	tax
	bne	L10051
;			wc = fs->win[bc++ % SS(fs)];		/* Get 1st byte of the entry */
	lda	<L135+bc_1
	and	#<$1ff
	clc
	adc	#$34
	tay
	lda	[<L135+fs_1],Y
	and	#$ff
	sta	<L135+wc_1
	inc	<L135+bc_1
;			if (move_window(fs, fs->fatbase + (bc / SS(fs))) != FR_OK) break;
	lda	<L135+bc_1
	ldx	#<$9
	xref	_~~lsr
	jsr	_~~lsr
	sta	<R0
	stz	<R0+2
	clc
	lda	<R0
	ldy	#$28
	adc	[<L135+fs_1],Y
	sta	<R1
	lda	<R0+2
	iny
	iny
	adc	[<L135+fs_1],Y
	pha
	pei	<R1
	pei	<L135+fs_1+2
	pei	<L135+fs_1
	jsr	_~move_window
	tax
	beq	*+5
	brl	L10051
;			wc |= fs->win[bc % SS(fs)] << 8;	/* Merge 2nd byte of the entry */
	lda	<L135+bc_1
	and	#<$1ff
	clc
	adc	#$34
	tay
	lda	[<L135+fs_1],Y
	and	#$ff
	xba
	and	#$ff00
	tsb	<L135+wc_1
;			val = (clst & 1) ? (wc >> 4) : (wc & 0xFFF);	/* Adjust bit position */
	lda	<L134+clst_0
	and	#<$1
	beq	L141
	lda	<L135+wc_1
	lsr	A
	lsr	A
	lsr	A
	lsr	A
	bra	L20009
L141:
	lda	<L135+wc_1
	and	#<$fff
L20009:
	sta	<L135+val_1
	stz	<L135+val_1+2
;			break;
	brl	L10051
;
;		case FS_FAT16 :
L10055:
;			if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 2))) != FR_OK) break;
	pei	<L134+clst_0+2
	pei	<L134+clst_0
	lda	#$8
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R0
	stx	<R0+2
	clc
	lda	<R0
	ldy	#$28
	adc	[<L135+fs_1],Y
	sta	<R1
	lda	<R0+2
	iny
	iny
	adc	[<L135+fs_1],Y
	sta	<R1+2
	pha
	pei	<R1
	pei	<L135+fs_1+2
	pei	<L135+fs_1
	jsr	_~move_window
	tax
	beq	*+5
	brl	L10051
;			val = ld_16(fs->win + clst * 2 % SS(fs));		/* Simple WORD array */
	lda	<L134+clst_0
	sta	<R0
	lda	<L134+clst_0+2
	sta	<R0+2
	asl	<R0
	rol	<R0+2
	lda	<R0
	and	#<$1ff
	sta	<R1
	stz	<R1+2
	lda	#$34
	clc
	adc	<R1
	sta	<R0
	lda	#$0
	adc	<R1+2
	sta	<R0+2
	lda	<L135+fs_1
	clc
	adc	<R0
	sta	<R1
	lda	<L135+fs_1+2
	adc	<R0+2
	pha
	pei	<R1
	jsr	_~ld_16
;			break;
	bra	L20009
;
;		case FS_FAT32 :
L10056:
;			if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 4))) != FR_OK) break;
	pei	<L134+clst_0+2
	pei	<L134+clst_0
	lda	#$7
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R0
	stx	<R0+2
	clc
	lda	<R0
	ldy	#$28
	adc	[<L135+fs_1],Y
	sta	<R1
	lda	<R0+2
	iny
	iny
	adc	[<L135+fs_1],Y
	sta	<R1+2
	pha
	pei	<R1
	pei	<L135+fs_1+2
	pei	<L135+fs_1
	jsr	_~move_window
	tax
	beq	*+5
	brl	L10051
;			val = ld_32(fs->win + clst * 4 % SS(fs)) & 0x0FFFFFFF;	/* Simple DWORD array but mask out upper 4 bits */
	lda	<L134+clst_0
	sta	<R0
	lda	<L134+clst_0+2
	sta	<R0+2
	asl	<R0
	rol	<R0+2
	asl	<R0
	rol	<R0+2
	lda	<R0
	and	#<$1ff
	sta	<R1
	stz	<R1+2
	lda	#$34
	clc
	adc	<R1
	sta	<R0
	lda	#$0
	adc	<R1+2
	sta	<R0+2
	lda	<L135+fs_1
	clc
	adc	<R0
	sta	<R1
	lda	<L135+fs_1+2
	adc	<R0+2
	pha
	pei	<R1
	jsr	_~ld_32
	stx	<R2+2
	sta	<L135+val_1
	lda	<R2+2
	and	#^$fffffff
	brl	L20004
;			break;
;#if FF_FS_EXFAT
;		case FS_EXFAT :
;			if ((obj->objsize != 0 && obj->sclust != 0) || obj->stat == 0) {	/* Object except root dir must have valid data length */
;				DWORD cofs = clst - obj->sclust;	/* Offset from start cluster */
;				DWORD clen = (DWORD)((LBA_t)((obj->objsize - 1) / SS(fs)) / fs->csize);	/* Number of clusters - 1 */
;
;				if (obj->stat == 2 && cofs <= clen) {	/* Is it a contiguous chain? */
;					val = (cofs == clen) ? 0x7FFFFFFF : clst + 1;	/* No data on the FAT, generate the value */
;					break;
;				}
;				if (obj->stat == 3 && cofs < obj->n_cont) {	/* Is it in the 1st fragment? */
;					val = clst + 1; 	/* Generate the value */
;					break;
;				}
;				if (obj->stat != 2) {	/* Get value from FAT if FAT chain is valid */
;					if (obj->n_frag != 0) {	/* Is it on the growing edge? */
;						val = 0x7FFFFFFF;	/* Generate EOC */
;					} else {
;						if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 4))) != FR_OK) break;
;						val = ld_32(fs->win + clst * 4 % SS(fs)) & 0x7FFFFFFF;
;					}
;					break;
;				}
;			}
;			val = 1;	/* Internal error */
;			break;
;#endif
;		default:
;			val = 1;	/* Internal error */
;		}
;	}
;}
L134	equ	24
L135	equ	13
	ends
	efunc
;
;
;
;
;#if !FF_FS_READONLY
;/*-----------------------------------------------------------------------*/
;/* FAT access - Change value of an FAT entry                             */
;/*-----------------------------------------------------------------------*/
;
;static FRESULT put_fat (	/* FR_OK(0):succeeded, !=0:error */
;	FATFS* fs,		/* Corresponding filesystem object */
;	DWORD clst,		/* FAT index number (cluster number) to be changed */
;	DWORD val		/* New value to be set to the entry */
;)
;{
	code
	func
_~put_fat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L147
	tcs
	phd
	tcd
fs_0	set	3
clst_0	set	7
val_0	set	11
;	UINT bc;
;	BYTE *p;
;	FRESULT res = FR_INT_ERR;
;
;
;	if (clst >= 2 && clst < fs->n_fatent) {	/* Check if in valid range */
bc_1	set	0
p_1	set	2
res_1	set	6
	lda	#$2
	sta	<L148+res_1
	lda	<L147+clst_0
	cmp	#<$2
	lda	<L147+clst_0+2
	sbc	#^$2
	bcs	*+5
	brl	L10058
	lda	<L147+clst_0
	ldy	#$18
	cmp	[<L147+fs_0],Y
	lda	<L147+clst_0+2
	iny
	iny
	sbc	[<L147+fs_0],Y
	bcc	*+5
	brl	L10058
;		switch (fs->fs_type) {
	lda	[<L147+fs_0]
	and	#$ff
	xref	_~~swt
	jsr	_~~swt
	dw	3
	dw	1
	dw	L10061-1
	dw	2
	dw	L10062-1
	dw	3
	dw	L10063-1
	dw	L10058-1
;		case FS_FAT12:
L10061:
;			bc = (UINT)clst; bc += bc / 2;	/* bc: byte offset of the entry */
	lda	<L147+clst_0
	sta	<L148+bc_1
	lsr	A
	clc
	adc	<L148+bc_1
	sta	<L148+bc_1
;			res = move_window(fs, fs->fatbase + (bc / SS(fs)));
	ldx	#<$9
	xref	_~~lsr
	jsr	_~~lsr
	sta	<R0
	stz	<R0+2
	clc
	lda	<R0
	ldy	#$28
	adc	[<L147+fs_0],Y
	sta	<R1
	lda	<R0+2
	iny
	iny
	adc	[<L147+fs_0],Y
	pha
	pei	<R1
	pei	<L147+fs_0+2
	pei	<L147+fs_0
	jsr	_~move_window
	sta	<L148+res_1
;			if (res != FR_OK) break;
	lda	<L148+res_1
	beq	*+5
	brl	L10058
;			p = fs->win + bc++ % SS(fs);
	lda	<L148+bc_1
	and	#<$1ff
	sta	<R0
	stz	<R0+2
	lda	#$34
	clc
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	<L147+fs_0
	clc
	adc	<R1
	sta	<L148+p_1
	lda	<L147+fs_0+2
	adc	<R1+2
	sta	<L148+p_1+2
	inc	<L148+bc_1
;			*p = (clst & 1) ? ((*p & 0x0F) | ((BYTE)val << 4)) : (BYTE)val;	/* Update 1st byte */
	lda	<L147+clst_0
	and	#<$1
	beq	L152
	lda	[<L148+p_1]
	and	#<$f
	sta	<R0
	lda	<L147+val_0
	and	#$ff
	asl	A
	asl	A
	asl	A
	asl	A
	ora	<R0
	bra	L154
L152:
	lda	<L147+val_0
	and	#$ff
L154:
	sep	#$20
	longa	off
	sta	[<L148+p_1]
;			fs->wflag = 1;
	lda	#$1
	ldy	#$4
	sta	[<L147+fs_0],Y
	rep	#$20
	longa	on
;			res = move_window(fs, fs->fatbase + (bc / SS(fs)));
	lda	<L148+bc_1
	ldx	#<$9
	xref	_~~lsr
	jsr	_~~lsr
	sta	<R0
	stz	<R0+2
	clc
	lda	<R0
	ldy	#$28
	adc	[<L147+fs_0],Y
	sta	<R1
	lda	<R0+2
	iny
	iny
	adc	[<L147+fs_0],Y
	pha
	pei	<R1
	pei	<L147+fs_0+2
	pei	<L147+fs_0
	jsr	_~move_window
	sta	<L148+res_1
;			if (res != FR_OK) break;
	lda	<L148+res_1
	bne	L10058
;			p = fs->win + bc % SS(fs);
	lda	<L148+bc_1
	and	#<$1ff
	sta	<R0
	stz	<R0+2
	lda	#$34
	clc
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	<L147+fs_0
	clc
	adc	<R1
	sta	<L148+p_1
	lda	<L147+fs_0+2
	adc	<R1+2
	sta	<L148+p_1+2
;			*p = (clst & 1) ? (BYTE)(val >> 4) : ((*p & 0xF0) | ((BYTE)(val >> 8) & 0x0F));	/* Update 2nd byte */
	lda	<L147+clst_0
	and	#<$1
	beq	L156
	lda	<L147+val_0
	sta	<R0
	lda	<L147+val_0+2
	lsr
	sta	<R0+2
	ror	<R0
	lsr	<R0+2
	ror	<R0
	lsr	<R0+2
	ror	<R0
	lsr	<R0+2
	ror	<R0
	lda	<R0
	and	#$ff
	bra	L158
L156:
	pei	<L147+val_0+2
	pei	<L147+val_0
	lda	#$8
	xref	_~~llsr
	jsr	_~~llsr
	stx	<R0+2
	and	#<$f
	sta	<R1
	lda	[<L148+p_1]
	and	#<$f0
	ora	<R1
L158:
	sep	#$20
	longa	off
	sta	[<L148+p_1]
;			fs->wflag = 1;
	lda	#$1
	ldy	#$4
	sta	[<L147+fs_0],Y
	rep	#$20
	longa	on
;			break;
L10058:
	lda	<L148+res_1
	tay
	lda	<L147+1
	sta	<L147+1+12
	pld
	tsc
	clc
	adc	#L147+12
	tcs
	tya
	rts
;
;		case FS_FAT16:
L10062:
;			res = move_window(fs, fs->fatbase + (clst / (SS(fs) / 2)));
	pei	<L147+clst_0+2
	pei	<L147+clst_0
	lda	#$8
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R0
	stx	<R0+2
	clc
	lda	<R0
	ldy	#$28
	adc	[<L147+fs_0],Y
	sta	<R1
	lda	<R0+2
	iny
	iny
	adc	[<L147+fs_0],Y
	sta	<R1+2
	pha
	pei	<R1
	pei	<L147+fs_0+2
	pei	<L147+fs_0
	jsr	_~move_window
	sta	<L148+res_1
;			if (res != FR_OK) break;
	lda	<L148+res_1
	bne	L10058
;			st_16(fs->win + clst * 2 % SS(fs), (WORD)val);	/* Simple WORD array */
	pei	<L147+val_0
	lda	<L147+clst_0
	sta	<R0
	lda	<L147+clst_0+2
	sta	<R0+2
	asl	<R0
	rol	<R0+2
	lda	<R0
	and	#<$1ff
	sta	<R1
	stz	<R1+2
	lda	#$34
	clc
	adc	<R1
	sta	<R0
	lda	#$0
	adc	<R1+2
	sta	<R0+2
	lda	<L147+fs_0
	clc
	adc	<R0
	sta	<R1
	lda	<L147+fs_0+2
	adc	<R0+2
	pha
	pei	<R1
	jsr	_~st_16
;			fs->wflag = 1;
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$4
	sta	[<L147+fs_0],Y
	rep	#$20
	longa	on
;			break;
	brl	L10058
;
;		case FS_FAT32:
L10063:
;#if FF_FS_EXFAT
;		case FS_EXFAT:
;#endif
;			res = move_window(fs, fs->fatbase + (clst / (SS(fs) / 4)));
	pei	<L147+clst_0+2
	pei	<L147+clst_0
	lda	#$7
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R0
	stx	<R0+2
	clc
	lda	<R0
	ldy	#$28
	adc	[<L147+fs_0],Y
	sta	<R1
	lda	<R0+2
	iny
	iny
	adc	[<L147+fs_0],Y
	sta	<R1+2
	pha
	pei	<R1
	pei	<L147+fs_0+2
	pei	<L147+fs_0
	jsr	_~move_window
	sta	<L148+res_1
;			if (res != FR_OK) break;
	lda	<L148+res_1
	beq	*+5
	brl	L10058
;			if (!FF_FS_EXFAT || fs->fs_type != FS_EXFAT) {
;				val = (val & 0x0FFFFFFF) | (ld_32(fs->win + clst * 4 % SS(fs)) & 0xF0000000);
	lda	<L147+clst_0
	sta	<R0
	lda	<L147+clst_0+2
	sta	<R0+2
	asl	<R0
	rol	<R0+2
	asl	<R0
	rol	<R0+2
	lda	<R0
	and	#<$1ff
	sta	<R1
	stz	<R1+2
	lda	#$34
	clc
	adc	<R1
	sta	<R0
	lda	#$0
	adc	<R1+2
	sta	<R0+2
	lda	<L147+fs_0
	clc
	adc	<R0
	sta	<R1
	lda	<L147+fs_0+2
	adc	<R0+2
	sta	<R1+2
	pha
	pei	<R1
	jsr	_~ld_32
	sta	<R2
	stx	<R2+2
	stz	<R3
	lda	<R2+2
	and	#^$f0000000
	sta	<R3+2
	lda	<L147+val_0
	sta	<R2
	lda	<L147+val_0+2
	and	#^$fffffff
	sta	<R2+2
	lda	<R2
	ora	<R3
	sta	<L147+val_0
	lda	<R2+2
	ora	<R3+2
	sta	<L147+val_0+2
;			}
;			st_32(fs->win + clst * 4 % SS(fs), val);
	pha
	pei	<L147+val_0
	lda	<L147+clst_0
	sta	<R0
	lda	<L147+clst_0+2
	sta	<R0+2
	asl	<R0
	rol	<R0+2
	asl	<R0
	rol	<R0+2
	lda	<R0
	and	#<$1ff
	sta	<R1
	stz	<R1+2
	lda	#$34
	clc
	adc	<R1
	sta	<R0
	lda	#$0
	adc	<R1+2
	sta	<R0+2
	lda	<L147+fs_0
	clc
	adc	<R0
	sta	<R1
	lda	<L147+fs_0+2
	adc	<R0+2
	pha
	pei	<R1
	jsr	_~st_32
;			fs->wflag = 1;
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$4
	sta	[<L147+fs_0],Y
	rep	#$20
	longa	on
;			break;
	brl	L10058
;		}
;	}
;	return res;
;}
L147	equ	24
L148	equ	17
	ends
	efunc
;
;#endif /* !FF_FS_READONLY */
;
;
;
;
;#if FF_FS_EXFAT && !FF_FS_READONLY
;/*-----------------------------------------------------------------------*/
;/* exFAT: Accessing FAT and Allocation Bitmap                            */
;/*-----------------------------------------------------------------------*/
;
;/*--------------------------------------*/
;/* Find a contiguous free cluster block */
;/*--------------------------------------*/
;
;static DWORD find_bitmap (	/* 0:Not found, 2..:Cluster block found, 0xFFFFFFFF:Disk error */
;	FATFS* fs,	/* Filesystem object */
;	DWORD clst,	/* Cluster number to scan from */
;	DWORD ncl	/* Number of contiguous clusters to find (1..) */
;)
;{
;	BYTE bm, bv;
;	UINT i;
;	DWORD val, scl, ctr;
;
;
;	clst -= 2;	/* The first bit in the bitmap corresponds to cluster #2 */
;	if (clst >= fs->n_fatent - 2) clst = 0;
;	scl = val = clst; ctr = 0;
;	for (;;) {
;		if (move_window(fs, fs->bitbase + val / 8 / SS(fs)) != FR_OK) return 0xFFFFFFFF;
;		i = val / 8 % SS(fs); bm = 1 << (val % 8);
;		do {
;			do {
;				bv = fs->win[i] & bm; bm <<= 1;		/* Get bit value */
;				if (++val >= fs->n_fatent - 2) {	/* Next cluster (with wrap-around) */
;					val = 0; bm = 0; i = SS(fs);
;				}
;				if (bv == 0) {	/* Is it a free cluster? */
;					if (++ctr == ncl) return scl + 2;	/* Check if run length is sufficient for required */
;				} else {
;					scl = val; ctr = 0;		/* Encountered a cluster in-use, restart to scan */
;				}
;				if (val == clst) return 0;	/* All cluster scanned? */
;			} while (bm != 0);
;			bm = 1;
;		} while (++i < SS(fs));
;	}
;}
;
;
;/*----------------------------------------*/
;/* Set/Clear a block of allocation bitmap */
;/*----------------------------------------*/
;
;static FRESULT change_bitmap (
;	FATFS* fs,	/* Filesystem object */
;	DWORD clst,	/* Cluster number to change from */
;	DWORD ncl,	/* Number of clusters to be changed */
;	int bv		/* bit value to be set (0 or 1) */
;)
;{
;	BYTE bm;
;	UINT i;
;	LBA_t sect;
;
;
;	clst -= 2;	/* The first bit corresponds to cluster #2 */
;	sect = fs->bitbase + clst / 8 / SS(fs);	/* Sector address */
;	i = clst / 8 % SS(fs);					/* Byte offset in the sector */
;	bm = 1 << (clst % 8);					/* Bit mask in the byte */
;	for (;;) {
;		if (move_window(fs, sect++) != FR_OK) return FR_DISK_ERR;
;		do {
;			do {
;				if (bv == (int)((fs->win[i] & bm) != 0)) return FR_INT_ERR;	/* Is the bit expected value? */
;				fs->win[i] ^= bm;	/* Flip the bit */
;				fs->wflag = 1;
;				if (--ncl == 0) return FR_OK;	/* All bits processed? */
;			} while (bm <<= 1);		/* Next bit */
;			bm = 1;
;		} while (++i < SS(fs));		/* Next byte */
;		i = 0;
;	}
;}
;
;
;/*---------------------------------------------*/
;/* Fill the first fragment of the FAT chain    */
;/*---------------------------------------------*/
;
;static FRESULT fill_first_frag (
;	FFOBJID* obj	/* Pointer to the corresponding object */
;)
;{
;	FRESULT res;
;	DWORD cl, n;
;
;
;	if (obj->stat == 3) {	/* Has the object been changed 'fragmented' in this session? */
;		for (cl = obj->sclust, n = obj->n_cont; n; cl++, n--) {	/* Create cluster chain on the FAT */
;			res = put_fat(obj->fs, cl, cl + 1);
;			if (res != FR_OK) return res;
;		}
;		obj->stat = 0;	/* Change status 'FAT chain is valid' */
;	}
;	return FR_OK;
;}
;
;
;/*---------------------------------------------*/
;/* Fill the last fragment of the FAT chain     */
;/*---------------------------------------------*/
;
;static FRESULT fill_last_frag (
;	FFOBJID* obj,	/* Pointer to the corresponding object */
;	DWORD lcl,		/* Last cluster of the fragment */
;	DWORD term		/* Value to set the last FAT entry */
;)
;{
;	FRESULT res;
;
;
;	while (obj->n_frag > 0) {	/* Create the chain of last fragment */
;		res = put_fat(obj->fs, lcl - obj->n_frag + 1, (obj->n_frag > 1) ? lcl - obj->n_frag + 2 : term);
;		if (res != FR_OK) return res;
;		obj->n_frag--;
;	}
;	return FR_OK;
;}
;
;#endif	/* FF_FS_EXFAT && !FF_FS_READONLY */
;
;
;
;#if !FF_FS_READONLY
;/*-----------------------------------------------------------------------*/
;/* FAT handling - Remove a cluster chain                                 */
;/*-----------------------------------------------------------------------*/
;
;static FRESULT remove_chain (	/* FR_OK(0):succeeded, !=0:error */
;	FFOBJID* obj,		/* Corresponding object */
;	DWORD clst,			/* Cluster to remove a chain from */
;	DWORD pclst			/* Previous cluster of clst (0 if entire chain) */
;)
;{
	code
	func
_~remove_chain:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L164
	tcs
	phd
	tcd
obj_0	set	3
clst_0	set	7
pclst_0	set	11
;	FRESULT res = FR_OK;
;	DWORD nxt;
;	FATFS *fs = obj->fs;
;#if FF_FS_EXFAT || FF_USE_TRIM
;	DWORD scl = clst, ecl = clst;
;#endif
;#if FF_USE_TRIM
;	LBA_t rt[2];
;#endif
;
;	if (clst < 2 || clst >= fs->n_fatent) return FR_INT_ERR;	/* Check if in valid range */
res_1	set	0
nxt_1	set	2
fs_1	set	6
	stz	<L165+res_1
	lda	[<L164+obj_0]
	sta	<L165+fs_1
	ldy	#$2
	lda	[<L164+obj_0],Y
	sta	<L165+fs_1+2
	lda	<L164+clst_0
	cmp	#<$2
	lda	<L164+clst_0+2
	sbc	#^$2
	bcc	L166
	lda	<L164+clst_0
	ldy	#$18
	cmp	[<L165+fs_1],Y
	lda	<L164+clst_0+2
	iny
	iny
	sbc	[<L165+fs_1],Y
	bcc	L10065
L166:
	lda	#$2
	brl	L169
;
;	/* Mark the previous cluster 'EOC' on the FAT if it exists */
;	if (pclst != 0 && (!FF_FS_EXFAT || fs->fs_type != FS_EXFAT || obj->stat != 2)) {
L10065:
	lda	<L164+pclst_0
	ora	<L164+pclst_0+2
	bne	*+5
	brl	L10070
;		res = put_fat(fs, pclst, 0xFFFFFFFF);
	pea	#^$ffffffff
	pea	#<$ffffffff
	pei	<L164+pclst_0+2
	pei	<L164+pclst_0
	pei	<L165+fs_1+2
	pei	<L165+fs_1
	jsr	_~put_fat
	sta	<L165+res_1
;		if (res != FR_OK) return res;
	lda	<L165+res_1
	bne	*+5
	brl	L10070
L20011:
	lda	<L165+res_1
	brl	L169
;	}
;
;	/* Remove the chain */
;	do {
L175:
;		if (nxt == 1) return FR_INT_ERR;	/* Internal error? */
	lda	<L165+nxt_1
	cmp	#<$1
	bne	L176
	lda	<L165+nxt_1+2
	cmp	#^$1
L176:
	beq	L166
;		if (nxt == 0xFFFFFFFF) return FR_DISK_ERR;	/* Disk error? */
	lda	<L165+nxt_1
	cmp	#<$ffffffff
	bne	L178
	lda	<L165+nxt_1+2
	cmp	#^$ffffffff
L178:
	bne	L10072
	lda	#$1
	brl	L169
;		if (!FF_FS_EXFAT || fs->fs_type != FS_EXFAT) {
L10072:
;			res = put_fat(fs, clst, 0);		/* Mark the cluster 'free' on the FAT */
	pea	#^$0
	pea	#<$0
	pei	<L164+clst_0+2
	pei	<L164+clst_0
	pei	<L165+fs_1+2
	pei	<L165+fs_1
	jsr	_~put_fat
	sta	<L165+res_1
;			if (res != FR_OK) return res;
	lda	<L165+res_1
	bne	L20011
;		}
;		if (fs->free_clst < fs->n_fatent - 2) {	/* Update allocation information if it is valid */
	clc
	lda	#$fffe
	ldy	#$18
	adc	[<L165+fs_1],Y
	sta	<R0
	lda	#$ffff
	iny
	iny
	adc	[<L165+fs_1],Y
	sta	<R0+2
	ldy	#$10
	lda	[<L165+fs_1],Y
	cmp	<R0
	iny
	iny
	lda	[<L165+fs_1],Y
	sbc	<R0+2
	bcs	L10075
;			fs->free_clst++;
	clc
	lda	#$1
	dey
	dey
	adc	[<L165+fs_1],Y
	sta	[<L165+fs_1],Y
	lda	#$0
	iny
	iny
	adc	[<L165+fs_1],Y
	sta	[<L165+fs_1],Y
;			fs->fsi_flag |= 1;
	lda	#$5
	clc
	adc	<L165+fs_1
	sta	<R0
	lda	#$0
	adc	<L165+fs_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$1
	sta	[<R0]
	rep	#$20
	longa	on
;		}
;#if FF_FS_EXFAT || FF_USE_TRIM
;		if (ecl + 1 == nxt) {	/* Is next cluster contiguous? */
;			ecl = nxt;
;		} else {				/* End of contiguous cluster block */
;#if FF_FS_EXFAT
;			if (fs->fs_type == FS_EXFAT) {
;				res = change_bitmap(fs, scl, ecl - scl + 1, 0);	/* Mark the cluster block 'free' on the bitmap */
;				if (res != FR_OK) return res;
;			}
;#endif
;#if FF_USE_TRIM
;			rt[0] = clst2sect(fs, scl);					/* Start of data area to be freed */
;			rt[1] = clst2sect(fs, ecl) + fs->csize - 1;	/* End of data area to be freed */
;			disk_ioctl(fs->pdrv, CTRL_TRIM, rt);		/* Inform storage device that the data in the block may be erased */
;#endif
;			scl = ecl = nxt;
;		}
;#endif
;		clst = nxt;					/* Next cluster */
L10075:
	lda	<L165+nxt_1
	sta	<L164+clst_0
	lda	<L165+nxt_1+2
	sta	<L164+clst_0+2
;	} while (clst < fs->n_fatent);	/* Repeat until the last link */
	lda	<L164+clst_0
	ldy	#$18
	cmp	[<L165+fs_1],Y
	lda	<L164+clst_0+2
	iny
	iny
	sbc	[<L165+fs_1],Y
	bcs	L10069
L10070:
;		nxt = get_fat(obj, clst);			/* Get cluster status */
	pei	<L164+clst_0+2
	pei	<L164+clst_0
	pei	<L164+obj_0+2
	pei	<L164+obj_0
	jsr	_~get_fat
	sta	<L165+nxt_1
	stx	<L165+nxt_1+2
;		if (nxt == 0) break;				/* Empty cluster? */
	ora	<L165+nxt_1+2
	beq	*+5
	brl	L175
L10069:
;
;#if FF_FS_EXFAT
;	/* Some post processes for chain status */
;	if (fs->fs_type == FS_EXFAT) {
;		if (pclst == 0) {	/* Has the entire chain been removed? */
;			obj->stat = 0;		/* Change the chain status 'initial' */
;		} else {
;			if (obj->stat == 0) {	/* Is it a fragmented chain from the beginning of this session? */
;				clst = obj->sclust;		/* Follow the chain to check if it gets contiguous */
;				while (clst != pclst) {
;					nxt = get_fat(obj, clst);
;					if (nxt < 2) return FR_INT_ERR;
;					if (nxt == 0xFFFFFFFF) return FR_DISK_ERR;
;					if (nxt != clst + 1) break;	/* Not contiguous? */
;					clst++;
;				}
;				if (clst == pclst) {	/* Has the chain got contiguous again? */
;					obj->stat = 2;		/* Change the chain status 'contiguous' */
;				}
;			} else {
;				if (obj->stat == 3 && pclst >= obj->sclust && pclst <= obj->sclust + obj->n_cont) {	/* Was the chain fragmented in this session and got contiguous again? */
;					obj->stat = 2;	/* Change the chain status 'contiguous' */
;				}
;			}
;		}
;	}
;#endif
;	return FR_OK;
	lda	#$0
L169:
	tay
	lda	<L164+1
	sta	<L164+1+12
	pld
	tsc
	clc
	adc	#L164+12
	tcs
	tya
	rts
;}
L164	equ	14
L165	equ	5
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* FAT handling - Stretch a chain or Create a new chain                  */
;/*-----------------------------------------------------------------------*/
;
;static DWORD create_chain (	/* 0:No free cluster, 1:Internal error, 0xFFFFFFFF:Disk error, >=2:New cluster# */
;	FFOBJID* obj,		/* Corresponding object */
;	DWORD clst			/* Cluster# to stretch, 0:Create a new chain */
;)
;{
	code
	func
_~create_chain:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L185
	tcs
	phd
	tcd
obj_0	set	3
clst_0	set	7
;	DWORD cs, ncl, scl;
;	FRESULT res;
;	FATFS *fs = obj->fs;
;
;
;	if (clst == 0) {	/* Create a new chain */
cs_1	set	0
ncl_1	set	4
scl_1	set	8
res_1	set	12
fs_1	set	14
	lda	[<L185+obj_0]
	sta	<L186+fs_1
	ldy	#$2
	lda	[<L185+obj_0],Y
	sta	<L186+fs_1+2
	lda	<L185+clst_0
	ora	<L185+clst_0+2
	bne	L10076
;		scl = fs->last_clst;				/* Suggested cluster to start to find */
	ldy	#$c
	lda	[<L186+fs_1],Y
	sta	<L186+scl_1
	iny
	iny
	lda	[<L186+fs_1],Y
	sta	<L186+scl_1+2
;		if (scl == 0 || scl >= fs->n_fatent) scl = 1;
	lda	<L186+scl_1
	ora	<L186+scl_1+2
	beq	L188
	lda	<L186+scl_1
	ldy	#$18
	cmp	[<L186+fs_1],Y
	lda	<L186+scl_1+2
	iny
	iny
	sbc	[<L186+fs_1],Y
	bcc	L10078
L188:
	lda	#$1
	sta	<L186+scl_1
	dea
	bra	L20012
;	}
;	else {				/* Stretch a chain */
L10076:
;		cs = get_fat(obj, clst);			/* Check the cluster status */
	pei	<L185+clst_0+2
	pei	<L185+clst_0
	pei	<L185+obj_0+2
	pei	<L185+obj_0
	jsr	_~get_fat
	sta	<L186+cs_1
	stx	<L186+cs_1+2
;		if (cs < 2) return 1;				/* Test for insanity */
	cmp	#<$2
	lda	<L186+cs_1+2
	sbc	#^$2
	bcs	L10079
	lda	#$0
	tax
	ina
L192:
	tay
	lda	<L185+1
	sta	<L185+1+8
	pld
	tsc
	clc
	adc	#L185+8
	tcs
	tya
	rts
;		if (cs == 0xFFFFFFFF) return cs;	/* Test for disk error */
L10079:
	lda	<L186+cs_1
	cmp	#<$ffffffff
	bne	L193
	lda	<L186+cs_1+2
	cmp	#^$ffffffff
L193:
	bne	L10080
L20014:
	ldx	<L186+cs_1+2
	lda	<L186+cs_1
	bra	L192
;		if (cs < fs->n_fatent) return cs;	/* It is already followed by next cluster */
L10080:
	lda	<L186+cs_1
	ldy	#$18
	cmp	[<L186+fs_1],Y
	lda	<L186+cs_1+2
	iny
	iny
	sbc	[<L186+fs_1],Y
	bcc	L20014
;		scl = clst;							/* Cluster to start to find */
	lda	<L185+clst_0
	sta	<L186+scl_1
	lda	<L185+clst_0+2
L20012:
	sta	<L186+scl_1+2
;	}
L10078:
;	if (fs->free_clst == 0) return 0;		/* No free cluster */
	ldy	#$10
	lda	[<L186+fs_1],Y
	iny
	iny
	ora	[<L186+fs_1],Y
	bne	L10082
L20019:
	lda	#$0
	tax
	bra	L192
;
;#if FF_FS_EXFAT
;	if (fs->fs_type == FS_EXFAT) {	/* On the exFAT volume */
;		ncl = find_bitmap(fs, scl, 1);				/* Find a free cluster */
;		if (ncl == 0 || ncl == 0xFFFFFFFF) return ncl;	/* No free cluster or hard error? */
;		res = change_bitmap(fs, ncl, 1, 1);			/* Mark the cluster 'in use' */
;		if (res == FR_INT_ERR) return 1;
;		if (res == FR_DISK_ERR) return 0xFFFFFFFF;
;		if (clst == 0) {							/* Is it a new chain? */
;			obj->stat = 2;							/* Set status 'contiguous' */
;		} else {									/* It is a stretched chain */
;			if (obj->stat == 2 && ncl != scl + 1) {	/* Is the chain got fragmented? */
;				obj->n_cont = scl - obj->sclust;	/* Set size of the contiguous part */
;				obj->stat = 3;						/* Change status 'just fragmented' */
;			}
;		}
;		if (obj->stat != 2) {	/* Is the file non-contiguous? */
;			if (ncl == clst + 1) {	/* Is the cluster next to previous one? */
;				obj->n_frag = obj->n_frag ? obj->n_frag + 1 : 2;	/* Increment size of last framgent */
;			} else {				/* New fragment */
;				if (obj->n_frag == 0) obj->n_frag = 1;
;				res = fill_last_frag(obj, clst, ncl);	/* Fill last fragment on the FAT and link it to new one */
;				if (res == FR_OK) obj->n_frag = 1;
;			}
;		}
;	} else
;#endif
;	{	/* On the FAT/FAT32 volume */
L10082:
;		ncl = 0;
	stz	<L186+ncl_1
	stz	<L186+ncl_1+2
;		if (scl == clst) {						/* Stretching an existing chain? */
	lda	<L186+scl_1
	cmp	<L185+clst_0
	bne	L197
	lda	<L186+scl_1+2
	cmp	<L185+clst_0+2
L197:
	beq	*+5
	brl	L10083
;			ncl = scl + 1;						/* Test if next cluster is free */
	lda	#$1
	clc
	adc	<L186+scl_1
	sta	<L186+ncl_1
	lda	#$0
	adc	<L186+scl_1+2
	sta	<L186+ncl_1+2
;			if (ncl >= fs->n_fatent) ncl = 2;
	lda	<L186+ncl_1
	ldy	#$18
	cmp	[<L186+fs_1],Y
	lda	<L186+ncl_1+2
	iny
	iny
	sbc	[<L186+fs_1],Y
	bcc	L10084
	lda	#$2
	sta	<L186+ncl_1
	dea
	dea
	sta	<L186+ncl_1+2
;			cs = get_fat(obj, ncl);				/* Get next cluster status */
L10084:
	pei	<L186+ncl_1+2
	pei	<L186+ncl_1
	pei	<L185+obj_0+2
	pei	<L185+obj_0
	jsr	_~get_fat
	sta	<L186+cs_1
	stx	<L186+cs_1+2
;			if (cs == 1 || cs == 0xFFFFFFFF) return cs;	/* Test for error */
	cmp	#<$1
	bne	L201
	lda	<L186+cs_1+2
	cmp	#^$1
L201:
	bne	*+5
	brl	L20014
	lda	<L186+cs_1
	cmp	#<$ffffffff
	bne	L203
	lda	<L186+cs_1+2
	cmp	#^$ffffffff
L203:
	bne	*+5
	brl	L20014
;			if (cs != 0) {						/* Not free? */
	lda	<L186+cs_1
	ora	<L186+cs_1+2
	beq	L10083
;				cs = fs->last_clst;				/* Start at suggested cluster if it is valid */
	ldy	#$c
	lda	[<L186+fs_1],Y
	sta	<L186+cs_1
	iny
	iny
	lda	[<L186+fs_1],Y
	sta	<L186+cs_1+2
;				if (cs >= 2 && cs < fs->n_fatent) scl = cs;
	lda	<L186+cs_1
	cmp	#<$2
	lda	<L186+cs_1+2
	sbc	#^$2
	bcc	L10087
	lda	<L186+cs_1
	ldy	#$18
	cmp	[<L186+fs_1],Y
	lda	<L186+cs_1+2
	iny
	iny
	sbc	[<L186+fs_1],Y
	bcs	L10087
	lda	<L186+cs_1
	sta	<L186+scl_1
	lda	<L186+cs_1+2
	sta	<L186+scl_1+2
;				ncl = 0;
L10087:
	stz	<L186+ncl_1
	stz	<L186+ncl_1+2
;			}
;		}
;		if (ncl == 0) {	/* The new cluster cannot be contiguous and find another fragment */
L10083:
	lda	<L186+ncl_1
	ora	<L186+ncl_1+2
	bne	L10088
;			ncl = scl;	/* Start cluster */
	lda	<L186+scl_1
	sta	<L186+ncl_1
	lda	<L186+scl_1+2
	sta	<L186+ncl_1+2
;			for (;;) {
L10091:
;				ncl++;							/* Next cluster */
	inc	<L186+ncl_1
	bne	L209
	inc	<L186+ncl_1+2
L209:
;				if (ncl >= fs->n_fatent) {		/* Check wrap-around */
	lda	<L186+ncl_1
	ldy	#$18
	cmp	[<L186+fs_1],Y
	lda	<L186+ncl_1+2
	iny
	iny
	sbc	[<L186+fs_1],Y
	bcc	L10092
;					ncl = 2;
	lda	#$2
	sta	<L186+ncl_1
	dea
	dea
	sta	<L186+ncl_1+2
;					if (ncl > scl) return 0;	/* No free cluster found? */
	lda	<L186+scl_1
	cmp	<L186+ncl_1
	lda	<L186+scl_1+2
	sbc	<L186+ncl_1+2
	bcs	*+5
	brl	L20019
;				}
;				cs = get_fat(obj, ncl);			/* Get the cluster status */
L10092:
	pei	<L186+ncl_1+2
	pei	<L186+ncl_1
	pei	<L185+obj_0+2
	pei	<L185+obj_0
	jsr	_~get_fat
	sta	<L186+cs_1
	stx	<L186+cs_1+2
;				if (cs == 0) break;				/* Found a free cluster? */
	ora	<L186+cs_1+2
	beq	L10088
;				if (cs == 1 || cs == 0xFFFFFFFF) return cs;	/* Test for error */
	lda	<L186+cs_1
	cmp	#<$1
	bne	L214
	lda	<L186+cs_1+2
	cmp	#^$1
L214:
	bne	*+5
	brl	L20014
	lda	<L186+cs_1
	cmp	#<$ffffffff
	bne	L216
	lda	<L186+cs_1+2
	cmp	#^$ffffffff
L216:
	bne	*+5
	brl	L20014
;				if (ncl == scl) return 0;		/* No free cluster found? */
	lda	<L186+ncl_1
	cmp	<L186+scl_1
	bne	L218
	lda	<L186+ncl_1+2
	cmp	<L186+scl_1+2
L218:
	bne	L10091
	brl	L20019
;			}
;		}
;		res = put_fat(fs, ncl, 0xFFFFFFFF);		/* Mark the new cluster 'EOC' */
L10088:
	pea	#^$ffffffff
	pea	#<$ffffffff
	pei	<L186+ncl_1+2
	pei	<L186+ncl_1
	pei	<L186+fs_1+2
	pei	<L186+fs_1
	jsr	_~put_fat
	sta	<L186+res_1
;		if (res == FR_OK && clst != 0) {
	lda	<L186+res_1
	bne	L10096
	lda	<L185+clst_0
	ora	<L185+clst_0+2
	beq	L10096
;			res = put_fat(fs, clst, ncl);		/* Link it from the previous one if needed */
	pei	<L186+ncl_1+2
	pei	<L186+ncl_1
	pei	<L185+clst_0+2
	pei	<L185+clst_0
	pei	<L186+fs_1+2
	pei	<L186+fs_1
	jsr	_~put_fat
	sta	<L186+res_1
;		}
;	}
L10096:
;
;	if (res == FR_OK) {			/* Update allocation information if the function succeeded */
	lda	<L186+res_1
	bne	L10097
;		fs->last_clst = ncl;
	lda	<L186+ncl_1
	ldy	#$c
	sta	[<L186+fs_1],Y
	lda	<L186+ncl_1+2
	iny
	iny
	sta	[<L186+fs_1],Y
;		if (fs->free_clst > 0 && fs->free_clst <= fs->n_fatent - 2) {
	lda	#$0
	iny
	iny
	cmp	[<L186+fs_1],Y
	iny
	iny
	sbc	[<L186+fs_1],Y
	bcs	L10099
	clc
	lda	#$fffe
	ldy	#$18
	adc	[<L186+fs_1],Y
	sta	<R0
	lda	#$ffff
	iny
	iny
	adc	[<L186+fs_1],Y
	sta	<R0+2
	lda	<R0
	ldy	#$10
	cmp	[<L186+fs_1],Y
	lda	<R0+2
	iny
	iny
	sbc	[<L186+fs_1],Y
	bcc	L10099
;			fs->free_clst--;
	clc
	lda	#$ffff
	dey
	dey
	adc	[<L186+fs_1],Y
	sta	[<L186+fs_1],Y
	lda	#$ffff
	iny
	iny
	adc	[<L186+fs_1],Y
	sta	[<L186+fs_1],Y
;			fs->fsi_flag |= 1;
	lda	#$5
	clc
	adc	<L186+fs_1
	sta	<R0
	lda	#$0
	adc	<L186+fs_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$1
	sta	[<R0]
	rep	#$20
	longa	on
;		}
;	} else {
	bra	L10099
L10097:
;		ncl = (res == FR_DISK_ERR) ? 0xFFFFFFFF : 1;	/* Failed. Generate error status */
	lda	<L186+res_1
	cmp	#<$1
	bne	L225
	lda	#$ffff
	tax
	bra	L227
L225:
	lda	#$0
	tax
	ina
L227:
	stx	<R0+2
	sta	<L186+ncl_1
	lda	<R0+2
	sta	<L186+ncl_1+2
;	}
L10099:
;
;	return ncl;		/* Return new cluster number or error status */
	ldx	<L186+ncl_1+2
	lda	<L186+ncl_1
	brl	L192
;}
L185	equ	22
L186	equ	5
	ends
	efunc
;
;#endif /* !FF_FS_READONLY */
;
;
;
;
;#if FF_USE_FASTSEEK
;/*-----------------------------------------------------------------------*/
;/* FAT handling - Convert offset into cluster with link map table        */
;/*-----------------------------------------------------------------------*/
;
;static DWORD clmt_clust (	/* <2:Error, >=2:Cluster number */
;	FIL* fp,		/* Pointer to the file object */
;	FSIZE_t ofs		/* File offset to be converted to cluster# */
;)
;{
	code
	func
_~clmt_clust:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L228
	tcs
	phd
	tcd
fp_0	set	3
ofs_0	set	7
;	DWORD cl, ncl;
;	DWORD *tbl;
;	FATFS *fs = fp->obj.fs;
;
;
;	tbl = fp->cltbl + 1;	/* Top of CLMT */
cl_1	set	0
ncl_1	set	4
tbl_1	set	8
fs_1	set	12
	lda	[<L228+fp_0]
	sta	<L229+fs_1
	ldy	#$2
	lda	[<L228+fp_0],Y
	sta	<L229+fs_1+2
	clc
	lda	#$4
	ldy	#$28
	adc	[<L228+fp_0],Y
	sta	<L229+tbl_1
	lda	#$0
	iny
	iny
	adc	[<L228+fp_0],Y
	sta	<L229+tbl_1+2
;	cl = (DWORD)(ofs / SS(fs) / fs->csize);	/* Cluster order from top of the file */
	ldy	#$a
	lda	[<L229+fs_1],Y
	sta	<R0
	stz	<R0+2
	pei	<L228+ofs_0+2
	pei	<L228+ofs_0
	lda	#$9
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R1
	stx	<R1+2
	pei	<R0+2
	pei	<R0
	pei	<R1+2
	pei	<R1
	xref	_~~ludv
	jsr	_~~ludv
	sta	<L229+cl_1
	stx	<L229+cl_1+2
;	for (;;) {
L10102:
;		ncl = *tbl++;			/* Number of cluters in the fragment */
	lda	[<L229+tbl_1]
	sta	<L229+ncl_1
	ldy	#$2
	lda	[<L229+tbl_1],Y
	sta	<L229+ncl_1+2
	lda	#$4
	clc
	adc	<L229+tbl_1
	sta	<L229+tbl_1
	bcc	L230
	inc	<L229+tbl_1+2
L230:
;		if (ncl == 0) return 0;	/* End of table? (error) */
	lda	<L229+ncl_1
	ora	<L229+ncl_1+2
	bne	L10103
	lda	#$0
	tax
L232:
	tay
	lda	<L228+1
	sta	<L228+1+8
	pld
	tsc
	clc
	adc	#L228+8
	tcs
	tya
	rts
;		if (cl < ncl) break;	/* In this fragment? */
L10103:
	lda	<L229+cl_1
	cmp	<L229+ncl_1
	lda	<L229+cl_1+2
	sbc	<L229+ncl_1+2
	bcc	L10101
;		cl -= ncl; tbl++;		/* Next fragment */
	sec
	lda	<L229+cl_1
	sbc	<L229+ncl_1
	sta	<L229+cl_1
	lda	<L229+cl_1+2
	sbc	<L229+ncl_1+2
	sta	<L229+cl_1+2
	lda	#$4
	clc
	adc	<L229+tbl_1
	sta	<L229+tbl_1
	bcc	L10102
	inc	<L229+tbl_1+2
;	}
	bra	L10102
L10101:
;	return cl + *tbl;	/* Return the cluster number */
	lda	<L229+cl_1
	clc
	adc	[<L229+tbl_1]
	sta	<R0
	lda	<L229+cl_1+2
	ldy	#$2
	adc	[<L229+tbl_1],Y
	sta	<R0+2
	ldx	<R0+2
	lda	<R0
	bra	L232
;}
L228	equ	24
L229	equ	9
	ends
	efunc
;
;#endif	/* FF_USE_FASTSEEK */
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* Directory handling - Fill a cluster with zeros                        */
;/*-----------------------------------------------------------------------*/
;
;#if !FF_FS_READONLY
;static FRESULT dir_clear (	/* Returns FR_OK or FR_DISK_ERR */
;	FATFS *fs,		/* Filesystem object */
;	DWORD clst		/* Directory table to clear */
;)
;{
	code
	func
_~dir_clear:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L235
	tcs
	phd
	tcd
fs_0	set	3
clst_0	set	7
;	LBA_t sect;
;	UINT n, szb;
;	BYTE *ibuf;
;
;
;	if (sync_window(fs) != FR_OK) return FR_DISK_ERR;	/* Flush disk access window */
sect_1	set	0
n_1	set	4
szb_1	set	6
ibuf_1	set	8
	pei	<L235+fs_0+2
	pei	<L235+fs_0
	jsr	_~sync_window
	tax
	beq	L10104
L20022:
	lda	#$1
L238:
	tay
	lda	<L235+1
	sta	<L235+1+8
	pld
	tsc
	clc
	adc	#L235+8
	tcs
	tya
	rts
;	sect = clst2sect(fs, clst);		/* Top of the cluster */
L10104:
	pei	<L235+clst_0+2
	pei	<L235+clst_0
	pei	<L235+fs_0+2
	pei	<L235+fs_0
	jsr	_~clst2sect
	sta	<L236+sect_1
	stx	<L236+sect_1+2
;	fs->winsect = sect;				/* Set window to top of the cluster */
	ldy	#$20
	sta	[<L235+fs_0],Y
	lda	<L236+sect_1+2
	iny
	iny
	sta	[<L235+fs_0],Y
;	memset(fs->win, 0, sizeof fs->win);	/* Clear window buffer */
	pea	#<$200
	pea	#<$0
	lda	#$34
	clc
	adc	<L235+fs_0
	sta	<R0
	lda	#$0
	adc	<L235+fs_0+2
	pha
	pei	<R0
	jsr	_~memset
;#if FF_USE_LFN == 3		/* Quick table clear by using multi-secter write */
;	/* Allocate a temporary buffer */
;	for (szb = ((DWORD)fs->csize * SS(fs) >= MAX_MALLOC) ? MAX_MALLOC : fs->csize * SS(fs), ibuf = 0; szb > SS(fs) && (ibuf = ff_memalloc(szb)) == 0; szb /= 2) ;
;	if (szb > SS(fs)) {		/* Buffer allocated? */
;		memset(ibuf, 0, szb);
;		szb /= SS(fs);		/* Bytes -> Sectors */
;		for (n = 0; n < fs->csize && disk_write(fs->pdrv, ibuf, sect + n, szb) == RES_OK; n += szb) ;	/* Fill the cluster with 0 */
;		ff_memfree(ibuf);
;	} else
;#endif
;	{
;		ibuf = fs->win; szb = 1;	/* Use window buffer (many single-sector writes may take a time) */
	lda	#$34
	clc
	adc	<L235+fs_0
	sta	<L236+ibuf_1
	lda	#$0
	adc	<L235+fs_0+2
	sta	<L236+ibuf_1+2
	lda	#$1
	sta	<L236+szb_1
;		for (n = 0; n < fs->csize && disk_write(fs->pdrv, ibuf, sect + n, szb) == RES_OK; n += szb) ;	/* Fill the cluster with 0 */
	stz	<L236+n_1
	bra	L10108
L10105:
	lda	<L236+n_1
	clc
	adc	<L236+szb_1
	sta	<L236+n_1
L10108:
	lda	<L236+n_1
	ldy	#$a
	cmp	[<L235+fs_0],Y
	bcs	L10106
	pei	<L236+szb_1
	lda	<L236+n_1
	sta	<R0
	stz	<R0+2
	lda	<R0
	clc
	adc	<L236+sect_1
	sta	<R1
	lda	<R0+2
	adc	<L236+sect_1+2
	pha
	pei	<R1
	pei	<L236+ibuf_1+2
	pei	<L236+ibuf_1
	ldy	#$1
	lda	[<L235+fs_0],Y
	pha
	jsr	_~disk_write
	tax
	beq	L10105
L10106:
;	}
;	return (n == fs->csize) ? FR_OK : FR_DISK_ERR;
	lda	<L236+n_1
	ldy	#$a
	cmp	[<L235+fs_0],Y
	beq	*+5
	brl	L20022
	lda	#$0
	brl	L238
;}
L235	equ	20
L236	equ	9
	ends
	efunc
;#endif	/* !FF_FS_READONLY */
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* Directory handling - Set directory index                              */
;/*-----------------------------------------------------------------------*/
;
;static FRESULT dir_sdi (	/* FR_OK(0):succeeded, !=0:error */
;	DIR* dp,		/* Pointer to directory object */
;	DWORD ofs		/* Offset of directory table */
;)
;{
	code
	func
_~dir_sdi:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L245
	tcs
	phd
	tcd
dp_0	set	3
ofs_0	set	7
;	DWORD csz, clst;
;	FATFS *fs = dp->obj.fs;
;
;
;	if (ofs >= (DWORD)((FF_FS_EXFAT && fs->fs_type == FS_EXFAT) ? MAX_DIR_EX : MAX_DIR) || ofs % SZDIRE) {	/* Check range of offset and alignment */
csz_1	set	0
clst_1	set	4
fs_1	set	8
	lda	[<L245+dp_0]
	sta	<L246+fs_1
	ldy	#$2
	lda	[<L245+dp_0],Y
	sta	<L246+fs_1+2
	lda	#$20
	tax
	lda	#$0
	sta	<R0
	stx	<R0+2
	lda	<L245+ofs_0
	cmp	<R0
	lda	<L245+ofs_0+2
	sbc	<R0+2
	bcs	L247
	lda	<L245+ofs_0
	and	#<$1f
	beq	L10109
L247:
;		return FR_INT_ERR;
	lda	#$2
L253:
	tay
	lda	<L245+1
	sta	<L245+1+8
	pld
	tsc
	clc
	adc	#L245+8
	tcs
	tya
	rts
;	}
;	dp->dptr = ofs;				/* Set current offset */
L10109:
	lda	<L245+ofs_0
	ldy	#$12
	sta	[<L245+dp_0],Y
	lda	<L245+ofs_0+2
	iny
	iny
	sta	[<L245+dp_0],Y
;	clst = dp->obj.sclust;		/* Table start cluster (0:root) */
	ldy	#$8
	lda	[<L245+dp_0],Y
	sta	<L246+clst_1
	iny
	iny
	lda	[<L245+dp_0],Y
	sta	<L246+clst_1+2
;	if (clst == 0 && fs->fs_type >= FS_FAT32) {	/* Replace cluster# 0 with root cluster# */
	lda	<L246+clst_1
	ora	<L246+clst_1+2
	bne	L10110
	sep	#$20
	longa	off
	lda	[<L246+fs_1]
	cmp	#<$3
	rep	#$20
	longa	on
	bcc	L10110
;		clst = (DWORD)fs->dirbase;
	ldy	#$2c
	lda	[<L246+fs_1],Y
	sta	<L246+clst_1
	iny
	iny
	lda	[<L246+fs_1],Y
	sta	<L246+clst_1+2
;		if (FF_FS_EXFAT) dp->obj.stat = 0;	/* exFAT: Root dir has an FAT chain */
;	}
;
;	if (clst == 0) {	/* Static table (root-directory on the FAT volume) */
L10110:
	lda	<L246+clst_1
	ora	<L246+clst_1+2
	bne	L10112
;		if (ofs / SZDIRE >= fs->n_rootdir) return FR_INT_ERR;	/* Is index out of range? */
	ldy	#$8
	lda	[<L246+fs_1],Y
	sta	<R0
	stz	<R0+2
	pei	<L245+ofs_0+2
	pei	<L245+ofs_0
	lda	#$5
	xref	_~~llsr
	jsr	_~~llsr
	stx	<R1+2
	cmp	<R0
	lda	<R1+2
	sbc	<R0+2
	bcs	L247
;		dp->sect = fs->dirbase;
	ldy	#$2c
	lda	[<L246+fs_1],Y
	ldy	#$1a
	sta	[<L245+dp_0],Y
	ldy	#$2e
	lda	[<L246+fs_1],Y
	brl	L20026
;
;	} else {			/* Dynamic table (sub-directory or root-directory on the FAT32/exFAT volume) */
L10112:
;		csz = (DWORD)fs->csize * SS(fs);	/* Bytes per cluster */
	ldy	#$a
	lda	[<L246+fs_1],Y
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$9
	xref	_~~lasl
	jsr	_~~lasl
	sta	<L246+csz_1
	stx	<L246+csz_1+2
;		while (ofs >= csz) {				/* Follow cluster chain */
	bra	L10115
L20025:
;			clst = get_fat(&dp->obj, clst);				/* Get next cluster */
	pei	<L246+clst_1+2
	pei	<L246+clst_1
	pei	<L245+dp_0+2
	pei	<L245+dp_0
	jsr	_~get_fat
	sta	<L246+clst_1
	stx	<L246+clst_1+2
;			if (clst == 0xFFFFFFFF) return FR_DISK_ERR;	/* Disk error */
	cmp	#<$ffffffff
	bne	L259
	lda	<L246+clst_1+2
	cmp	#^$ffffffff
L259:
	bne	L10117
	lda	#$1
	brl	L253
;			if (clst < 2 || clst >= fs->n_fatent) return FR_INT_ERR;	/* Reached to end of table or internal error */
L10117:
	lda	<L246+clst_1
	cmp	#<$2
	lda	<L246+clst_1+2
	sbc	#^$2
	bcs	*+5
	brl	L247
	lda	<L246+clst_1
	ldy	#$18
	cmp	[<L246+fs_1],Y
	lda	<L246+clst_1+2
	iny
	iny
	sbc	[<L246+fs_1],Y
	bcc	*+5
	brl	L247
;			ofs -= csz;
	sec
	lda	<L245+ofs_0
	sbc	<L246+csz_1
	sta	<L245+ofs_0
	lda	<L245+ofs_0+2
	sbc	<L246+csz_1+2
	sta	<L245+ofs_0+2
;		}
L10115:
	lda	<L245+ofs_0
	cmp	<L246+csz_1
	lda	<L245+ofs_0+2
	sbc	<L246+csz_1+2
	bcs	L20025
;		dp->sect = clst2sect(fs, clst);
	pei	<L246+clst_1+2
	pei	<L246+clst_1
	pei	<L246+fs_1+2
	pei	<L246+fs_1
	jsr	_~clst2sect
	stx	<R0+2
	ldy	#$1a
	sta	[<L245+dp_0],Y
	lda	<R0+2
L20026:
	ldy	#$1c
	sta	[<L245+dp_0],Y
;	}
;	dp->clust = clst;					/* Current cluster# */
	lda	<L246+clst_1
	ldy	#$16
	sta	[<L245+dp_0],Y
	lda	<L246+clst_1+2
	iny
	iny
	sta	[<L245+dp_0],Y
;	if (dp->sect == 0) return FR_INT_ERR;
	iny
	iny
	lda	[<L245+dp_0],Y
	iny
	iny
	ora	[<L245+dp_0],Y
	bne	*+5
	brl	L247
;	dp->sect += ofs / SS(fs);			/* Sector# of the directory entry */
	lda	#$1a
	clc
	adc	<L245+dp_0
	sta	<R0
	lda	#$0
	adc	<L245+dp_0+2
	sta	<R0+2
	pei	<L245+ofs_0+2
	pei	<L245+ofs_0
	lda	#$9
	xref	_~~llsr
	jsr	_~~llsr
	stx	<R1+2
	clc
	adc	[<R0]
	sta	[<R0]
	lda	<R1+2
	ldy	#$2
	adc	[<R0],Y
	sta	[<R0],Y
;	dp->dir = fs->win + (ofs % SS(fs));	/* Pointer to the entry in the win[] */
	lda	<L245+ofs_0
	and	#<$1ff
	sta	<R0
	stz	<R0+2
	lda	#$34
	clc
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	<L246+fs_1
	clc
	adc	<R1
	sta	<R0
	lda	<L246+fs_1+2
	adc	<R1+2
	sta	<R0+2
	lda	<R0
	ldy	#$1e
	sta	[<L245+dp_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L245+dp_0],Y
;
;	return FR_OK;
	lda	#$0
	brl	L253
;}
L245	equ	20
L246	equ	9
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* Directory handling - Move directory table index next                  */
;/*-----------------------------------------------------------------------*/
;
;static FRESULT dir_next (	/* FR_OK(0):succeeded, FR_NO_FILE:End of table, FR_DENIED:Could not stretch */
;	DIR* dp,				/* Pointer to the directory object */
;	int stretch				/* 0: Do not stretch table, 1: Stretch table if needed */
;)
;{
	code
	func
_~dir_next:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L265
	tcs
	phd
	tcd
dp_0	set	3
stretch_0	set	7
;	DWORD ofs, clst;
;	FATFS *fs = dp->obj.fs;
;
;
;	ofs = dp->dptr + SZDIRE;	/* Next entry */
ofs_1	set	0
clst_1	set	4
fs_1	set	8
	lda	[<L265+dp_0]
	sta	<L266+fs_1
	ldy	#$2
	lda	[<L265+dp_0],Y
	sta	<L266+fs_1+2
	clc
	lda	#$20
	ldy	#$12
	adc	[<L265+dp_0],Y
	sta	<L266+ofs_1
	lda	#$0
	iny
	iny
	adc	[<L265+dp_0],Y
	sta	<L266+ofs_1+2
;	if (ofs >= (DWORD)((FF_FS_EXFAT && fs->fs_type == FS_EXFAT) ? MAX_DIR_EX : MAX_DIR)) dp->sect = 0;	/* Disable it if the offset reached the max value */
	lda	#$20
	tax
	lda	#$0
	sta	<R0
	stx	<R0+2
	lda	<L266+ofs_1
	cmp	<R0
	lda	<L266+ofs_1+2
	sbc	<R0+2
	bcc	L10120
	lda	#$0
	ldy	#$1a
	sta	[<L265+dp_0],Y
	iny
	iny
	sta	[<L265+dp_0],Y
;	if (dp->sect == 0) return FR_NO_FILE;	/* Report EOT if it has been disabled */
L10120:
	ldy	#$1a
	lda	[<L265+dp_0],Y
	iny
	iny
	ora	[<L265+dp_0],Y
	bne	L10121
L20027:
	lda	#$4
L272:
	tay
	lda	<L265+1
	sta	<L265+1+6
	pld
	tsc
	clc
	adc	#L265+6
	tcs
	tya
	rts
;
;	if (ofs % SS(fs) == 0) {	/* Sector changed? */
L10121:
	lda	<L266+ofs_1
	and	#<$1ff
	beq	*+5
	brl	L10122
;		dp->sect++;				/* Next sector */
	clc
	lda	#$1
	ldy	#$1a
	adc	[<L265+dp_0],Y
	sta	[<L265+dp_0],Y
	lda	#$0
	iny
	iny
	adc	[<L265+dp_0],Y
	sta	[<L265+dp_0],Y
;
;		if (dp->clust == 0) {	/* Static table */
	ldy	#$16
	lda	[<L265+dp_0],Y
	iny
	iny
	ora	[<L265+dp_0],Y
	bne	L10123
;			if (ofs / SZDIRE >= fs->n_rootdir) {	/* Report EOT if it reached end of static table */
	ldy	#$8
	lda	[<L266+fs_1],Y
	sta	<R0
	stz	<R0+2
	pei	<L266+ofs_1+2
	pei	<L266+ofs_1
	lda	#$5
	xref	_~~llsr
	jsr	_~~llsr
	stx	<R1+2
	cmp	<R0
	lda	<R1+2
	sbc	<R0+2
	bcs	*+5
	brl	L10122
;				dp->sect = 0; return FR_NO_FILE;
L20033:
	lda	#$0
	ldy	#$1a
	sta	[<L265+dp_0],Y
	iny
	iny
	sta	[<L265+dp_0],Y
	bra	L20027
;			}
;		}
;		else {					/* Dynamic table */
L10123:
;			if ((ofs / SS(fs) & (fs->csize - 1)) == 0) {	/* Cluster changed? */
	pei	<L266+ofs_1+2
	pei	<L266+ofs_1
	lda	#$9
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R0
	stx	<R0+2
	clc
	lda	#$ffff
	ldy	#$a
	adc	[<L266+fs_1],Y
	sta	<R1
	stz	<R1+2
	lda	<R1
	and	<R0
	sta	<R2
	lda	<R1+2
	and	<R0+2
	sta	<R2+2
	lda	<R2
	ora	<R2+2
	beq	*+5
	brl	L10122
;				clst = get_fat(&dp->obj, dp->clust);		/* Get next cluster */
	ldy	#$18
	lda	[<L265+dp_0],Y
	pha
	dey
	dey
	lda	[<L265+dp_0],Y
	pha
	pei	<L265+dp_0+2
	pei	<L265+dp_0
	jsr	_~get_fat
	sta	<L266+clst_1
	stx	<L266+clst_1+2
;				if (clst <= 1) return FR_INT_ERR;			/* Internal error */
	lda	#$1
	cmp	<L266+clst_1
	dea
	sbc	<L266+clst_1+2
	bcc	L10127
L20034:
	lda	#$2
	brl	L272
;				if (clst == 0xFFFFFFFF) return FR_DISK_ERR;	/* Disk error */
L10127:
	lda	<L266+clst_1
	cmp	#<$ffffffff
	bne	L278
	lda	<L266+clst_1+2
	cmp	#^$ffffffff
L278:
	bne	L10128
L20035:
	lda	#$1
	brl	L272
;				if (clst >= fs->n_fatent) {					/* It reached end of dynamic table */
L10128:
	lda	<L266+clst_1
	ldy	#$18
	cmp	[<L266+fs_1],Y
	lda	<L266+clst_1+2
	iny
	iny
	sbc	[<L266+fs_1],Y
	bcc	L10129
;#if !FF_FS_READONLY
;					if (!stretch) {								/* If no stretch, report EOT */
	lda	<L265+stretch_0
	bne	*+5
	brl	L20033
;						dp->sect = 0; return FR_NO_FILE;
;					}
;					clst = create_chain(&dp->obj, dp->clust);	/* Allocate a cluster */
	dey
	dey
	lda	[<L265+dp_0],Y
	pha
	dey
	dey
	lda	[<L265+dp_0],Y
	pha
	pei	<L265+dp_0+2
	pei	<L265+dp_0
	jsr	_~create_chain
	sta	<L266+clst_1
	stx	<L266+clst_1+2
;					if (clst == 0) return FR_DENIED;			/* No free cluster */
	ora	<L266+clst_1+2
	bne	L10131
	lda	#$7
	brl	L272
;					if (clst == 1) return FR_INT_ERR;			/* Internal error */
L10131:
	lda	<L266+clst_1
	cmp	#<$1
	bne	L283
	lda	<L266+clst_1+2
	cmp	#^$1
L283:
	beq	L20034
;					if (clst == 0xFFFFFFFF) return FR_DISK_ERR;	/* Disk error */
	lda	<L266+clst_1
	cmp	#<$ffffffff
	bne	L285
	lda	<L266+clst_1+2
	cmp	#^$ffffffff
L285:
	beq	L20035
;					if (dir_clear(fs, clst) != FR_OK) return FR_DISK_ERR;	/* Clean up the stretched table */
	pei	<L266+clst_1+2
	pei	<L266+clst_1
	pei	<L266+fs_1+2
	pei	<L266+fs_1
	jsr	_~dir_clear
	tax
	bne	L20035
;					if (FF_FS_EXFAT) dp->obj.stat |= 4;			/* exFAT: The directory has been stretched */
;#else
;					if (!stretch) dp->sect = 0;					/* (this line is to suppress compiler warning) */
;					dp->sect = 0; return FR_NO_FILE;			/* Report EOT */
;#endif
;				}
;				dp->clust = clst;		/* Initialize data for new cluster */
L10129:
	lda	<L266+clst_1
	ldy	#$16
	sta	[<L265+dp_0],Y
	lda	<L266+clst_1+2
	iny
	iny
	sta	[<L265+dp_0],Y
;				dp->sect = clst2sect(fs, clst);
	pei	<L266+clst_1+2
	pei	<L266+clst_1
	pei	<L266+fs_1+2
	pei	<L266+fs_1
	jsr	_~clst2sect
	stx	<R0+2
	ldy	#$1a
	sta	[<L265+dp_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L265+dp_0],Y
;			}
;		}
;	}
;	dp->dptr = ofs;						/* Current entry */
L10122:
	lda	<L266+ofs_1
	ldy	#$12
	sta	[<L265+dp_0],Y
	lda	<L266+ofs_1+2
	iny
	iny
	sta	[<L265+dp_0],Y
;	dp->dir = fs->win + ofs % SS(fs);	/* Pointer to the entry in the win[] */
	lda	<L266+ofs_1
	and	#<$1ff
	sta	<R0
	stz	<R0+2
	lda	#$34
	clc
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	<L266+fs_1
	clc
	adc	<R1
	sta	<R0
	lda	<L266+fs_1+2
	adc	<R1+2
	sta	<R0+2
	lda	<R0
	ldy	#$1e
	sta	[<L265+dp_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L265+dp_0],Y
;
;	return FR_OK;
	lda	#$0
	brl	L272
;}
L265	equ	24
L266	equ	13
	ends
	efunc
;
;
;
;
;#if !FF_FS_READONLY
;/*-----------------------------------------------------------------------*/
;/* Directory handling - Reserve a block of directory entries             */
;/*-----------------------------------------------------------------------*/
;
;static FRESULT dir_alloc (	/* FR_OK(0):succeeded, !=0:error */
;	DIR* dp,				/* Pointer to the directory object */
;	UINT n_ent				/* Number of contiguous entries to allocate */
;)
;{
	code
	func
_~dir_alloc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L288
	tcs
	phd
	tcd
dp_0	set	3
n_ent_0	set	7
;	FRESULT res;
;	UINT n;
;	FATFS *fs = dp->obj.fs;
;
;
;	res = dir_sdi(dp, 0);
res_1	set	0
n_1	set	2
fs_1	set	4
	lda	[<L288+dp_0]
	sta	<L289+fs_1
	ldy	#$2
	lda	[<L288+dp_0],Y
	sta	<L289+fs_1+2
	pea	#^$0
	pea	#<$0
	pei	<L288+dp_0+2
	pei	<L288+dp_0
	jsr	_~dir_sdi
	sta	<L289+res_1
;	if (res == FR_OK) {
	lda	<L289+res_1
	bne	L10136
;		n = 0;
	stz	<L289+n_1
;		do {
L10139:
;			res = move_window(fs, dp->sect);
	ldy	#$1c
	lda	[<L288+dp_0],Y
	pha
	dey
	dey
	lda	[<L288+dp_0],Y
	pha
	pei	<L289+fs_1+2
	pei	<L289+fs_1
	jsr	_~move_window
	sta	<L289+res_1
;			if (res != FR_OK) break;
	lda	<L289+res_1
	bne	L10136
;#if FF_FS_EXFAT
;			if ((fs->fs_type == FS_EXFAT) ? (int)((dp->dir[XDIR_Type] & 0x80) == 0) : (int)(dp->dir[DIR_Name] == DDEM || dp->dir[DIR_Name] == 0)) {	/* Is the entry free? */
;#else
;			if (dp->dir[DIR_Name] == DDEM || dp->dir[DIR_Name] == 0) {	/* Is the entry free? */
	ldy	#$1e
	lda	[<L288+dp_0],Y
	sta	<R0
	iny
	iny
	lda	[<L288+dp_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$e5
	rep	#$20
	longa	on
	beq	L292
	dey
	dey
	lda	[<L288+dp_0],Y
	sta	<R0
	iny
	iny
	lda	[<L288+dp_0],Y
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	bne	L10140
L292:
;#endif
;				if (++n == n_ent) break;	/* Is a block of contiguous free entries found? */
	inc	<L289+n_1
	lda	<L289+n_1
	cmp	<L288+n_ent_0
	bne	L10141
L10136:
	lda	<L289+res_1
	cmp	#<$4
	beq	L297
	bra	L10142
;			} else {
L10140:
;				n = 0;				/* Not a free entry, restart to search */
	stz	<L289+n_1
;			}
L10141:
;			res = dir_next(dp, 1);	/* Next entry with table stretch enabled */
	pea	#<$1
	pei	<L288+dp_0+2
	pei	<L288+dp_0
	jsr	_~dir_next
	sta	<L289+res_1
;		} while (res == FR_OK);
	lda	<L289+res_1
	bne	L10136
	bra	L10139
;	}
;
;	if (res == FR_NO_FILE) res = FR_DENIED;	/* No directory entry to allocate */
L297:
	lda	#$7
	sta	<L289+res_1
;	return res;
L10142:
	lda	<L289+res_1
	tay
	lda	<L288+1
	sta	<L288+1+6
	pld
	tsc
	clc
	adc	#L288+6
	tcs
	tya
	rts
;}
L288	equ	12
L289	equ	5
	ends
	efunc
;
;#endif	/* !FF_FS_READONLY */
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* FAT: Directory handling - Load/Store start cluster number             */
;/*-----------------------------------------------------------------------*/
;
;static DWORD ld_clust (	/* Returns the top cluster value of the SFN entry */
;	FATFS* fs,			/* Pointer to the fs object */
;	const BYTE* dir		/* Pointer to the key entry */
;)
;{
	code
	func
_~ld_clust:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L299
	tcs
	phd
	tcd
fs_0	set	3
dir_0	set	7
;	DWORD cl;
;
;	cl = ld_16(dir + DIR_FstClusLO);
cl_1	set	0
	lda	#$1a
	clc
	adc	<L299+dir_0
	sta	<R0
	lda	#$0
	adc	<L299+dir_0+2
	sta	<R0+2
	pha
	pei	<R0
	jsr	_~ld_16
	sta	<L300+cl_1
	stz	<L300+cl_1+2
;	if (fs->fs_type == FS_FAT32) {
	sep	#$20
	longa	off
	lda	[<L299+fs_0]
	cmp	#<$3
	rep	#$20
	longa	on
	bne	L10143
;		cl |= (DWORD)ld_16(dir + DIR_FstClusHI) << 16;
	lda	#$14
	clc
	adc	<L299+dir_0
	sta	<R1
	lda	#$0
	adc	<L299+dir_0+2
	pha
	pei	<R1
	jsr	_~ld_16
	sta	<R2
	stz	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$10
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L300+cl_1
	ora	<R0
	sta	<L300+cl_1
	lda	<L300+cl_1+2
	ora	<R0+2
	sta	<L300+cl_1+2
;	}
;
;	return cl;
L10143:
	ldx	<L300+cl_1+2
	lda	<L300+cl_1
	tay
	lda	<L299+1
	sta	<L299+1+8
	pld
	tsc
	clc
	adc	#L299+8
	tcs
	tya
	rts
;}
L299	equ	16
L300	equ	13
	ends
	efunc
;
;
;#if !FF_FS_READONLY
;static void st_clust (
;	FATFS* fs,	/* Pointer to the fs object */
;	BYTE* dir,	/* Pointer to the key entry */
;	DWORD cl	/* Value to be set */
;)
;{
	code
	func
_~st_clust:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L303
	tcs
	phd
	tcd
fs_0	set	3
dir_0	set	7
cl_0	set	11
;	st_16(dir + DIR_FstClusLO, (WORD)cl);
	pei	<L303+cl_0
	lda	#$1a
	clc
	adc	<L303+dir_0
	sta	<R0
	lda	#$0
	adc	<L303+dir_0+2
	sta	<R0+2
	pha
	pei	<R0
	jsr	_~st_16
;	if (fs->fs_type == FS_FAT32) {
	sep	#$20
	longa	off
	lda	[<L303+fs_0]
	cmp	#<$3
	rep	#$20
	longa	on
	bne	L306
;		st_16(dir + DIR_FstClusHI, (WORD)(cl >> 16));
	pei	<L303+cl_0+2
	pei	<L303+cl_0
	lda	#$10
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R0
	stx	<R0+2
	pei	<R0
	lda	#$14
	clc
	adc	<L303+dir_0
	sta	<R1
	lda	#$0
	adc	<L303+dir_0+2
	pha
	pei	<R1
	jsr	_~st_16
;	}
;}
L306:
	lda	<L303+1
	sta	<L303+1+12
	pld
	tsc
	clc
	adc	#L303+12
	tcs
	rts
L303	equ	8
L304	equ	9
	ends
	efunc
;#endif
;
;
;
;#if FF_USE_LFN
;/*--------------------------------------------------------*/
;/* FAT-LFN: Compare a part of file name with an LFN entry */
;/*--------------------------------------------------------*/
;
;static int cmp_lfn (		/* 1:matched, 0:not matched */
;	const WCHAR* lfnbuf,	/* Pointer to the LFN to be compared */
;	BYTE* dir				/* Pointer to the LFN entry */
;)
;{
;	UINT ni, di;
;	WCHAR pchr, chr;
;
;
;	if (ld_16(dir + LDIR_FstClusLO) != 0) return 0;	/* Check if LDIR_FstClusLO is 0 */
;
;	ni = (UINT)((dir[LDIR_Ord] & 0x3F) - 1) * 13;	/* Offset in the name to be compared */
;
;	for (pchr = 1, di = 0; di < 13; di++) {	/* Process all characters in the entry */
;		chr = ld_16(dir + LfnOfs[di]);		/* Pick a character from the entry */
;		if (pchr != 0) {
;			if (ni >= FF_MAX_LFN + 1 || ff_wtoupper(chr) != ff_wtoupper(lfnbuf[ni++])) {	/* Compare it with name */
;				return 0;					/* Not matched */
;			}
;			pchr = chr;
;		} else {
;			if (chr != 0xFFFF) return 0;	/* Check filler */
;		}
;	}
;
;	if ((dir[LDIR_Ord] & LLEF) && pchr && lfnbuf[ni]) return 0;	/* Last name segment matched but different length */
;
;	return 1;		/* The part of LFN matched */
;}
;
;
;#if FF_FS_MINIMIZE <= 1 || FF_FS_RPATH >= 2 || FF_USE_LABEL || FF_FS_EXFAT
;/*-----------------------------------------------------*/
;/* FAT-LFN: Pick a part of file name from an LFN entry */
;/*-----------------------------------------------------*/
;
;static int pick_lfn (	/* 1:succeeded, 0:buffer overflow or invalid LFN entry */
;	WCHAR* lfnbuf,		/* Pointer to the name buffer to be stored */
;	const BYTE* dir		/* Pointer to the LFN entry */
;)
;{
;	UINT ni, di;
;	WCHAR pchr, chr;
;
;
;	if (ld_16(dir + LDIR_FstClusLO) != 0) return 0;	/* Check if LDIR_FstClusLO is 0 */
;
;	ni = (UINT)((dir[LDIR_Ord] & ~LLEF) - 1) * 13;	/* Offset in the name buffer */
;
;	for (pchr = 1, di = 0; di < 13; di++) {		/* Process all characters in the entry */
;		chr = ld_16(dir + LfnOfs[di]);			/* Pick a character from the entry */
;		if (pchr != 0) {
;			if (ni >= FF_MAX_LFN + 1) return 0;	/* Buffer overflow? */
;			lfnbuf[ni++] = pchr = chr;			/* Store it */
;		} else {
;			if (chr != 0xFFFF) return 0;		/* Check filler */
;		}
;	}
;
;	if (dir[LDIR_Ord] & LLEF && pchr != 0) {	/* Put terminator if it is the last LFN part and not terminated */
;		if (ni >= FF_MAX_LFN + 1) return 0;		/* Buffer overflow? */
;		lfnbuf[ni] = 0;
;	}
;
;	return 1;		/* The part of LFN is valid */
;}
;#endif
;
;
;#if !FF_FS_READONLY
;/*-----------------------------------------*/
;/* FAT-LFN: Create an entry of LFN entries */
;/*-----------------------------------------*/
;
;static void put_lfn (
;	const WCHAR* lfn,	/* Pointer to the LFN */
;	BYTE* dir,			/* Pointer to the LFN entry to be created */
;	BYTE ord,			/* LFN order (1-20) */
;	BYTE sum			/* Checksum of the corresponding SFN */
;)
;{
;	UINT ni, di;
;	WCHAR chr;
;
;
;	dir[LDIR_Chksum] = sum;			/* Set checksum */
;	dir[LDIR_Attr] = AM_LFN;		/* Set attribute */
;	dir[LDIR_Type] = 0;
;	st_16(dir + LDIR_FstClusLO, 0);
;
;	ni = (UINT)(ord - 1) * 13;		/* Offset in the name */
;	di = chr = 0;
;	do {	/* Fill the directory entry */
;		if (chr != 0xFFFF) chr = lfn[ni++];	/* Get an effective character */
;		st_16(dir + LfnOfs[di], chr);	/* Set it */
;		if (chr == 0) chr = 0xFFFF;		/* Padding characters after the terminator */
;	} while (++di < 13);
;	if (chr == 0xFFFF || !lfn[ni]) ord |= LLEF;	/* Last LFN part is the start of an enrty set */
;	dir[LDIR_Ord] = ord;			/* Set order in the entry set */
;}
;
;#endif	/* !FF_FS_READONLY */
;#endif	/* FF_USE_LFN */
;
;
;
;#if FF_USE_LFN && !FF_FS_READONLY
;/*-----------------------------------------------------------------------*/
;/* FAT-LFN: Create a Numbered SFN                                        */
;/*-----------------------------------------------------------------------*/
;
;static void gen_numname (
;	BYTE* dst,			/* Pointer to the buffer to store numbered SFN */
;	const BYTE* src,	/* Pointer to SFN in directory form */
;	const WCHAR* lfn,	/* Pointer to LFN */
;	WORD seq			/* Sequence number */
;)
;{
;	BYTE ns[8], c;
;	UINT i, j;
;
;
;	memcpy(dst, src, 11);	/* Prepare the SFN to be modified */
;
;	if (seq > 5) {	/* In case of many collisions, generate a hash number instead of sequential number */
;		WCHAR wc;
;		DWORD crc_sreg = seq;
;
;		while (*lfn) {	/* Create a CRC value as a hash of LFN */
;			wc = *lfn++;
;			for (i = 0; i < 16; i++) {
;				crc_sreg = (crc_sreg << 1) + (wc & 1);
;				wc >>= 1;
;				if (crc_sreg & 0x10000) crc_sreg ^= 0x11021;
;			}
;		}
;		seq = (WORD)crc_sreg;
;	}
;
;	/* Make suffix (~ + 4-digit hexadecimal) */
;	i = 7;
;	do {
;		c = (BYTE)((seq % 16) + '0'); seq /= 16;
;		if (c > '9') c += 7;
;		ns[i--] = c;
;	} while (i && seq);
;	ns[i] = '~';
;
;	/* Append the suffix to the SFN body */
;	for (j = 0; j < i && dst[j] != ' '; j++) {	/* Find the offset to append */
;		if (dbc_1st(dst[j])) {	/* To avoid DBC break up */
;			if (j == i - 1) break;
;			j++;
;		}
;	}
;	do {	/* Append the suffix */
;		dst[j++] = (i < 8) ? ns[i++] : ' ';
;	} while (j < 8);
;}
;#endif	/* FF_USE_LFN && !FF_FS_READONLY */
;
;
;
;#if FF_USE_LFN
;/*-----------------------------------------------------------------------*/
;/* FAT-LFN: Calculate checksum of an SFN entry                           */
;/*-----------------------------------------------------------------------*/
;
;static BYTE sum_sfn (
;	const BYTE* dir		/* Pointer to the SFN entry */
;)
;{
;	BYTE sum = 0;
;	UINT n = 11;
;
;	do {
;		sum = (sum >> 1) + (sum << 7) + *dir++;
;	} while (--n);
;	return sum;
;}
;
;#endif	/* FF_USE_LFN */
;
;
;
;#if FF_FS_EXFAT
;/*-----------------------------------------------------------------------*/
;/* exFAT: Checksum                                                       */
;/*-----------------------------------------------------------------------*/
;
;static WORD xdir_sum (	/* Get checksum of the directoly entry block */
;	const BYTE* dir		/* Directory entry block to be calculated */
;)
;{
;	UINT i, szblk;
;	WORD sum;
;
;
;	szblk = ((UINT)dir[XDIR_NumSec] + 1) * SZDIRE;	/* Number of bytes of the entry block */
;	for (i = sum = 0; i < szblk; i++) {
;		if (i == XDIR_SetSum) {	/* Skip 2-byte sum field */
;			i++;
;		} else {
;			sum = ((sum & 1) ? 0x8000 : 0) + (sum >> 1) + dir[i];
;		}
;	}
;	return sum;
;}
;
;
;
;static WORD xname_sum (	/* Get check sum (to be used as hash) of the file name */
;	const WCHAR* name	/* File name to be calculated */
;)
;{
;	WCHAR chr;
;	WORD sum = 0;
;
;
;	while ((chr = *name++) != 0) {
;		chr = (WCHAR)ff_wtoupper(chr);		/* File name needs to be up-case converted */
;		sum = ((sum & 1) ? 0x8000 : 0) + (sum >> 1) + (chr & 0xFF);
;		sum = ((sum & 1) ? 0x8000 : 0) + (sum >> 1) + (chr >> 8);
;	}
;	return sum;
;}
;
;
;#if !FF_FS_READONLY && FF_USE_MKFS
;static DWORD xsum32 (	/* Returns 32-bit checksum */
;	BYTE  dat,			/* Byte to be calculated (byte-by-byte processing) */
;	DWORD sum			/* Previous sum value */
;)
;{
;	sum = ((sum & 1) ? 0x80000000 : 0) + (sum >> 1) + dat;
;	return sum;
;}
;#endif
;
;
;
;/*------------------------------------*/
;/* exFAT: Get a directory entry block */
;/*------------------------------------*/
;
;static FRESULT load_xdir (	/* FR_INT_ERR: invalid entry block */
;	DIR* dp					/* Reading directory object pointing top of the entry block to load */
;)
;{
;	FRESULT res;
;	UINT i, sz_ent;
;	BYTE *dirb = dp->obj.fs->dirbuf;	/* Pointer to the on-memory directory entry block 85+C0+C1s */
;
;
;	/* Load file-directory entry */
;	res = move_window(dp->obj.fs, dp->sect);
;	if (res != FR_OK) return res;
;	if (dp->dir[XDIR_Type] != ET_FILEDIR) return FR_INT_ERR;	/* Invalid order? */
;	memcpy(dirb + 0 * SZDIRE, dp->dir, SZDIRE);
;	sz_ent = ((UINT)dirb[XDIR_NumSec] + 1) * SZDIRE;	/* Size of this entry block */
;	if (sz_ent < 3 * SZDIRE || sz_ent > 19 * SZDIRE) return FR_INT_ERR;	/* Invalid block size? */
;
;	/* Load stream extension entry */
;	res = dir_next(dp, 0);
;	if (res == FR_NO_FILE) res = FR_INT_ERR;	/* It cannot be */
;	if (res != FR_OK) return res;
;	res = move_window(dp->obj.fs, dp->sect);
;	if (res != FR_OK) return res;
;	if (dp->dir[XDIR_Type] != ET_STREAM) return FR_INT_ERR;	/* Invalid order? */
;	memcpy(dirb + 1 * SZDIRE, dp->dir, SZDIRE);
;	if (MAXDIRB(dirb[XDIR_NumName]) > sz_ent) return FR_INT_ERR;	/* Invalid block size for the name? */
;
;	/* Load file name entries */
;	i = 2 * SZDIRE;	/* Name offset to load */
;	do {
;		res = dir_next(dp, 0);
;		if (res == FR_NO_FILE) res = FR_INT_ERR;	/* It cannot be */
;		if (res != FR_OK) return res;
;		res = move_window(dp->obj.fs, dp->sect);
;		if (res != FR_OK) return res;
;		if (dp->dir[XDIR_Type] != ET_FILENAME) return FR_INT_ERR;	/* Invalid order? */
;		if (i < MAXDIRB(FF_MAX_LFN)) memcpy(dirb + i, dp->dir, SZDIRE);	/* Load name entries only if the object is accessible */
;	} while ((i += SZDIRE) < sz_ent);
;
;	/* Sanity check (do it for only accessible object) */
;	if (i <= MAXDIRB(FF_MAX_LFN)) {
;		if (xdir_sum(dirb) != ld_16(dirb + XDIR_SetSum)) return FR_INT_ERR;
;	}
;
;	return FR_OK;
;}
;
;
;/*------------------------------------------------------------------*/
;/* exFAT: Initialize object allocation info with loaded entry block */
;/*------------------------------------------------------------------*/
;
;static void init_alloc_info (
;	FFOBJID* dobj,	/* Object allocation information to be initialized */
;	DIR* sdir		/* Additional source about containing direcotry */
;)
;{
;	FATFS *fs = dobj->fs;
;
;
;	if (sdir) {	/* Initialize the containing directory. This block needs to precede the followings. */
;		dobj->c_scl = sdir->obj.sclust;
;		dobj->c_size = ((DWORD)sdir->obj.objsize & 0xFFFFFF00) | sdir->obj.stat;
;		dobj->c_ofs = sdir->blk_ofs;
;	}
;	dobj->sclust = ld_32(fs->dirbuf + XDIR_FstClus);	/* Start cluster */
;	dobj->objsize = ld_64(fs->dirbuf + XDIR_FileSize);	/* Size */
;	dobj->stat = fs->dirbuf[XDIR_GenFlags] & 2;			/* Allocation status */
;	dobj->n_frag = 0;									/* No last fragment info */
;}
;
;
;
;#if !FF_FS_READONLY || FF_FS_RPATH
;/*------------------------------------------------*/
;/* exFAT: Load the object's directory entry block */
;/*------------------------------------------------*/
;
;static FRESULT load_obj_xdir (
;	DIR* dp,			/* Blank directory object to be used to access containing directory */
;	const FFOBJID* obj	/* Object with its containing directory information */
;)
;{
;	FRESULT res;
;
;	/* Open object containing directory */
;	dp->obj.fs = obj->fs;
;	dp->obj.sclust = obj->c_scl;
;	dp->obj.stat = (BYTE)obj->c_size;
;	dp->obj.objsize = obj->c_size & 0xFFFFFF00;
;	dp->obj.n_frag = 0;
;	dp->blk_ofs = obj->c_ofs;
;
;	res = dir_sdi(dp, dp->blk_ofs);	/* Goto object's entry block */
;	if (res == FR_OK) {
;		res = load_xdir(dp);		/* Load the object's entry block */
;	}
;	return res;
;}
;#endif
;
;
;#if !FF_FS_READONLY
;/*----------------------------------------*/
;/* exFAT: Store the directory entry block */
;/*----------------------------------------*/
;
;static FRESULT store_xdir (
;	DIR* dp				/* Pointer to the directory object */
;)
;{
;	FRESULT res;
;	UINT nent;
;	BYTE *dirb = dp->obj.fs->dirbuf;	/* Pointer to the entry set 85+C0+C1s */
;
;
;	st_16(dirb + XDIR_SetSum, xdir_sum(dirb));	/* Create check sum */
;
;	/* Store the entry set to the directory */
;	nent = dirb[XDIR_NumSec] + 1;	/* Number of entries */
;	res = dir_sdi(dp, dp->blk_ofs);	/* Top of the entry set */
;	while (res == FR_OK) {
;		/* Set an entry to the directory */
;		res = move_window(dp->obj.fs, dp->sect);
;		if (res != FR_OK) break;
;		memcpy(dp->dir, dirb, SZDIRE);
;		dp->obj.fs->wflag = 1;
;
;		if (--nent == 0) break;	/* All done? */
;		dirb += SZDIRE;
;		res = dir_next(dp, 0);	/* Next entry */
;	}
;	return (res == FR_OK || res == FR_DISK_ERR) ? res : FR_INT_ERR;
;}
;
;
;
;/*-------------------------------------------*/
;/* exFAT: Create a new directory entry block */
;/*-------------------------------------------*/
;
;static void create_xdir (
;	BYTE* dirb,			/* Pointer to the directory entry block buffer */
;	const WCHAR* lfn	/* Pointer to the object name */
;)
;{
;	UINT i;
;	BYTE n_c1, nlen;
;	WCHAR chr;
;
;
;	/* Create file-directory and stream-extension entry (1st and 2nd entry) */
;	memset(dirb, 0, 2 * SZDIRE);
;	dirb[0 * SZDIRE + XDIR_Type] = ET_FILEDIR;
;	dirb[1 * SZDIRE + XDIR_Type] = ET_STREAM;
;
;	/* Create file name entries (3rd enrty and follows) */
;	i = SZDIRE * 2;	/* Top of file name entries */
;	nlen = n_c1 = 0; chr = 1;
;	do {
;		dirb[i++] = ET_FILENAME; dirb[i++] = 0;
;		do {	/* Fill name field */
;			if (chr != 0 && (chr = lfn[nlen]) != 0) nlen++;	/* Get a character if exist */
;			st_16(dirb + i, chr); 	/* Store it */
;			i += 2;
;		} while (i % SZDIRE != 0);
;		n_c1++;
;	} while (lfn[nlen]);	/* Fill next C1 entry if any char follows */
;
;	dirb[XDIR_NumName] = nlen;		/* Set name length */
;	dirb[XDIR_NumSec] = 1 + n_c1;	/* Set secondary count (C0 + C1s) */
;	st_16(dirb + XDIR_NameHash, xname_sum(lfn));	/* Set name hash */
;}
;
;#endif	/* !FF_FS_READONLY */
;#endif	/* FF_FS_EXFAT */
;
;
;
;#if FF_FS_MINIMIZE <= 1 || FF_FS_RPATH >= 2 || FF_USE_LABEL || FF_FS_EXFAT
;/*-----------------------------------------------------------------------*/
;/* Read an object from the directory                                     */
;/*-----------------------------------------------------------------------*/
;
;#define DIR_READ_FILE(dp) dir_read(dp, 0)
;#define DIR_READ_LABEL(dp) dir_read(dp, 1)
;
;static FRESULT dir_read (
;	DIR* dp,		/* Pointer to the directory object */
;	int vol			/* Filtered by 0:file/directory or 1:volume label */
;)
;{
	code
	func
_~dir_read:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L307
	tcs
	phd
	tcd
dp_0	set	3
vol_0	set	7
;	FRESULT res = FR_NO_FILE;
;	FATFS *fs = dp->obj.fs;
;	BYTE attr, et;
;#if FF_USE_LFN
;	BYTE ord = 0xFF, sum = 0xFF;
;#endif
;
;	while (dp->sect) {
res_1	set	0
fs_1	set	2
attr_1	set	6
et_1	set	7
	lda	#$4
	sta	<L308+res_1
	lda	[<L307+dp_0]
	sta	<L308+fs_1
	ldy	#$2
	lda	[<L307+dp_0],Y
	sta	<L308+fs_1+2
L10145:
	ldy	#$1a
	lda	[<L307+dp_0],Y
	iny
	iny
	ora	[<L307+dp_0],Y
	bne	*+5
	brl	L10146
;		res = move_window(fs, dp->sect);
	lda	[<L307+dp_0],Y
	pha
	dey
	dey
	lda	[<L307+dp_0],Y
	pha
	pei	<L308+fs_1+2
	pei	<L308+fs_1
	jsr	_~move_window
	sta	<L308+res_1
;		if (res != FR_OK) break;
	lda	<L308+res_1
	beq	*+5
	brl	L10146
;		et = dp->dir[DIR_Name];	/* Test for the entry type */
	ldy	#$1e
	lda	[<L307+dp_0],Y
	sta	<R0
	iny
	iny
	lda	[<L307+dp_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L308+et_1
	rep	#$20
	longa	on
;		if (et == 0) {
	lda	<L308+et_1
	and	#$ff
	bne	L10147
;			res = FR_NO_FILE; break; /* Reached to end of the directory */
	lda	#$4
	sta	<L308+res_1
	bra	L10146
;		}
;#if FF_FS_EXFAT
;		if (fs->fs_type == FS_EXFAT) {	/* On the exFAT volume */
;			if (FF_USE_LABEL && vol) {
;				if (et == ET_VLABEL) break;	/* Volume label entry? */
;			} else {
;				if (et == ET_FILEDIR) {		/* Start of the file entry block? */
;					dp->blk_ofs = dp->dptr;	/* Get location of the block */
;					res = load_xdir(dp);	/* Load the entry block */
;					if (res == FR_OK) {
;						dp->obj.attr = fs->dirbuf[XDIR_Attr] & AM_MASK;	/* Get attribute */
;					}
;					break;
;				}
;			}
;		} else
;#endif
;		{	/* On the FAT/FAT32 volume */
L10147:
;			dp->obj.attr = attr = dp->dir[DIR_Attr] & AM_MASK;	/* Get attribute */
	ldy	#$1e
	lda	[<L307+dp_0],Y
	sta	<R0
	iny
	iny
	lda	[<L307+dp_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$b
	lda	[<R0],Y
	and	#<$3f
	sta	<L308+attr_1
	ldy	#$6
	sta	[<L307+dp_0],Y
;#if FF_USE_LFN		/* LFN configuration */
;			if (et == DDEM || et == '.' || (int)((attr & ~AM_ARC) == AM_VOL) != vol) {	/* An entry without valid data */
;				ord = 0xFF;
;			} else {
;				if (attr == AM_LFN) {	/* An LFN entry is found */
;					if (et & LLEF) {		/* Is it start of an LFN sequence? */
;						sum = dp->dir[LDIR_Chksum];
;						et &= (BYTE)~LLEF; ord = et;
;						dp->blk_ofs = dp->dptr;
;					}
;					/* Check LFN validity and capture it */
;					ord = (et == ord && sum == dp->dir[LDIR_Chksum] && pick_lfn(fs->lfnbuf, dp->dir)) ? ord - 1 : 0xFF;
;				} else {				/* An SFN entry is found */
;					if (ord != 0 || sum != sum_sfn(dp->dir)) {	/* Is there a valid LFN? */
;						dp->blk_ofs = 0xFFFFFFFF;	/* It has no LFN. */
;					}
;					break;
;				}
;			}
;#else		/* Non LFN configuration */
;			if (et != DDEM && et != '.' && attr != AM_LFN && (int)((attr & ~AM_ARC) == AM_VOL) == vol) {	/* Is it a valid entry? */
	lda	<L308+et_1
	cmp	#<$e5
	rep	#$20
	longa	on
	beq	L10148
	sep	#$20
	longa	off
	lda	<L308+et_1
	cmp	#<$2e
	rep	#$20
	longa	on
	beq	L10148
	sep	#$20
	longa	off
	lda	<L308+attr_1
	cmp	#<$f
	rep	#$20
	longa	on
	beq	L10148
	stz	<R0
	lda	<L308+attr_1
	and	#$ff
	and	#<$ffffffdf
	cmp	#<$8
	bne	L315
	inc	<R0
L315:
	lda	<R0
	cmp	<L307+vol_0
	beq	L10146
;				break;
;			}
;#endif
;		}
L10148:
;		res = dir_next(dp, 0);		/* Next entry */
	pea	#<$0
	pei	<L307+dp_0+2
	pei	<L307+dp_0
	jsr	_~dir_next
	sta	<L308+res_1
;		if (res != FR_OK) break;
	lda	<L308+res_1
	bne	*+5
	brl	L10145
L10146:
;
;	if (res != FR_OK) dp->sect = 0;		/* Terminate the read operation on error or EOT */
	lda	<L308+res_1
	beq	L10149
;	}
	lda	#$0
	ldy	#$1a
	sta	[<L307+dp_0],Y
	iny
	iny
	sta	[<L307+dp_0],Y
;	return res;
L10149:
	lda	<L308+res_1
	tay
	lda	<L307+1
	sta	<L307+1+6
	pld
	tsc
	clc
	adc	#L307+6
	tcs
	tya
	rts
;}
L307	equ	16
L308	equ	9
	ends
	efunc
;
;#endif	/* FF_FS_MINIMIZE <= 1 || FF_USE_LABEL || FF_FS_RPATH >= 2 */
;
;
;
;/*-----------------------------------------------------------------------*/
;/* Directory handling - Find an object in the directory                  */
;/*-----------------------------------------------------------------------*/
;
;static FRESULT dir_find (	/* FR_OK(0):succeeded, !=0:error */
;	DIR* dp					/* Pointer to the directory object with the file name */
;)
;{
	code
	func
_~dir_find:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L321
	tcs
	phd
	tcd
dp_0	set	3
;	FRESULT res;
;	FATFS *fs = dp->obj.fs;
;	BYTE et;
;#if FF_USE_LFN
;	BYTE attr, ord, sum;
;#endif
;
;	res = dir_sdi(dp, 0);			/* Rewind directory object */
res_1	set	0
fs_1	set	2
et_1	set	6
	lda	[<L321+dp_0]
	sta	<L322+fs_1
	ldy	#$2
	lda	[<L321+dp_0],Y
	sta	<L322+fs_1+2
	pea	#^$0
	pea	#<$0
	pei	<L321+dp_0+2
	pei	<L321+dp_0
	jsr	_~dir_sdi
	sta	<L322+res_1
;	if (res != FR_OK) return res;
	lda	<L322+res_1
	beq	L10153
L20038:
	lda	<L322+res_1
	tay
	lda	<L321+1
	sta	<L321+1+4
	pld
	tsc
	clc
	adc	#L321+4
	tcs
	tya
	rts
;#if FF_FS_EXFAT
;	if (fs->fs_type == FS_EXFAT) {	/* On the exFAT volume */
;		BYTE nc;
;		UINT di, ni;
;		WORD hash = xname_sum(fs->lfnbuf);		/* Hash value of the name to find */
;
;		while ((res = DIR_READ_FILE(dp)) == FR_OK) {	/* Read an item */
;#if FF_MAX_LFN < 255
;			if (fs->dirbuf[XDIR_NumName] > FF_MAX_LFN) continue;		/* Skip comparison if inaccessible object name */
;#endif
;			if (ld_16(fs->dirbuf + XDIR_NameHash) != hash) continue;	/* Skip comparison if hash mismatched */
;			for (nc = fs->dirbuf[XDIR_NumName], di = SZDIRE * 2, ni = 0; nc; nc--, di += 2, ni++) {	/* Compare the name */
;				if ((di % SZDIRE) == 0) di += 2;
;				if (ff_wtoupper(ld_16(fs->dirbuf + di)) != ff_wtoupper(fs->lfnbuf[ni])) break;
;			}
;			if (nc == 0 && !fs->lfnbuf[ni]) break;	/* Name matched? */
;		}
;		return res;
;	}
;#endif
;	/* On the FAT/FAT32 volume */
;#if FF_USE_LFN
;	ord = sum = 0xFF; dp->blk_ofs = 0xFFFFFFFF;	/* Reset LFN sequence */
;#endif
;	do {
;#if FF_USE_LFN		/* LFN configuration */
;		dp->obj.attr = attr = dp->dir[DIR_Attr] & AM_MASK;
;		if (et == DDEM || ((attr & AM_VOL) && attr != AM_LFN)) {	/* An entry without valid data */
;			ord = 0xFF; dp->blk_ofs = 0xFFFFFFFF;	/* Reset LFN sequence */
;		} else {
;			if (attr == AM_LFN) {			/* Is it an LFN entry? */
;				if (!(dp->fn[NSFLAG] & NS_NOLFN)) {
;					if (et & LLEF) {		/* Is it start of an entry set? */
;						et &= (BYTE)~LLEF;
;						ord = et;					/* Number of LFN entries */
;						dp->blk_ofs = dp->dptr;		/* Start offset of LFN */
;						sum = dp->dir[LDIR_Chksum];	/* Sum of the SFN */
;					}
;					/* Check validity of the LFN entry and compare it with given name */
;					ord = (et == ord && sum == dp->dir[LDIR_Chksum] && cmp_lfn(fs->lfnbuf, dp->dir)) ? ord - 1 : 0xFF;
;				}
;			} else {					/* SFN entry */
;				if (ord == 0 && sum == sum_sfn(dp->dir)) break;	/* LFN matched? */
;				if (!(dp->fn[NSFLAG] & NS_LOSS) && !memcmp(dp->dir, dp->fn, 11)) break;	/* SFN matched? */
;				ord = 0xFF; dp->blk_ofs = 0xFFFFFFFF;	/* Not matched, reset LFN sequence */
;			}
;		}
;#else		/* Non LFN configuration */
;		dp->obj.attr = dp->dir[DIR_Attr] & AM_MASK;
L10154:
	ldy	#$1e
	lda	[<L321+dp_0],Y
	sta	<R0
	iny
	iny
	lda	[<L321+dp_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$b
	lda	[<R0],Y
	and	#<$3f
	ldy	#$6
	sta	[<L321+dp_0],Y
	rep	#$20
	longa	on
;		if (!(dp->dir[DIR_Attr] & AM_VOL) && !memcmp(dp->dir, dp->fn, 11)) break;	/* Is it a valid entry? */
	ldy	#$1e
	lda	[<L321+dp_0],Y
	sta	<R0
	iny
	iny
	lda	[<L321+dp_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$b
	lda	[<R0],Y
	and	#<$8
	rep	#$20
	longa	on
	bne	L327
	pea	#<$b
	lda	#$22
	clc
	adc	<L321+dp_0
	sta	<R0
	lda	#$0
	adc	<L321+dp_0+2
	pha
	pei	<R0
	ldy	#$20
	lda	[<L321+dp_0],Y
	pha
	dey
	dey
	lda	[<L321+dp_0],Y
	pha
	jsr	_~memcmp
	tax
	beq	L20038
L327:
;#endif
;		res = dir_next(dp, 0);	/* Next entry */
	pea	#<$0
	pei	<L321+dp_0+2
	pei	<L321+dp_0
	jsr	_~dir_next
	sta	<L322+res_1
;	} while (res == FR_OK);
	lda	<L322+res_1
	bne	L20038
L10153:
;		res = move_window(fs, dp->sect);
	ldy	#$1c
	lda	[<L321+dp_0],Y
	pha
	dey
	dey
	lda	[<L321+dp_0],Y
	pha
	pei	<L322+fs_1+2
	pei	<L322+fs_1
	jsr	_~move_window
	sta	<L322+res_1
;		if (res != FR_OK) break;
	lda	<L322+res_1
	beq	*+5
	brl	L20038
;		et = dp->dir[DIR_Name];		/* Entry type */
	ldy	#$1e
	lda	[<L321+dp_0],Y
	sta	<R0
	iny
	iny
	lda	[<L321+dp_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L322+et_1
	rep	#$20
	longa	on
;		if (et == 0) { res = FR_NO_FILE; break; }	/* Reached end of directory table */
	lda	<L322+et_1
	and	#$ff
	beq	*+5
	brl	L10154
	lda	#$4
	sta	<L322+res_1
;
;	return res;
	brl	L20038
;}
L321	equ	11
L322	equ	5
	ends
	efunc
;
;
;
;
;#if !FF_FS_READONLY
;/*-----------------------------------------------------------------------*/
;/* Register an object to the directory                                   */
;/*-----------------------------------------------------------------------*/
;
;static FRESULT dir_register (	/* FR_OK:succeeded, FR_DENIED:no free entry or too many SFN collision, FR_DISK_ERR:disk error */
;	DIR* dp						/* Target directory with object name to be created */
;)
;{
	code
	func
_~dir_register:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L331
	tcs
	phd
	tcd
dp_0	set	3
;	FRESULT res;
;	FATFS *fs = dp->obj.fs;
;#if FF_USE_LFN		/* LFN configuration */
;	UINT n, len, n_ent;
;	BYTE sn[12];
;
;
;	if (dp->fn[NSFLAG] & (NS_DOT | NS_NONAME)) return FR_INVALID_NAME;	/* Check name validity */
;	for (len = 0; fs->lfnbuf[len]; len++) ;	/* Get lfn length */
;
;#if FF_FS_EXFAT
;	if (fs->fs_type == FS_EXFAT) {	/* On the exFAT volume */
;		n_ent = (len + 14) / 15 + 2;	/* Number of entries to allocate (85+C0+C1s) */
;		res = dir_alloc(dp, n_ent);		/* Allocate directory entries */
;		if (res != FR_OK) return res;
;		dp->blk_ofs = dp->dptr - SZDIRE * (n_ent - 1);	/* Set the allocated entry block offset */
;
;		if (dp->obj.stat & 4) {			/* Has the directory been stretched by new allocation? */
;			dp->obj.stat &= ~4;
;			res = fill_first_frag(&dp->obj);	/* Fill the first fragment on the FAT if needed */
;			if (res != FR_OK) return res;
;			res = fill_last_frag(&dp->obj, dp->clust, 0xFFFFFFFF);	/* Fill the last fragment on the FAT if needed */
;			if (res != FR_OK) return res;
;			if (dp->obj.sclust != 0) {		/* Is it a sub-directory? */
;				DIR dj;
;
;				res = load_obj_xdir(&dj, &dp->obj);	/* Load the object status */
;				if (res != FR_OK) return res;
;				dp->obj.objsize += (DWORD)fs->csize * SS(fs);		/* Increase the directory size by cluster size */
;				st_64(fs->dirbuf + XDIR_FileSize, dp->obj.objsize);
;				st_64(fs->dirbuf + XDIR_ValidFileSize, dp->obj.objsize);
;				fs->dirbuf[XDIR_GenFlags] = dp->obj.stat | 1;	/* Update the allocation status */
;				res = store_xdir(&dj);				/* Store the object status */
;				if (res != FR_OK) return res;
;#if FF_FS_RPATH	/* Refrect changes to the current dir chain if the stretched dir is in it */
;				for (n = 1; n <= fs->xcwds.depth && dp->obj.sclust != fs->xcwds.tbl[n].d_scl; n++) ;	/* Check if the dir is in the current dir path */
;				if (n <= fs->xcwds.depth) {		/* If exist, update it */
;					fs->xcwds.tbl[n].d_size = (DWORD)dp->obj.objsize | dp->obj.stat;
;				}
;#endif
;			}
;		}
;
;		create_xdir(fs->dirbuf, fs->lfnbuf);	/* Create on-memory directory block to be written later */
;		return FR_OK;
;	}
;#endif
;	/* On the FAT/FAT32 volume */
;	memcpy(sn, dp->fn, 12);
;	if (sn[NSFLAG] & NS_LOSS) {			/* When LFN is out of 8.3 format, generate a numbered name */
;		dp->fn[NSFLAG] = NS_NOLFN;		/* Find only SFN */
;		for (n = 1; n < 100; n++) {
;			gen_numname(dp->fn, sn, fs->lfnbuf, (WORD)n);	/* Generate a numbered name */
;			res = dir_find(dp);				/* Check if the name collides with existing SFN */
;			if (res != FR_OK) break;
;		}
;		if (n == 100) return FR_DENIED;		/* Abort if too many collisions */
;		if (res != FR_NO_FILE) return res;	/* Abort if the result is other than 'not collided' */
;		dp->fn[NSFLAG] = sn[NSFLAG];
;	}
;
;	/* Create an SFN with/without LFNs. */
;	n_ent = (sn[NSFLAG] & NS_LFN) ? (len + 12) / 13 + 1 : 1;	/* Number of entries to allocate */
;	res = dir_alloc(dp, n_ent);		/* Allocate entries */
;	if (res == FR_OK && --n_ent) {	/* Set LFN entry if needed */
;		res = dir_sdi(dp, dp->dptr - n_ent * SZDIRE);
;		if (res == FR_OK) {
;			BYTE sum = sum_sfn(dp->fn);	/* Checksum value of the SFN tied to the LFN */
;
;			do {					/* Store LFN entries in bottom first */
;				res = move_window(fs, dp->sect);
;				if (res != FR_OK) break;
;				put_lfn(fs->lfnbuf, dp->dir, (BYTE)n_ent, sum);
;				fs->wflag = 1;
;				res = dir_next(dp, 0);	/* Next entry */
;			} while (res == FR_OK && --n_ent);
;		}
;	}
;
;#else	/* Non LFN configuration */
;	res = dir_alloc(dp, 1);		/* Allocate an entry for SFN */
res_1	set	0
fs_1	set	2
	lda	[<L331+dp_0]
	sta	<L332+fs_1
	ldy	#$2
	lda	[<L331+dp_0],Y
	sta	<L332+fs_1+2
	pea	#<$1
	pei	<L331+dp_0+2
	pei	<L331+dp_0
	jsr	_~dir_alloc
	sta	<L332+res_1
;
;#endif
;
;	/* Set SFN entry */
;	if (res == FR_OK) {
	lda	<L332+res_1
	bne	L10155
;		res = move_window(fs, dp->sect);
	ldy	#$1c
	lda	[<L331+dp_0],Y
	pha
	dey
	dey
	lda	[<L331+dp_0],Y
	pha
	pei	<L332+fs_1+2
	pei	<L332+fs_1
	jsr	_~move_window
	sta	<L332+res_1
;		if (res == FR_OK) {
	lda	<L332+res_1
	bne	L10155
;			memset(dp->dir, 0, SZDIRE);	/* Clean the entry */
	pea	#<$20
	pea	#<$0
	ldy	#$20
	lda	[<L331+dp_0],Y
	pha
	dey
	dey
	lda	[<L331+dp_0],Y
	pha
	jsr	_~memset
;			memcpy(dp->dir + DIR_Name, dp->fn, 11);	/* Put SFN */
	pea	#<$b
	lda	#$22
	clc
	adc	<L331+dp_0
	sta	<R0
	lda	#$0
	adc	<L331+dp_0+2
	pha
	pei	<R0
	ldy	#$20
	lda	[<L331+dp_0],Y
	pha
	dey
	dey
	lda	[<L331+dp_0],Y
	pha
	jsr	_~memcpy
;#if FF_USE_LFN
;			dp->dir[DIR_NTres] = dp->fn[NSFLAG] & (NS_BODY | NS_EXT);	/* Put low-case flags */
;#endif
;			fs->wflag = 1;
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$4
	sta	[<L332+fs_1],Y
	rep	#$20
	longa	on
;		}
;	}
;
;	return res;
L10155:
	lda	<L332+res_1
	tay
	lda	<L331+1
	sta	<L331+1+4
	pld
	tsc
	clc
	adc	#L331+4
	tcs
	tya
	rts
;}
L331	equ	10
L332	equ	5
	ends
	efunc
;
;#endif /* !FF_FS_READONLY */
;
;
;
;#if !FF_FS_READONLY && FF_FS_MINIMIZE == 0
;/*-----------------------------------------------------------------------*/
;/* Remove an object from the directory                                   */
;/*-----------------------------------------------------------------------*/
;
;static FRESULT dir_remove (	/* FR_OK:Succeeded, FR_DISK_ERR:A disk error */
;	DIR* dp					/* Directory object pointing the entry to be removed */
;)
;{
	code
	func
_~dir_remove:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L336
	tcs
	phd
	tcd
dp_0	set	3
;	FRESULT res;
;	FATFS *fs = dp->obj.fs;
;#if FF_USE_LFN		/* LFN configuration */
;	DWORD last = dp->dptr;
;
;	res = (dp->blk_ofs == 0xFFFFFFFF) ? FR_OK : dir_sdi(dp, dp->blk_ofs);	/* Goto top of the entry block if LFN is exist */
;	if (res == FR_OK) {
;		do {
;			res = move_window(fs, dp->sect);
;			if (res != FR_OK) break;
;			if (FF_FS_EXFAT && fs->fs_type == FS_EXFAT) {	/* On the exFAT volume */
;				dp->dir[XDIR_Type] &= 0x7F;	/* Clear the entry InUse flag. */
;			} else {										/* On the FAT/FAT32 volume */
;				dp->dir[DIR_Name] = DDEM;	/* Mark the entry 'deleted'. */
;			}
;			fs->wflag = 1;
;			if (dp->dptr >= last) break;	/* If reached last entry then all entries of the object has been deleted. */
;			res = dir_next(dp, 0);	/* Next entry */
;		} while (res == FR_OK);
;		if (res == FR_NO_FILE) res = FR_INT_ERR;
;	}
;#else			/* Non LFN configuration */
;
;	res = move_window(fs, dp->sect);
res_1	set	0
fs_1	set	2
	lda	[<L336+dp_0]
	sta	<L337+fs_1
	ldy	#$2
	lda	[<L336+dp_0],Y
	sta	<L337+fs_1+2
	ldy	#$1c
	lda	[<L336+dp_0],Y
	pha
	dey
	dey
	lda	[<L336+dp_0],Y
	pha
	pei	<L337+fs_1+2
	pei	<L337+fs_1
	jsr	_~move_window
	sta	<L337+res_1
;	if (res == FR_OK) {
	lda	<L337+res_1
	bne	L10157
;		dp->dir[DIR_Name] = DDEM;	/* Mark the entry 'deleted'.*/
	ldy	#$1e
	lda	[<L336+dp_0],Y
	sta	<R0
	iny
	iny
	lda	[<L336+dp_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$e5
	sta	[<R0]
;		fs->wflag = 1;
	lda	#$1
	ldy	#$4
	sta	[<L337+fs_1],Y
	rep	#$20
	longa	on
;	}
;#endif
;
;	return res;
L10157:
	lda	<L337+res_1
	tay
	lda	<L336+1
	sta	<L336+1+4
	pld
	tsc
	clc
	adc	#L336+4
	tcs
	tya
	rts
;}
L336	equ	10
L337	equ	5
	ends
	efunc
;
;#endif /* !FF_FS_READONLY && FF_FS_MINIMIZE == 0 */
;
;
;
;#if FF_FS_MINIMIZE <= 1 || FF_FS_RPATH >= 2
;/*-----------------------------------------------------------------------*/
;/* Get file information from directory entry                             */
;/*-----------------------------------------------------------------------*/
;
;static void get_fileinfo (
;	DIR* dp,			/* Pointer to the directory object */
;	FILINFO* fno		/* Pointer to the file information to be filled */
;)
;{
	code
	func
_~get_fileinfo:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L340
	tcs
	phd
	tcd
dp_0	set	3
fno_0	set	7
;	UINT si, di;
;#if FF_USE_LFN
;	WCHAR wc, hs;
;	FATFS *fs = dp->obj.fs;
;	UINT nw;
;#else
;	TCHAR c;
;#endif
;
;
;	fno->fname[0] = 0;
si_1	set	0
di_1	set	2
c_1	set	4
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$9
	sta	[<L340+fno_0],Y
	rep	#$20
	longa	on
;	if (dp->sect == 0) return;	/* Exit if read pointer has reached end of directory */
	ldy	#$1a
	lda	[<L340+dp_0],Y
	iny
	iny
	ora	[<L340+dp_0],Y
	bne	L10158
L343:
	lda	<L340+1
	sta	<L340+1+8
	pld
	tsc
	clc
	adc	#L340+8
	tcs
	rts
;
;#if FF_USE_LFN		/* LFN configuration */
;#if FF_FS_EXFAT
;	if (fs->fs_type == FS_EXFAT) {	/* exFAT volume */
;		UINT nc = 0;
;
;		si = SZDIRE * 2; di = 0;	/* 1st C1 entry in the entry block */
;		hs = 0;
;		while (nc < fs->dirbuf[XDIR_NumName]) {
;			if (si >= MAXDIRB(FF_MAX_LFN)) {	/* Truncated directory block? */
;				di = 0; break;
;			}
;			if ((si % SZDIRE) == 0) si += 2;	/* Skip entry type field */
;			wc = ld_16(fs->dirbuf + si); si += 2; nc++;	/* Get a character */
;			if (hs == 0 && IsSurrogate(wc)) {	/* Is it a surrogate? */
;				hs = wc; continue;				/* Get low surrogate */
;			}
;			nw = put_utf((DWORD)hs << 16 | wc, &fno->fname[di], FF_LFN_BUF - di);	/* Store it in API encoding */
;			if (nw == 0) {						/* Buffer overflow or wrong char? */
;				di = 0; break;
;			}
;			di += nw;
;			hs = 0;
;		}
;		if (hs != 0) di = 0;					/* Broken surrogate pair? */
;		if (di == 0) fno->fname[di++] = '\?';	/* Inaccessible object name? */
;		fno->fname[di] = 0;						/* Terminate the name */
;		fno->altname[0] = 0;					/* exFAT does not support SFN */
;
;		fno->fattrib = fs->dirbuf[XDIR_Attr] & AM_MASKX;	/* Attribute */
;		fno->fsize = (fno->fattrib & AM_DIR) ? 0 : ld_64(fs->dirbuf + XDIR_FileSize);	/* Size */
;		fno->ftime = ld_16(fs->dirbuf + XDIR_ModTime + 0);	/* Last modified time */
;		fno->fdate = ld_16(fs->dirbuf + XDIR_ModTime + 2);	/* Last modified date */
;#if FF_FS_CRTIME
;		fno->crtime = ld_16(fs->dirbuf + XDIR_CrtTime + 0);	/* Created time */
;		fno->crdate = ld_16(fs->dirbuf + XDIR_CrtTime + 2);	/* Created date */
;#endif
;		return;
;	} else
;#endif
;	{	/* FAT/FAT32 volume */
;		if (dp->blk_ofs != 0xFFFFFFFF) {	/* Get LFN if available */
;			si = di = 0;
;			hs = 0;
;			while (fs->lfnbuf[si] != 0) {
;				wc = fs->lfnbuf[si++];		/* Get an LFN character (UTF-16) */
;				if (hs == 0 && IsSurrogate(wc)) {	/* Is it a surrogate? */
;					hs = wc; continue;		/* Get low surrogate */
;				}
;				nw = put_utf((DWORD)hs << 16 | wc, &fno->fname[di], FF_LFN_BUF - di);	/* Store it in API encoding */
;				if (nw == 0) {				/* Buffer overflow or wrong char? */
;					di = 0; break;
;				}
;				di += nw;
;				hs = 0;
;			}
;			if (hs != 0) di = 0;	/* Broken surrogate pair? */
;			fno->fname[di] = 0;		/* Terminate the LFN (null string means LFN is invalid) */
;		}
;	}
;
;	si = di = 0;
;	while (si < 11) {		/* Get SFN from SFN entry */
;		wc = dp->dir[si++];			/* Get a char */
;		if (wc == ' ') continue;	/* Skip padding spaces */
;		if (wc == RDDEM) wc = DDEM;	/* Restore replaced DDEM character */
;		if (si == 9 && di < FF_SFN_BUF) fno->altname[di++] = '.';	/* Insert a . if extension is exist */
;#if FF_LFN_UNICODE >= 1	/* Unicode output */
;		if (dbc_1st((BYTE)wc) && si != 8 && si != 11 && dbc_2nd(dp->dir[si])) {	/* Make a DBC if needed */
;			wc = wc << 8 | dp->dir[si++];
;		}
;		wc = ff_oem2uni(wc, CODEPAGE);		/* ANSI/OEM -> Unicode */
;		if (wc == 0) {				/* Wrong char in the current code page? */
;			di = 0; break;
;		}
;		nw = put_utf(wc, &fno->altname[di], FF_SFN_BUF - di);	/* Store it in API encoding */
;		if (nw == 0) {				/* Buffer overflow? */
;			di = 0; break;
;		}
;		di += nw;
;#else					/* ANSI/OEM output */
;		fno->altname[di++] = (TCHAR)wc;	/* Store it without any conversion */
;#endif
;	}
;	fno->altname[di] = 0;	/* Terminate the SFN  (null string means SFN is invalid) */
;
;	if (!fno->fname[0]) {	/* If LFN is invalid, altname[] needs to be copied to fname[] */
;		if (di == 0) {		/* If LFN and SFN both are invalid, */
;			fno->fname[di++] = '\?';	/* This object is inaccessible due to wrong buffer or locale settings */
;		} else {
;			BYTE lcflg = NS_BODY;
;
;			for (si = di = 0; fno->altname[si]; si++, di++) {	/* Copy altname[] to fname[] with case information */
;				wc = (WCHAR)fno->altname[si];
;				if (wc == '.') lcflg = NS_EXT;
;				if (IsUpper(wc) && (dp->dir[DIR_NTres] & lcflg)) wc += 0x20;
;				fno->fname[di] = (TCHAR)wc;
;			}
;		}
;		fno->fname[di] = 0;	/* Terminate the LFN */
;		if (!dp->dir[DIR_NTres]) fno->altname[0] = 0;	/* Altname is not needed if neither LFN nor case info is exist. */
;	}
;
;#else	/* Non-LFN configuration */
;	si = di = 0;
L10158:
	stz	<L341+di_1
	stz	<L341+si_1
;	while (si < 11) {		/* Copy name body and extension */
	bra	L10159
L20040:
;		c = (TCHAR)dp->dir[si++];
	ldy	#$1e
	lda	[<L340+dp_0],Y
	sta	<R0
	iny
	iny
	lda	[<L340+dp_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	<L341+si_1
	lda	[<R0],Y
	sta	<L341+c_1
	rep	#$20
	longa	on
	inc	<L341+si_1
;		if (c == ' ') continue;		/* Skip padding spaces */
	sep	#$20
	longa	off
	lda	<L341+c_1
	cmp	#<$20
	rep	#$20
	longa	on
	beq	L10159
;		if (c == RDDEM) c = DDEM;	/* Restore replaced DDEM character */
	sep	#$20
	longa	off
	lda	<L341+c_1
	cmp	#<$5
	rep	#$20
	longa	on
	bne	L10161
	sep	#$20
	longa	off
	lda	#$e5
	sta	<L341+c_1
	rep	#$20
	longa	on
;		if (si == 9) fno->fname[di++] = '.';/* Insert a . if extension is exist */
L10161:
	lda	<L341+si_1
	cmp	#<$9
	bne	L10162
	lda	#$9
	clc
	adc	<L341+di_1
	tay
	sep	#$20
	longa	off
	lda	#$2e
	sta	[<L340+fno_0],Y
	rep	#$20
	longa	on
	inc	<L341+di_1
;		fno->fname[di++] = c;
L10162:
	lda	#$9
	clc
	adc	<L341+di_1
	tay
	sep	#$20
	longa	off
	lda	<L341+c_1
	sta	[<L340+fno_0],Y
	rep	#$20
	longa	on
	inc	<L341+di_1
;	}
L10159:
	lda	<L341+si_1
	cmp	#<$b
	bcc	L20040
;	fno->fname[di] = 0;		/* Terminate the SFN */
	lda	#$9
	clc
	adc	<L341+di_1
	tay
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L340+fno_0],Y
	rep	#$20
	longa	on
;#endif
;
;	fno->fattrib = dp->dir[DIR_Attr] & AM_MASK;		/* Attribute */
	ldy	#$1e
	lda	[<L340+dp_0],Y
	sta	<R0
	iny
	iny
	lda	[<L340+dp_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$b
	lda	[<R0],Y
	and	#<$3f
	ldy	#$8
	sta	[<L340+fno_0],Y
	rep	#$20
	longa	on
;	fno->fsize = ld_32(dp->dir + DIR_FileSize);		/* Size */
	clc
	lda	#$1c
	ldy	#$1e
	adc	[<L340+dp_0],Y
	sta	<R0
	lda	#$0
	iny
	iny
	adc	[<L340+dp_0],Y
	pha
	pei	<R0
	jsr	_~ld_32
	stx	<R1+2
	sta	[<L340+fno_0]
	lda	<R1+2
	ldy	#$2
	sta	[<L340+fno_0],Y
;	fno->ftime = ld_16(dp->dir + DIR_ModTime + 0);	/* Last modified time */
	clc
	lda	#$16
	ldy	#$1e
	adc	[<L340+dp_0],Y
	sta	<R0
	lda	#$0
	iny
	iny
	adc	[<L340+dp_0],Y
	pha
	pei	<R0
	jsr	_~ld_16
	ldy	#$6
	sta	[<L340+fno_0],Y
;	fno->fdate = ld_16(dp->dir + DIR_ModTime + 2);	/* Last Modified date */
	clc
	lda	#$18
	ldy	#$1e
	adc	[<L340+dp_0],Y
	sta	<R0
	lda	#$0
	iny
	iny
	adc	[<L340+dp_0],Y
	pha
	pei	<R0
	jsr	_~ld_16
	ldy	#$4
	sta	[<L340+fno_0],Y
;#if FF_FS_CRTIME
;	fno->crtime = ld_16(dp->dir + DIR_CrtTime + 0);	/* Created time */
;	fno->crdate = ld_16(dp->dir + DIR_CrtTime + 2);	/* Created date */
;#endif
;}
	brl	L343
L340	equ	13
L341	equ	9
	ends
	efunc
;
;#endif /* FF_FS_MINIMIZE <= 1 || FF_FS_RPATH >= 2 */
;
;
;
;#if FF_USE_FIND && FF_FS_MINIMIZE <= 1
;/*-----------------------------------------------------------------------*/
;/* Pattern matching                                                      */
;/*-----------------------------------------------------------------------*/
;
;#define FIND_RECURS	4	/* Maximum number of wildcard terms in the pattern to limit recursion */
;
;
;static DWORD get_achar (	/* Get a character and advance ptr */
;	const TCHAR** ptr		/* Pointer to pointer to the ANSI/OEM or Unicode string */
;)
;{
	code
	func
_~get_achar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L348
	tcs
	phd
	tcd
ptr_0	set	3
;	DWORD chr;
;
;
;#if FF_USE_LFN && FF_LFN_UNICODE >= 1	/* Unicode input */
;	chr = tchar2uni(ptr);
;	if (chr == 0xFFFFFFFF) chr = 0;		/* Wrong UTF encoding is recognized as end of the string */
;	chr = ff_wtoupper(chr);
;
;#else									/* ANSI/OEM input */
;	chr = (BYTE)*(*ptr)++;				/* Get a byte */
chr_1	set	0
	lda	[<L348+ptr_0]
	sta	<R0
	ldy	#$2
	lda	[<L348+ptr_0],Y
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<L349+chr_1
	stz	<L349+chr_1+2
	lda	#$1
	clc
	adc	[<L348+ptr_0]
	sta	[<L348+ptr_0]
	lda	#$0
	adc	[<L348+ptr_0],Y
	sta	[<L348+ptr_0],Y
;	if (IsLower(chr)) chr -= 0x20;		/* To upper ASCII char */
	lda	<L349+chr_1
	cmp	#<$61
	lda	<L349+chr_1+2
	sbc	#^$61
	bcc	L10163
	lda	#$7a
	cmp	<L349+chr_1
	lda	#$0
	sbc	<L349+chr_1+2
	bcc	L10163
	lda	#$ffe0
	clc
	adc	<L349+chr_1
	sta	<L349+chr_1
	lda	#$ffff
	adc	<L349+chr_1+2
	sta	<L349+chr_1+2
;#if FF_CODE_PAGE == 0
;	if (ExCvt && chr >= 0x80) chr = ExCvt[chr - 0x80];	/* To upper (SBCS extended char) */
;#elif FF_CODE_PAGE < 900
;	if (chr >= 0x80) chr = ExCvt[chr - 0x80];	/* To upper (SBCS extended char) */
L10163:
	lda	<L349+chr_1
	cmp	#<$80
	lda	<L349+chr_1+2
	sbc	#^$80
	bcc	L10164
	lda	#$ff80
	clc
	adc	<L349+chr_1
	tax
	lda	#$ffff
	adc	<L349+chr_1+2
	sta	<R0+2
	lda	|_~ExCvt,X
	and	#$ff
	sta	<L349+chr_1
	stz	<L349+chr_1+2
;#endif
;#if FF_CODE_PAGE == 0 || FF_CODE_PAGE >= 900
;	if (dbc_1st((BYTE)chr)) {	/* Get DBC 2nd byte if needed */
;		chr = dbc_2nd((BYTE)**ptr) ? chr << 8 | (BYTE)*(*ptr)++ : 0;
;	}
;#endif
;
;#endif
;	return chr;
L10164:
	ldx	<L349+chr_1+2
	lda	<L349+chr_1
	tay
	lda	<L348+1
	sta	<L348+1+4
	pld
	tsc
	clc
	adc	#L348+4
	tcs
	tya
	rts
;}
L348	equ	8
L349	equ	5
	ends
	efunc
;
;
;static int pattern_match (	/* 0:mismatched, 1:matched */
;	const TCHAR* pat,	/* Matching pattern */
;	const TCHAR* nam,	/* String to be tested */
;	UINT skip,			/* Number of pre-skip chars (number of ?s, b8:infinite (* specified)) */
;	UINT recur			/* Recursion count */
;)
;{
	code
	func
_~pattern_match:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L354
	tcs
	phd
	tcd
pat_0	set	3
nam_0	set	7
skip_0	set	11
recur_0	set	13
;	const TCHAR *pptr;
;	const TCHAR *nptr;
;	DWORD pchr, nchr;
;	UINT sk;
;
;
;	while ((skip & 0xFF) != 0) {		/* Pre-skip name chars */
pptr_1	set	0
nptr_1	set	4
pchr_1	set	8
nchr_1	set	12
sk_1	set	16
	bra	L10165
L20042:
;		if (!get_achar(&nam)) return 0;	/* Branch mismatched if less name chars */
	pea	#0
	clc
	tdc
	adc	#<L354+nam_0
	pha
	jsr	_~get_achar
	stx	<R0+2
	ora	<R0+2
	bne	L10167
L20043:
	lda	#$0
L358:
	tay
	lda	<L354+1
	sta	<L354+1+12
	pld
	tsc
	clc
	adc	#L354+12
	tcs
	tya
	rts
;		skip--;
L10167:
	dec	<L354+skip_0
;	}
L10165:
	lda	<L354+skip_0
	and	#<$ff
	bne	L20042
;	if (*pat == 0 && skip) return 1;	/* Matched? (short circuit) */
	lda	[<L354+pat_0]
	and	#$ff
	beq	*+5
	brl	L10171
	lda	<L354+skip_0
	bne	*+5
	brl	L10171
L20044:
	lda	#$1
	bra	L358
;
;	do {
;				sk = 0;
L10176:
	stz	<L355+sk_1
;				do {	/* Analyze the wildcard term */
L10179:
;					if (*pptr++ == '\?') {
	lda	<L355+pptr_1
	sta	<R0
	lda	<L355+pptr_1+2
	sta	<R0+2
	inc	<L355+pptr_1
	bne	L365
	inc	<L355+pptr_1+2
L365:
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3f
	rep	#$20
	longa	on
	bne	L10180
;						sk++;
	inc	<L355+sk_1
;					} else {
	bra	L10177
L10180:
;						sk |= 0x100;
	lda	#$100
	tsb	<L355+sk_1
;					}
;				} while (*pptr == '\?' || *pptr == '*');
L10177:
	sep	#$20
	longa	off
	lda	[<L355+pptr_1]
	cmp	#<$3f
	rep	#$20
	longa	on
	beq	L10179
	sep	#$20
	longa	off
	lda	[<L355+pptr_1]
	cmp	#<$2a
	rep	#$20
	longa	on
	beq	L10179
;				if (pattern_match(pptr, nptr, sk, recur - 1)) return 1;	/* Test new branch (recursive call) */
	lda	#$ffff
	clc
	adc	<L354+recur_0
	pha
	pei	<L355+sk_1
	pei	<L355+nptr_1+2
	pei	<L355+nptr_1
	pei	<L355+pptr_1+2
	pei	<L355+pptr_1
	jsr	_~pattern_match
	tax
	bne	L20044
;				nchr = *nptr; break;	/* Branch mismatched */
	lda	[<L355+nptr_1]
	and	#$ff
	sta	<L355+nchr_1
	stz	<L355+nchr_1+2
L10173:
;		get_achar(&nam);			/* nam++ */
	pea	#0
	clc
	tdc
	adc	#<L354+nam_0
	pha
	jsr	_~get_achar
;	} while (skip && nchr);		/* Retry until end of name if infinite search is specified */
	lda	<L354+skip_0
	bne	L374
;
;	return 0;
	brl	L20043
;			}
;			pchr = get_achar(&pptr);	/* Get a pattern char */
L10175:
	pea	#0
	clc
	tdc
	adc	#<L355+pptr_1
	pha
	jsr	_~get_achar
	sta	<L355+pchr_1
	stx	<L355+pchr_1+2
;			nchr = get_achar(&nptr);	/* Get a name char */
	pea	#0
	clc
	tdc
	adc	#<L355+nptr_1
	pha
	jsr	_~get_achar
	sta	<L355+nchr_1
	stx	<L355+nchr_1+2
;			if (pchr != nchr) break;	/* Branch mismatched? */
	lda	<L355+pchr_1
	cmp	<L355+nchr_1
	bne	L370
	lda	<L355+pchr_1+2
	cmp	<L355+nchr_1+2
L370:
	bne	L10173
;			if (pchr == 0) return 1;	/* Branch matched? (matched at end of both strings) */
	lda	<L355+pchr_1
	ora	<L355+pchr_1+2
	bne	L10174
	brl	L20044
;		}
L374:
	lda	<L355+nchr_1
	ora	<L355+nchr_1+2
	bne	*+5
	brl	L20043
L10171:
;		pptr = pat; nptr = nam;			/* Top of pattern and name to match */
	lda	<L354+pat_0
	sta	<L355+pptr_1
	lda	<L354+pat_0+2
	sta	<L355+pptr_1+2
	lda	<L354+nam_0
	sta	<L355+nptr_1
	lda	<L354+nam_0+2
	sta	<L355+nptr_1+2
;		for (;;) {
L10174:
;			if (*pptr == '\?' || *pptr == '*') {	/* Wildcard term? */
	sep	#$20
	longa	off
	lda	[<L355+pptr_1]
	cmp	#<$3f
	rep	#$20
	longa	on
	beq	L361
	sep	#$20
	longa	off
	lda	[<L355+pptr_1]
	cmp	#<$2a
	rep	#$20
	longa	on
	bne	L10175
L361:
;				if (recur == 0) return 0;	/* Too many wildcard terms? */
	lda	<L354+recur_0
	beq	*+5
	brl	L10176
	brl	L20043
;}
L354	equ	22
L355	equ	5
	ends
	efunc
;
;#endif /* FF_USE_FIND && FF_FS_MINIMIZE <= 1 */
;
;
;
;/*-----------------------------------------------------------------------*/
;/* Pick a top segment and create the object name in directory form       */
;/*-----------------------------------------------------------------------*/
;
;static FRESULT create_name (	/* FR_OK: successful, FR_INVALID_NAME: could not create */
;	DIR* dp,					/* Pointer to the directory object */
;	const TCHAR** path			/* Pointer to pointer to the segment in the path string */
;)
;{
	code
	func
_~create_name:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L376
	tcs
	phd
	tcd
dp_0	set	3
path_0	set	7
;#if FF_USE_LFN		/* LFN configuration */
;	BYTE b, cf;
;	WCHAR wc;
;	WCHAR *lfn;
;	const TCHAR* p;
;	DWORD uc;
;	UINT i, ni, si, di;
;
;
;	/* Create an LFN into LFN working buffer */
;	p = *path; lfn = dp->obj.fs->lfnbuf; di = 0;
;	for (;;) {
;		uc = tchar2uni(&p);			/* Get a character */
;		if (uc == 0xFFFFFFFF) return FR_INVALID_NAME;		/* Invalid code or UTF decode error */
;		if (uc >= 0x10000) lfn[di++] = (WCHAR)(uc >> 16);	/* Store high surrogate if needed */
;		wc = (WCHAR)uc;
;		if (wc < ' ' || IsSeparator(wc)) break;	/* Break if end of the path or a separator is found */
;		if (wc < 0x80 && strchr("*:<>|\"\?\x7F", (int)wc)) return FR_INVALID_NAME;	/* Reject illegal characters for LFN */
;		if (di >= FF_MAX_LFN) return FR_INVALID_NAME;	/* Reject too long name */
;		lfn[di++] = wc;				/* Store the Unicode character */
;	}
;	if (wc < ' ') {				/* Stopped at end of the path? */
;		cf = NS_LAST;			/* Last segment */
;	} else {					/* Stopped at a separator */
;		while (IsSeparator(*p)) p++;	/* Skip duplicated separators if exist */
;		cf = 0;					/* Next segment may follow */
;		if (IsTerminator(*p)) cf = NS_LAST;	/* Ignore terminating separator */
;	}
;	*path = p;					/* Return pointer to the next segment */
;
;#if FF_FS_RPATH
;	if ((di == 1 && lfn[di - 1] == '.') ||
;		(di == 2 && lfn[di - 1] == '.' && lfn[di - 2] == '.')) {	/* Is this segment a dot name? */
;		lfn[di] = 0;
;		for (i = 0; i < 11; i++) {	/* Create dot name for SFN entry */
;			dp->fn[i] = (i < di) ? '.' : ' ';
;		}
;		dp->fn[i] = cf | NS_DOT;	/* This is a dot entry */
;		return FR_OK;
;	}
;#endif
;	while (di) {					/* Snip off trailing spaces and dots if exist */
;		wc = lfn[di - 1];
;		if (wc != ' ' && wc != '.') break;
;		di--;
;	}
;	lfn[di] = 0;							/* LFN is created into the working buffer */
;	if (di == 0) return FR_INVALID_NAME;	/* Reject null name */
;
;	/* Create SFN in directory form */
;	for (si = 0; lfn[si] == ' '; si++) ;	/* Remove leading spaces */
;	if (si > 0 || lfn[si] == '.') cf |= NS_LOSS | NS_LFN;	/* Is there any leading space or dot? */
;	while (di > 0 && lfn[di - 1] != '.') di--;	/* Find last dot (di<=si: no extension) */
;
;	memset(dp->fn, ' ', 11);
;	i = b = 0; ni = 8;
;	for (;;) {
;		wc = lfn[si++];					/* Get an LFN character */
;		if (wc == 0) break;				/* Break on end of the LFN */
;		if (wc == ' ' || (wc == '.' && si != di)) {	/* Remove embedded spaces and dots */
;			cf |= NS_LOSS | NS_LFN;
;			continue;
;		}
;
;		if (i >= ni || si == di) {		/* End of field? */
;			if (ni == 11) {				/* Name extension overflow? */
;				cf |= NS_LOSS | NS_LFN;
;				break;
;			}
;			if (si != di) cf |= NS_LOSS | NS_LFN;	/* Name body overflow? */
;			if (si > di) break;						/* No name extension? */
;			si = di; i = 8; ni = 11; b <<= 2;		/* Enter name extension */
;			continue;
;		}
;
;		if (wc >= 0x80) {	/* Is this an extended character? */
;			cf |= NS_LFN;	/* LFN entry needs to be created */
;#if FF_CODE_PAGE == 0
;			if (ExCvt) {	/* In SBCS cfg */
;				wc = ff_uni2oem(wc, CODEPAGE);			/* Unicode ==> ANSI/OEM code */
;				if (wc & 0x80) wc = ExCvt[wc & 0x7F];	/* Convert extended character to upper (SBCS) */
;			} else {		/* In DBCS cfg */
;				wc = ff_uni2oem(ff_wtoupper(wc), CODEPAGE);	/* Unicode ==> Up-convert ==> ANSI/OEM code */
;			}
;#elif FF_CODE_PAGE < 900	/* In SBCS cfg */
;			wc = ff_uni2oem(wc, CODEPAGE);			/* Unicode ==> ANSI/OEM code */
;			if (wc & 0x80) wc = ExCvt[wc & 0x7F];	/* Convert extended character to upper (SBCS) */
;#else						/* In DBCS cfg */
;			wc = ff_uni2oem(ff_wtoupper(wc), CODEPAGE);	/* Unicode ==> Up-convert ==> ANSI/OEM code */
;#endif
;		}
;
;		if (wc >= 0x100) {				/* Is this a DBC? */
;			if (i >= ni - 1) {			/* Field overflow? */
;				cf |= NS_LOSS | NS_LFN;
;				i = ni; continue;		/* Next field */
;			}
;			dp->fn[i++] = (BYTE)(wc >> 8);	/* Put 1st byte */
;		} else {						/* SBC */
;			if (wc == 0 || strchr("+,;=[]", (int)wc)) {	/* Replace illegal characters for SFN */
;				wc = '_'; cf |= NS_LOSS | NS_LFN;/* Lossy conversion */
;			} else {
;				if (IsUpper(wc)) {		/* ASCII upper case? */
;					b |= 2;
;				}
;				if (IsLower(wc)) {		/* ASCII lower case? */
;					b |= 1; wc -= 0x20;
;				}
;			}
;		}
;		dp->fn[i++] = (BYTE)wc;
;	}
;
;	if (dp->fn[0] == DDEM) dp->fn[0] = RDDEM;	/* If the first character collides with DDEM, replace it with RDDEM */
;
;	if (ni == 8) b <<= 2;				/* Shift capital flags if no extension */
;	if ((b & 0x0C) == 0x0C || (b & 0x03) == 0x03) cf |= NS_LFN;	/* LFN entry needs to be created if composite capitals */
;	if (!(cf & NS_LFN)) {				/* When LFN is in 8.3 format without extended character, NT flags are created */
;		if (b & 0x01) cf |= NS_EXT;		/* NT flag (Extension has small capital letters only) */
;		if (b & 0x04) cf |= NS_BODY;	/* NT flag (Body has small capital letters only) */
;	}
;
;	dp->fn[NSFLAG] = cf;	/* SFN is created into dp->fn[] */
;
;	return FR_OK;
;
;
;#else	/* FF_USE_LFN : Non-LFN configuration */
;	BYTE c, d;
;	BYTE *sfn;
;	UINT ni, si, i;
;	const char *p;
;
;	/* Create file name in directory form */
;	p = *path; sfn = dp->fn;
c_1	set	0
d_1	set	1
sfn_1	set	2
ni_1	set	6
si_1	set	8
i_1	set	10
p_1	set	12
	lda	[<L376+path_0]
	sta	<L377+p_1
	ldy	#$2
	lda	[<L376+path_0],Y
	sta	<L377+p_1+2
	lda	#$22
	clc
	adc	<L376+dp_0
	sta	<L377+sfn_1
	lda	#$0
	adc	<L376+dp_0+2
	sta	<L377+sfn_1+2
;	memset(sfn, ' ', 11);
	pea	#<$b
	pea	#<$20
	pei	<L377+sfn_1+2
	pei	<L377+sfn_1
	jsr	_~memset
;	si = i = 0; ni = 8;
	stz	<L377+i_1
	stz	<L377+si_1
	lda	#$8
	sta	<L377+ni_1
;#if FF_FS_RPATH
;	if (p[si] == '.') { /* Is this a dot entry? */
	sep	#$20
	longa	off
	ldy	<L377+si_1
	lda	[<L377+p_1],Y
	cmp	#<$2e
	rep	#$20
	longa	on
	beq	L10187
;		for (;;) {	/* Copy one or two dots */
	brl	L10196
L20046:
	lda	<L377+si_1
	cmp	#<$3
	bcs	L10186
;			sfn[i++] = c;
	sep	#$20
	longa	off
	lda	<L377+c_1
	ldy	<L377+i_1
	sta	[<L377+sfn_1],Y
	rep	#$20
	longa	on
	inc	<L377+i_1
;		}
L10187:
;			c = (BYTE)p[si++];
	sep	#$20
	longa	off
	ldy	<L377+si_1
	lda	[<L377+p_1],Y
	sta	<L377+c_1
	rep	#$20
	longa	on
	inc	<L377+si_1
;			if (c != '.' || si >= 3) break;
	sep	#$20
	longa	off
	lda	<L377+c_1
	cmp	#<$2e
	rep	#$20
	longa	on
	beq	L20046
L10186:
;		if (IsSeparator(c)) {
	sep	#$20
	longa	off
	lda	<L377+c_1
	cmp	#<$2f
	rep	#$20
	longa	on
	beq	L10189
	sep	#$20
	longa	off
	lda	<L377+c_1
	cmp	#<$5c
	rep	#$20
	longa	on
	beq	L10189
;			while (IsSeparator(p[si])) si++;	/* Skip duplicated separators */
	sep	#$20
	longa	off
	lda	#$20
	cmp	<L377+c_1
	rep	#$20
	longa	on
	bcs	L10192
;			return FR_INVALID_NAME;
L20049:
	lda	#$6
L389:
	tay
	lda	<L376+1
	sta	<L376+1+8
	pld
	tsc
	clc
	adc	#L376+8
	tcs
	tya
	rts
L384:
	inc	<L377+si_1
L10189:
	sep	#$20
	longa	off
	ldy	<L377+si_1
	lda	[<L377+p_1],Y
	cmp	#<$2f
	rep	#$20
	longa	on
	beq	L384
	sep	#$20
	longa	off
	lda	[<L377+p_1],Y
	cmp	#<$5c
	rep	#$20
	longa	on
	beq	L384
;			if ((BYTE)p[si] <= ' ') c = 0;		/* Terminate if no segment follows */
	sep	#$20
	longa	off
	lda	#$20
	cmp	[<L377+p_1],Y
	rep	#$20
	longa	on
	bcc	L10192
	sep	#$20
	longa	off
	stz	<L377+c_1
	rep	#$20
	longa	on
;		} else if (c > ' ') {			/* Not in dot name */
L10192:
	lda	<L377+si_1
	sta	<R0
	stz	<R0+2
	lda	<L377+p_1
	clc
	adc	<R0
	sta	<R1
	lda	<L377+p_1+2
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	sta	[<L376+path_0]
	lda	<R1+2
	ldy	#$2
	sta	[<L376+path_0],Y
;		sfn[NSFLAG] = (c <= ' ') ? NS_LAST | NS_DOT : NS_DOT;	/* Set last segment flag if end of the path */
	sep	#$20
	longa	off
	lda	#$20
	cmp	<L377+c_1
	rep	#$20
	longa	on
	bcs	L391
	lda	#$20
L392:
	sep	#$20
	longa	off
	ldy	#$b
	sta	[<L377+sfn_1],Y
	rep	#$20
	longa	on
;		return FR_OK;
L20050:
	lda	#$0
	bra	L389
;		}
;		*path = p + si;					/* Return pointer to the next segment */
L391:
	lda	#$24
	bra	L392
;	}
;#endif
;	for (;;) {
L397:
	inc	<L377+si_1
L10198:
	sep	#$20
	longa	off
	ldy	<L377+si_1
	lda	[<L377+p_1],Y
	cmp	#<$2f
	rep	#$20
	longa	on
	beq	L397
	sep	#$20
	longa	off
	lda	[<L377+p_1],Y
	cmp	#<$5c
	rep	#$20
	longa	on
	beq	L397
;			break;
L10195:
;	*path = &p[si];						/* Return pointer to the next segment */
	lda	<L377+si_1
	sta	<R0
	stz	<R0+2
	lda	<L377+p_1
	clc
	adc	<R0
	sta	<R1
	lda	<L377+p_1+2
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	sta	[<L376+path_0]
	lda	<R1+2
	ldy	#$2
	sta	[<L376+path_0],Y
;	if (i == 0) return FR_INVALID_NAME;	/* Reject nul string */
	lda	<L377+i_1
	bne	*+5
	brl	L20049
	sep	#$20
	longa	off
	lda	[<L377+sfn_1]
	cmp	#<$e5
	rep	#$20
	longa	on
	bne	*+5
	brl	L415
	brl	L10209
;		}
;		if (c == '.' || i >= ni) {		/* End of body or field overflow? */
L10197:
	sep	#$20
	longa	off
	lda	<L377+c_1
	cmp	#<$2e
	rep	#$20
	longa	on
	beq	L400
	lda	<L377+i_1
	cmp	<L377+ni_1
	bcc	L10200
L400:
;			if (ni == 11 || c != '.') return FR_INVALID_NAME;	/* Field overflow or invalid dot? */
	lda	<L377+ni_1
	cmp	#<$b
	bne	*+5
	brl	L20049
	sep	#$20
	longa	off
	lda	<L377+c_1
	cmp	#<$2e
	rep	#$20
	longa	on
	beq	*+5
	brl	L20049
;			i = 8; ni = 11;				/* Enter file extension field */
	lda	#$8
	sta	<L377+i_1
	lda	#$b
	sta	<L377+ni_1
;			continue;
L10196:
;		c = (BYTE)p[si++];				/* Get a byte */
	sep	#$20
	longa	off
	ldy	<L377+si_1
	lda	[<L377+p_1],Y
	sta	<L377+c_1
	rep	#$20
	longa	on
	inc	<L377+si_1
;		if (c <= ' ') break; 			/* Break if end of the path name */
	sep	#$20
	longa	off
	lda	#$20
	cmp	<L377+c_1
	rep	#$20
	longa	on
	bcc	*+5
	brl	L10195
;		if (IsSeparator(c)) {			/* Break if a separator is found */
	sep	#$20
	longa	off
	lda	<L377+c_1
	cmp	#<$2f
	rep	#$20
	longa	on
	bne	*+5
	brl	L10198
	sep	#$20
	longa	off
	lda	<L377+c_1
	cmp	#<$5c
	rep	#$20
	longa	on
	bne	L10197
;			while (IsSeparator(p[si])) si++;	/* Skip duplicated separators */
	brl	L10198
;		}
;#if FF_CODE_PAGE == 0
;		if (ExCvt && c >= 0x80) {		/* Is SBC extended character? */
;			c = ExCvt[c & 0x7F];		/* To upper SBC extended character */
;		}
;#elif FF_CODE_PAGE < 900
;		if (c >= 0x80) {				/* Is SBC extended character? */
L10200:
	sep	#$20
	longa	off
	lda	<L377+c_1
	cmp	#<$80
	rep	#$20
	longa	on
	bcc	L10202
;			c = ExCvt[c & 0x7F];		/* To upper SBC extended character */
	lda	<L377+c_1
	and	#<$7f
	tax
	sep	#$20
	longa	off
	lda	|_~ExCvt,X
	sta	<L377+c_1
	rep	#$20
	longa	on
;		}
;#endif
;		if (dbc_1st(c)) {				/* Check if it is a DBC 1st byte */
L10202:
	pei	<L377+c_1
	jsr	_~dbc_1st
	tax
	beq	L10203
;			d = (BYTE)p[si++];			/* Get 2nd byte */
	sep	#$20
	longa	off
	ldy	<L377+si_1
	lda	[<L377+p_1],Y
	sta	<L377+d_1
	rep	#$20
	longa	on
	inc	<L377+si_1
;			if (!dbc_2nd(d) || i >= ni - 1) return FR_INVALID_NAME;	/* Reject invalid DBC */
	pei	<L377+d_1
	jsr	_~dbc_2nd
	tax
	bne	*+5
	brl	L20049
	lda	#$ffff
	clc
	adc	<L377+ni_1
	sta	<R0
	lda	<L377+i_1
	cmp	<R0
	bcc	*+5
	brl	L20049
;			sfn[i++] = c;
	sep	#$20
	longa	off
	lda	<L377+c_1
	ldy	<L377+i_1
	sta	[<L377+sfn_1],Y
	rep	#$20
	longa	on
	inc	<L377+i_1
;			sfn[i++] = d;
	sep	#$20
	longa	off
	lda	<L377+d_1
	ldy	<L377+i_1
	sta	[<L377+sfn_1],Y
	rep	#$20
	longa	on
L20051:
	inc	<L377+i_1
;		} else {						/* SBC */
	brl	L10196
L10203:
;			if (strchr("*+,:;<=>[]|\"\?\x7F", (int)c)) return FR_INVALID_NAME;	/* Reject illegal chrs for SFN */
	lda	<L377+c_1
	and	#$ff
	pha
	pea	#^L1
	pea	#<L1
	jsr	_~strchr
	stx	<R0+2
	ora	<R0+2
	beq	*+5
	brl	L20049
;			if (IsLower(c)) c -= 0x20;	/* To upper */
	sep	#$20
	longa	off
	lda	<L377+c_1
	cmp	#<$61
	rep	#$20
	longa	on
	bcc	L10207
	sep	#$20
	longa	off
	lda	#$7a
	cmp	<L377+c_1
	rep	#$20
	longa	on
	bcc	L10207
	lda	<L377+c_1
	and	#$ff
	clc
	adc	#$ffe0
	sep	#$20
	longa	off
	sta	<L377+c_1
	rep	#$20
	longa	on
;			sfn[i++] = c;
L10207:
	sep	#$20
	longa	off
	lda	<L377+c_1
	ldy	<L377+i_1
	sta	[<L377+sfn_1],Y
	rep	#$20
	longa	on
;		}
;	}
	bra	L20051
;
;	if (sfn[0] == DDEM) sfn[0] = RDDEM;	/* If the first character collides with DDEM, replace it with RDDEM */
L415:
	sep	#$20
	longa	off
	lda	#$5
	sta	[<L377+sfn_1]
	rep	#$20
	longa	on
;	sfn[NSFLAG] = (c <= ' ' || p[si] <= ' ') ? NS_LAST : 0;	/* Set last segment flag if end of the path */
L10209:
	sep	#$20
	longa	off
	lda	#$20
	cmp	<L377+c_1
	rep	#$20
	longa	on
	bcs	L417
	sep	#$20
	longa	off
	lda	#$20
	ldy	<L377+si_1
	cmp	[<L377+p_1],Y
	rep	#$20
	longa	on
	bcc	L416
L417:
	lda	#$4
	bra	L420
L416:
	lda	#$0
L420:
	sep	#$20
	longa	off
	ldy	#$b
	sta	[<L377+sfn_1],Y
	rep	#$20
	longa	on
;
;	return FR_OK;
	brl	L20050
;#endif /* FF_USE_LFN */
;}
L376	equ	24
L377	equ	9
	ends
	efunc
	data
L1:
	db	$2A,$2B,$2C,$3A,$3B,$3C,$3D,$3E,$5B,$5D,$7C,$22,$3F,$7F,$00
	ends
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* Follow a file path                                                    */
;/*-----------------------------------------------------------------------*/
;
;static FRESULT follow_path (	/* FR_OK(0): successful, !=0: error code */
;	DIR* dp,					/* Directory object to return last directory and found object */
;	const TCHAR* path			/* Full-path string to find a file or directory */
;)
;{
	code
	func
_~follow_path:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L422
	tcs
	phd
	tcd
dp_0	set	3
path_0	set	7
;	FRESULT res;
;	BYTE ns;
;	FATFS *fs = dp->obj.fs;
;
;
;	/* Determins the start directory (current directory or forced root directory) */
;#if FF_FS_RPATH
;	if (!IsSeparator(*path) && (FF_STR_VOLUME_ID != 2 || !IsTerminator(*path))) {	/* Without heading separator */
res_1	set	0
ns_1	set	2
fs_1	set	3
	lda	[<L422+dp_0]
	sta	<L423+fs_1
	ldy	#$2
	lda	[<L422+dp_0],Y
	sta	<L423+fs_1+2
	sep	#$20
	longa	off
	lda	[<L422+path_0]
	cmp	#<$2f
	rep	#$20
	longa	on
	beq	L10212
	sep	#$20
	longa	off
	lda	[<L422+path_0]
	cmp	#<$5c
	rep	#$20
	longa	on
	bne	L426
L10212:
	sep	#$20
	longa	off
	lda	[<L422+path_0]
	cmp	#<$2f
	rep	#$20
	longa	on
	bne	L429
L428:
	inc	<L422+path_0
	bne	L10212
	inc	<L422+path_0+2
	bra	L10212
L426:
;		dp->obj.sclust = fs->cdir;			/* Start at the current directory */
	ldy	#$14
	lda	[<L423+fs_1],Y
	ldy	#$8
	sta	[<L422+dp_0],Y
	ldy	#$16
	lda	[<L423+fs_1],Y
	bra	L20054
;	} else
;#endif
;	{										/* With heading separator */
;		while (IsSeparator(*path)) path++;	/* Strip heading separators */
L429:
	sep	#$20
	longa	off
	lda	[<L422+path_0]
	cmp	#<$5c
	rep	#$20
	longa	on
	beq	L428
;		dp->obj.sclust = 0;					/* Start at the root directory */
	lda	#$0
	ldy	#$8
	sta	[<L422+dp_0],Y
L20054:
	ldy	#$a
	sta	[<L422+dp_0],Y
;	}
;
;#if FF_FS_EXFAT
;	dp->obj.n_frag = 0;	/* Invalidate last fragment counter of the object */
;#if FF_FS_RPATH
;	if (fs->fs_type == FS_EXFAT) {	/* exFAT: Retrieve the start-directory's status */
;		if (dp->obj.sclust) {	/* Start directory is a sub-directory */
;			/* Load the current directory chain into working buffer and initialize directory object as current dir */
;			memcpy(&fs->xcwds2, &fs->xcwds, sizeof fs->xcwds2);
;			dp->obj.stat = (BYTE)fs->xcwds2.tbl[fs->xcwds2.depth].d_size;
;			dp->obj.objsize = fs->xcwds2.tbl[fs->xcwds2.depth].d_size & 0xFFFFFF00;
;			dp->obj.c_scl = fs->xcwds2.tbl[fs->xcwds2.depth - 1].d_scl;
;			dp->obj.c_size = fs->xcwds2.tbl[fs->xcwds2.depth - 1].d_size & 0xFFFFFF00;
;			dp->obj.c_ofs = fs->xcwds2.tbl[fs->xcwds2.depth - 1].nxt_ofs;
;		} else {				/* Start directory is the root directory */
;			/* Clear the directory path working buffer as root directory */
;			memset(&fs->xcwds2, 0, sizeof fs->xcwds2);
;		}
;	}
;#endif
;#endif
;
;	if ((UINT)*path < ' ') {				/* Null path name is the origin directory itself */
	sep	#$20
	longa	off
	lda	[<L422+path_0]
	cmp	#<$20
	rep	#$20
	longa	on
	bcc	*+5
	brl	L10218
;		dp->fn[NSFLAG] = NS_NONAME;
	sep	#$20
	longa	off
	lda	#$80
	ldy	#$2d
	sta	[<L422+dp_0],Y
	rep	#$20
	longa	on
;		res = dir_sdi(dp, 0);
	pea	#^$0
	pea	#<$0
	pei	<L422+dp_0+2
	pei	<L422+dp_0
	jsr	_~dir_sdi
L20053:
	sta	<L423+res_1
;
;	} else {								/* Follow path */
L10215:
;
;	return res;
	lda	<L423+res_1
	tay
	lda	<L422+1
	sta	<L422+1+8
	pld
	tsc
	clc
	adc	#L422+8
	tcs
	tya
	rts
;		for (;;) {
L10221:
;						if (!(ns & NS_LAST)) res = FR_NO_PATH;	/* Adjust error code if not last segment */
	sep	#$20
	longa	off
	lda	<L423+ns_1
	and	#<$4
	rep	#$20
	longa	on
	bne	L10215
L20055:
	lda	#$5
	bra	L20053
;					}
;				}
;				break;
;			}
;#if FF_FS_EXFAT && FF_FS_RPATH
;			if (fs->fs_type == FS_EXFAT && (dp->obj.attr & AM_DIR)) {	/* Record the path if it is a sub-directory */
;				fs->xcwds2.tbl[fs->xcwds2.depth].nxt_ofs = dp->blk_ofs;
;				if (++fs->xcwds2.depth >= sizeof fs->xcwds2.tbl / sizeof fs->xcwds2.tbl[0]) {	/* Is it too deep path? */
;					res = FR_NOT_ENOUGH_CORE; break;
;				}
;				fs->xcwds2.tbl[fs->xcwds2.depth].d_scl = ld_32(fs->dirbuf + XDIR_FstClus);
;				fs->xcwds2.tbl[fs->xcwds2.depth].d_size = ld_32(fs->dirbuf + XDIR_FileSize) | (fs->dirbuf[XDIR_GenFlags] & 2);
;			}
;#endif
;			if (ns & NS_LAST) break;		/* If last segment matched, the function completed */
L10219:
	sep	#$20
	longa	off
	lda	<L423+ns_1
	and	#<$4
	rep	#$20
	longa	on
	bne	L10215
;			/* Get into the sub-directory */
;			if (!(dp->obj.attr & AM_DIR)) {
	sep	#$20
	longa	off
	ldy	#$6
	lda	[<L422+dp_0],Y
	and	#<$10
	rep	#$20
	longa	on
	beq	L20055
;				res = FR_NO_PATH; break;	/* It is not a sub-directory and cannot follow the path */
;			}
;#if FF_FS_EXFAT
;			if (fs->fs_type == FS_EXFAT) {
;				init_alloc_info(&dp->obj, dp);	/* Open next directory */
;			} else
;#endif
;			{
;				dp->obj.sclust = ld_clust(fs, fs->win + dp->dptr % SS(fs));	/* Open next directory */
	ldy	#$12
	lda	[<L422+dp_0],Y
	and	#<$1ff
	sta	<R0
	stz	<R0+2
	lda	#$34
	clc
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	<L423+fs_1
	clc
	adc	<R1
	sta	<R0
	lda	<L423+fs_1+2
	adc	<R1+2
	pha
	pei	<R0
	pei	<L423+fs_1+2
	pei	<L423+fs_1
	jsr	_~ld_clust
	stx	<R2+2
	ldy	#$8
	sta	[<L422+dp_0],Y
	lda	<R2+2
	iny
	iny
	sta	[<L422+dp_0],Y
;			}
;		}
L10218:
;			res = create_name(dp, &path);	/* Get a segment name of the path */
	pea	#0
	clc
	tdc
	adc	#<L422+path_0
	pha
	pei	<L422+dp_0+2
	pei	<L422+dp_0
	jsr	_~create_name
	sta	<L423+res_1
;			if (res != FR_OK) break;
	lda	<L423+res_1
	beq	*+5
	brl	L10215
;			ns = dp->fn[NSFLAG];
	sep	#$20
	longa	off
	ldy	#$2d
	lda	[<L422+dp_0],Y
	sta	<L423+ns_1
	rep	#$20
	longa	on
;#if FF_FS_EXFAT && FF_FS_RPATH
;			if (fs->fs_type == FS_EXFAT && (ns & NS_DOT)) {	/* Is it a dot name? */
;				/* There is no dot entry in exFAT volume, so it needs to follow the parent directory with recorded path */
;				if (fs->lfnbuf[1] == '.' && fs->xcwds2.depth) {	/* ".." in the sub-dir? */
;					fs->xcwds2.depth--;	/* Get into the parent directory and load the directory info */
;					dp->obj.sclust = fs->xcwds2.tbl[fs->xcwds2.depth].d_scl;
;					dp->obj.stat = (BYTE)fs->xcwds2.tbl[fs->xcwds2.depth].d_size;
;					dp->obj.objsize = fs->xcwds2.tbl[fs->xcwds2.depth].d_size & 0xFFFFFF00;
;					if (fs->xcwds2.depth) {		/* Load containing dir info if needed */
;						dp->obj.c_scl = fs->xcwds2.tbl[fs->xcwds2.depth - 1].d_scl;
;						dp->obj.c_size = fs->xcwds2.tbl[fs->xcwds2.depth - 1].d_size;
;						dp->obj.c_ofs = fs->xcwds2.tbl[fs->xcwds2.depth - 1].nxt_ofs;
;					}
;				}
;				dp->obj.attr |= AM_DIR;			/* This is a directory */
;				dp->fn[NSFLAG] |= NS_NONAME;	/* but dot names in exFAT volume are not directory entry */
;				if (ns & NS_LAST) break;		/* Last segment? */
;				continue;		/* Follow next segment */
;			}
;#endif
;			res = dir_find(dp);				/* Find an object with the segment name */
	pei	<L422+dp_0+2
	pei	<L422+dp_0
	jsr	_~dir_find
	sta	<L423+res_1
;			if (res != FR_OK) {				/* Failed to find the object */
	lda	<L423+res_1
	bne	*+5
	brl	L10219
;				if (res == FR_NO_FILE) {	/* Object is not found */
	lda	<L423+res_1
	cmp	#<$4
	beq	*+5
	brl	L10215
;					if (FF_FS_RPATH && (ns & NS_DOT)) {	/* If dot entry is not exist, stay there (may be root dir in FAT volume) */
	sep	#$20
	longa	off
	lda	<L423+ns_1
	and	#<$20
	rep	#$20
	longa	on
	bne	*+5
	brl	L10221
;						if (!(ns & NS_LAST)) continue;	/* Continue to follow if not last segment */
	sep	#$20
	longa	off
	lda	<L423+ns_1
	and	#<$4
	rep	#$20
	longa	on
	beq	L10218
;						dp->fn[NSFLAG] = NS_NONAME;
	sep	#$20
	longa	off
	lda	#$80
	ldy	#$2d
	sta	[<L422+dp_0],Y
	rep	#$20
	longa	on
;						res = FR_OK;
	stz	<L423+res_1
;					} else {							/* Could not find the object */
	brl	L10215
;	}
;}
L422	equ	19
L423	equ	13
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* Get logical drive number from path name                               */
;/*-----------------------------------------------------------------------*/
;
;static int get_ldnumber (	/* Returns logical drive number (-1:invalid drive number or null pointer) */
;	const TCHAR** path		/* Pointer to pointer to the path name */
;)
;{
	code
	func
_~get_ldnumber:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L442
	tcs
	phd
	tcd
path_0	set	3
;	const TCHAR *tp;
;	const TCHAR *tt;
;	TCHAR chr;
;	int i;
;#if FF_STR_VOLUME_ID		/* Find string volume ID */
;	const char *vsp;
;	char vchr;
;#endif
;
;	tt = tp = *path;
tp_1	set	0
tt_1	set	4
chr_1	set	8
i_1	set	9
	lda	[<L442+path_0]
	sta	<L443+tp_1
	ldy	#$2
	lda	[<L442+path_0],Y
	sta	<L443+tp_1+2
	lda	<L443+tp_1
	sta	<L443+tt_1
	lda	<L443+tp_1+2
	sta	<L443+tt_1+2
;	if (!tp) return -1;		/* Invalid path name? */
	lda	<L443+tp_1
	ora	<L443+tp_1+2
	bne	L10228
L20056:
	lda	#$ffff
L445:
	tay
	lda	<L442+1
	sta	<L442+1+4
	pld
	tsc
	clc
	adc	#L442+4
	tcs
	tya
	rts
;	do {					/* Find a colon in the path */
L10228:
;		chr = *tt++;
	sep	#$20
	longa	off
	lda	[<L443+tt_1]
	sta	<L443+chr_1
	rep	#$20
	longa	on
	inc	<L443+tt_1
	bne	L10226
	inc	<L443+tt_1+2
;	} while (!IsTerminator(chr) && chr != ':');
L10226:
	sep	#$20
	longa	off
	lda	<L443+chr_1
	cmp	#<$21
	rep	#$20
	longa	on
	bcc	L10227
	sep	#$20
	longa	off
	lda	<L443+chr_1
	cmp	#<$3a
	rep	#$20
	longa	on
	bne	L10228
L10227:
;
;	if (chr == ':') {	/* Is there a DOS/Windows style volume ID? */
	sep	#$20
	longa	off
	lda	<L443+chr_1
	cmp	#<$3a
	rep	#$20
	longa	on
	bne	L10229
;		i = FF_VOLUMES;
	lda	#$1
	sta	<L443+i_1
;		if (IsDigit(*tp) && tp + 2 == tt) {	/* Is it a numeric volume ID + colon? */
	sep	#$20
	longa	off
	lda	[<L443+tp_1]
	cmp	#<$30
	rep	#$20
	longa	on
	bcc	L10230
	sep	#$20
	longa	off
	lda	#$39
	cmp	[<L443+tp_1]
	rep	#$20
	longa	on
	bcc	L10230
	lda	#$2
	clc
	adc	<L443+tp_1
	sta	<R0
	lda	#$0
	adc	<L443+tp_1+2
	sta	<R0+2
	lda	<L443+tt_1
	cmp	<R0
	bne	L453
	lda	<L443+tt_1+2
	cmp	<R0+2
L453:
	bne	L10230
;			i = (int)*tp - '0';	/* Get the logical drive number */
	lda	[<L443+tp_1]
	and	#$ff
	clc
	adc	#$ffd0
	sta	<L443+i_1
;		}
;#if FF_STR_VOLUME_ID == 1	/* Arbitrary string volume ID is enabled */
;		else {
;			i = 0;	/* Find volume ID string in the preconfigured table */
;			do {
;				vsp = VolumeStr[i]; tp = *path;	/* Preconfigured string and path name to test */
;				do {	/* Compare the volume ID with path name in case-insensitive */
;					vchr = *vsp++; chr = *tp++;
;					if (IsLower(vchr)) vchr -= 0x20;
;					if (IsLower(chr)) chr -= 0x20;
;				} while (vchr && (TCHAR)vchr == chr);
;			} while ((vchr || tp != tt) && ++i < FF_VOLUMES);	/* Repeat for each id until pattern match */
;		}
;#endif
;		if (i >= FF_VOLUMES) return -1;	/* Not found or invalid volume ID */
L10230:
	sec
	lda	<L443+i_1
	sbc	#<$1
	bvs	L455
	eor	#$8000
L455:
	bpl	*+5
	brl	L20056
;		*path = tt;		/* Snip the drive prefix off */
	lda	<L443+tt_1
	sta	[<L442+path_0]
	lda	<L443+tt_1+2
	ldy	#$2
	sta	[<L442+path_0],Y
;		return i;		/* Return the found drive number */
	lda	<L443+i_1
	brl	L445
;	}
;#if FF_STR_VOLUME_ID == 2		/* Unix style volume ID is enabled */
;	if (*tp == '/') {			/* Is there a volume ID? */
;		while (*(tp + 1) == '/') tp++;	/* Skip duplicated separator */
;		i = 0;
;		do {
;			vsp = VolumeStr[i]; tt = tp; 	/* Preconfigured string and path name to test */
;			do {	/* Compare the volume ID with path name in case-insensitive */
;				vchr = *vsp++; chr = *(++tt);
;				if (IsLower(vchr)) vchr -= 0x20;
;				if (IsLower(chr)) chr -= 0x20;
;			} while (vchr && (TCHAR)vchr == chr);
;		} while ((vchr || (chr != '/' && !IsTerminator(chr))) && ++i < FF_VOLUMES);	/* Repeat for each ID until pattern match */
;		if (i >= FF_VOLUMES) return -1;	/* Not found (invalid volume ID) */
;		*path = tt;		/* Snip the node name off */
;		return i;		/* Return the found drive number */
;	}
;#endif
;	/* No drive prefix */
;#if FF_FS_RPATH
;	return (int)CurrVol;	/* Default drive is current drive */
L10229:
	lda	|_~CurrVol
	and	#$ff
	brl	L445
;#else
;	return 0;				/* Default drive is 0 */
;#endif
;}
L442	equ	15
L443	equ	5
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* GPT support functions                                                 */
;/*-----------------------------------------------------------------------*/
;
;#if FF_LBA64
;
;/* Calculate CRC32 in byte-by-byte */
;
;static DWORD crc32 (	/* Returns next CRC value */
;	DWORD crc,			/* Current CRC value */
;	BYTE d				/* A byte to be processed */
;)
;{
;	BYTE b;
;
;
;	for (b = 1; b; b <<= 1) {
;		crc ^= (d & b) ? 1 : 0;
;		crc = (crc & 1) ? crc >> 1 ^ 0xEDB88320 : crc >> 1;
;	}
;	return crc;
;}
;
;
;/* Check validity of GPT header */
;
;static int test_gpt_header (	/* 0:Invalid, 1:Valid */
;	const BYTE* gpth			/* Pointer to the GPT header */
;)
;{
;	UINT i;
;	DWORD bcc, hlen;
;
;
;	if (memcmp(gpth + GPTH_Sign, "EFI PART" "\0\0\1", 12)) return 0;	/* Check signature and version (1.0) */
;	hlen = ld_32(gpth + GPTH_Size);							/* Check header size */
;	if (hlen < 92 || hlen > FF_MIN_SS) return 0;
;	for (i = 0, bcc = 0xFFFFFFFF; i < hlen; i++) {			/* Check header BCC */
;		bcc = crc32(bcc, i - GPTH_Bcc < 4 ? 0 : gpth[i]);
;	}
;	if (~bcc != ld_32(gpth + GPTH_Bcc)) return 0;
;	if (ld_32(gpth + GPTH_PteSize) != SZ_GPTE) return 0;	/* Table entry size (must be SZ_GPTE bytes) */
;	if (ld_32(gpth + GPTH_PtNum) > 128) return 0;			/* Table size (must be 128 entries or less) */
;
;	return 1;
;}
;
;#if !FF_FS_READONLY && FF_USE_MKFS
;
;/* Generate a random value */
;static DWORD make_rand (	/* Returns a seed value for next */
;	DWORD seed,				/* Seed value */
;	BYTE *buff,				/* Output buffer */
;	UINT n					/* Data length */
;)
;{
;	UINT r;
;
;
;	if (seed == 0) seed = 1;
;	do {
;		for (r = 0; r < 8; r++) seed = seed & 1 ? seed >> 1 ^ 0xA3000000 : seed >> 1;	/* Shift 8 bits the 32-bit LFSR */
;		*buff++ = (BYTE)seed;
;	} while (--n);
;	return seed;
;}
;
;#endif
;#endif
;
;
;
;/*-----------------------------------------------------------------------*/
;/* Load a sector and check if it is an FAT VBR                           */
;/*-----------------------------------------------------------------------*/
;
;/* Check what the sector is */
;
;static UINT check_fs (	/* 0:FAT/FAT32 VBR, 1:exFAT VBR, 2:Not FAT and valid BS, 3:Not FAT and invalid BS, 4:Disk error */
;	FATFS* fs,			/* Filesystem object */
;	LBA_t sect			/* Sector to load and check if it is an FAT-VBR or not */
;)
;{
	code
	func
_~check_fs:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L457
	tcs
	phd
	tcd
fs_0	set	3
sect_0	set	7
;	WORD w, sign;
;	BYTE b;
;
;
;	fs->wflag = 0; fs->winsect = (LBA_t)0 - 1;		/* Invaidate window */
w_1	set	0
sign_1	set	2
b_1	set	4
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$4
	sta	[<L457+fs_0],Y
	rep	#$20
	longa	on
	lda	#$ffff
	ldy	#$20
	sta	[<L457+fs_0],Y
	iny
	iny
	sta	[<L457+fs_0],Y
;	if (move_window(fs, sect) != FR_OK) return 4;	/* Load the boot sector */
	pei	<L457+sect_0+2
	pei	<L457+sect_0
	pei	<L457+fs_0+2
	pei	<L457+fs_0
	jsr	_~move_window
	tax
	beq	L10232
	lda	#$4
L460:
	tay
	lda	<L457+1
	sta	<L457+1+8
	pld
	tsc
	clc
	adc	#L457+8
	tcs
	tya
	rts
;	sign = ld_16(fs->win + BS_55AA);
L10232:
	lda	#$232
	clc
	adc	<L457+fs_0
	sta	<R0
	lda	#$0
	adc	<L457+fs_0+2
	pha
	pei	<R0
	jsr	_~ld_16
	sta	<L458+sign_1
;#if FF_FS_EXFAT
;	if (sign == 0xAA55 && !memcmp(fs->win + BS_JmpBoot, "\xEB\x76\x90" "EXFAT   ", 11)) return 1;	/* It is an exFAT VBR */
;#endif
;	b = fs->win[BS_JmpBoot];
	sep	#$20
	longa	off
	ldy	#$34
	lda	[<L457+fs_0],Y
	sta	<L458+b_1
;	if (b == 0xEB || b == 0xE9 || b == 0xE8) {	/* Valid JumpBoot code? (short jump, near jump or near call) */
	cmp	#<$eb
	rep	#$20
	longa	on
	beq	L461
	sep	#$20
	longa	off
	lda	<L458+b_1
	cmp	#<$e9
	rep	#$20
	longa	on
	beq	L461
	sep	#$20
	longa	off
	lda	<L458+b_1
	cmp	#<$e8
	rep	#$20
	longa	on
	beq	*+5
	brl	L10233
L461:
;		if (sign == 0xAA55 && !memcmp(fs->win + BS_FilSysType32, "FAT32   ", 8)) {
	lda	<L458+sign_1
	cmp	#<$aa55
	bne	L10234
	pea	#<$8
	pea	#^L421
	pea	#<L421
	lda	#$86
	clc
	adc	<L457+fs_0
	sta	<R0
	lda	#$0
	adc	<L457+fs_0+2
	pha
	pei	<R0
	jsr	_~memcmp
	tax
	bne	L10234
;			return 0;	/* It is an FAT32 VBR */
L20057:
	lda	#$0
	bra	L460
;		}
;		/* FAT volumes created in the early MS-DOS era lack BS_55AA and BS_FilSysType, so FAT VBR needs to be identified without them. */
;		w = ld_16(fs->win + BPB_BytsPerSec);
L10234:
	lda	#$3f
	clc
	adc	<L457+fs_0
	sta	<R0
	lda	#$0
	adc	<L457+fs_0+2
	pha
	pei	<R0
	jsr	_~ld_16
	sta	<L458+w_1
;		b = fs->win[BPB_SecPerClus];
	sep	#$20
	longa	off
	ldy	#$41
	lda	[<L457+fs_0],Y
	sta	<L458+b_1
	rep	#$20
	longa	on
;		if ((w & (w - 1)) == 0 && w >= FF_MIN_SS && w <= FF_MAX_SS	/* Properness of sector size (512-4096 and 2^n) */
;			&& b != 0 && (b & (b - 1)) == 0				/* Properness of cluster size (2^n) */
;			&& ld_16(fs->win + BPB_RsvdSecCnt) != 0		/* Properness of number of reserved sectors (MNBZ) */
;			&& (UINT)fs->win[BPB_NumFATs] - 1 <= 1		/* Properness of number of FATs (1 or 2) */
;			&& ld_16(fs->win + BPB_RootEntCnt) != 0		/* Properness of root dir size (MNBZ) */
;			&& (ld_16(fs->win + BPB_TotSec16) >= 128 || ld_32(fs->win + BPB_TotSec32) >= 0x10000)	/* Properness of volume size (>=128) */
;			&& ld_16(fs->win + BPB_FATSz16) != 0) {		/* Properness of FAT size (MNBZ) */
	lda	#$ffff
	clc
	adc	<L458+w_1
	sta	<R0
	lda	<L458+w_1
	and	<R0
	beq	*+5
	brl	L10233
	lda	<L458+w_1
	cmp	#<$200
	bcs	*+5
	brl	L10233
	lda	#$200
	cmp	<L458+w_1
	bcs	*+5
	brl	L10233
	lda	<L458+b_1
	and	#$ff
	bne	*+5
	brl	L10233
	lda	<L458+b_1
	and	#$ff
	sta	<R0
	lda	<L458+b_1
	and	#$ff
	clc
	adc	#$ffff
	and	<R0
	beq	*+5
	brl	L10233
	lda	#$42
	clc
	adc	<L457+fs_0
	sta	<R0
	lda	#$0
	adc	<L457+fs_0+2
	pha
	pei	<R0
	jsr	_~ld_16
	tax
	beq	L10233
	ldy	#$44
	lda	[<L457+fs_0],Y
	and	#$ff
	clc
	adc	#$ffff
	sta	<R2
	lda	#$1
	cmp	<R2
	bcc	L10233
	lda	#$45
	clc
	adc	<L457+fs_0
	sta	<R1
	lda	#$0
	adc	<L457+fs_0+2
	pha
	pei	<R1
	jsr	_~ld_16
	tax
	beq	L10233
	lda	#$47
	clc
	adc	<L457+fs_0
	sta	<R2
	lda	#$0
	adc	<L457+fs_0+2
	pha
	pei	<R2
	jsr	_~ld_16
	cmp	#<$80
	bcs	L475
	lda	#$54
	clc
	adc	<L457+fs_0
	sta	<R3
	lda	#$0
	adc	<L457+fs_0+2
	pha
	pei	<R3
	jsr	_~ld_32
	sta	<17
	stx	<17+2
	cmp	#<$10000
	lda	<17+2
	sbc	#^$10000
	bcc	L10233
L475:
	lda	#$4a
	clc
	adc	<L457+fs_0
	sta	<17
	lda	#$0
	adc	<L457+fs_0+2
	sta	<17+2
	pha
	pei	<17
	jsr	_~ld_16
	tax
	beq	*+5
	brl	L20057
;				return 0;	/* It can be presumed an FAT VBR */
;		}
;	}
;	return sign == 0xAA55 ? 2 : 3;	/* Not an FAT VBR (with valid or invalid BS) */
L10233:
	lda	<L458+sign_1
	cmp	#<$aa55
	bne	L479
	lda	#$2
	brl	L460
L479:
	lda	#$3
	brl	L460
;}
L457	equ	25
L458	equ	21
	ends
	efunc
	data
L421:
	db	$46,$41,$54,$33,$32,$20,$20,$20,$00
	ends
;
;
;/* Find an FAT volume */
;/* (It supports only generic partitioning rules, MBR, GPT and SFD) */
;
;static UINT find_volume (	/* Returns BS status found in the hosting drive */
;	FATFS* fs,		/* Filesystem object */
;	UINT part		/* Partition to fined = 0:find as SFD and partitions, >0:forced partition number */
;)
;{
	code
	func
_~find_volume:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L483
	tcs
	phd
	tcd
fs_0	set	3
part_0	set	7
;	UINT fmt, i;
;	DWORD mbr_pt[4];
;
;
;	fmt = check_fs(fs, 0);				/* Load sector 0 and check if it is an FAT VBR as SFD format */
fmt_1	set	0
i_1	set	2
mbr_pt_1	set	4
	pea	#^$0
	pea	#<$0
	pei	<L483+fs_0+2
	pei	<L483+fs_0
	jsr	_~check_fs
	sta	<L484+fmt_1
;	if (fmt != 2 && (fmt >= 3 || part == 0)) return fmt;	/* Returns if it is an FAT VBR as auto scan, not a BS or disk error */
	cmp	#<$2
	beq	L10236
	lda	<L484+fmt_1
	cmp	#<$3
	bcs	L486
	lda	<L483+part_0
	bne	L10236
L486:
	lda	<L484+fmt_1
	tay
	lda	<L483+1
	sta	<L483+1+6
	pld
	tsc
	clc
	adc	#L483+6
	tcs
	tya
	rts
;
;	/* Sector 0 is not an FAT VBR or forced partition number wants a partitioned drive */
;
;#if FF_LBA64
;	if (fs->win[MBR_Table + PTE_System] == 0xEE) {	/* GPT protective MBR? */
;		DWORD n_ent, v_ent, ofs;
;		QWORD pt_lba;
;
;		if (move_window(fs, 1) != FR_OK) return 4;	/* Load GPT header sector (next to MBR) */
;		if (!test_gpt_header(fs->win)) return 3;	/* Check if GPT header is valid */
;		n_ent = ld_32(fs->win + GPTH_PtNum);		/* Number of entries */
;		pt_lba = ld_64(fs->win + GPTH_PtOfs);		/* Table location */
;		for (v_ent = i = 0; i < n_ent; i++) {		/* Find FAT partition */
;			if (move_window(fs, pt_lba + i * SZ_GPTE / SS(fs)) != FR_OK) return 4;	/* PT sector */
;			ofs = i * SZ_GPTE % SS(fs);												/* Offset in the sector */
;			if (!memcmp(fs->win + ofs + GPTE_PtGuid, GUID_MS_Basic, 16)) {	/* MS basic data partition? */
;				v_ent++;	/* Order of MS BDP */
;				fmt = check_fs(fs, ld_64(fs->win + ofs + GPTE_FstLba));	/* Load VBR and check status */
;				if (part == 0 && fmt <= 1) return fmt;			/* Auto search (valid FAT volume found first) */
;				if (part != 0 && v_ent == part) return fmt;		/* Forced partition order (regardless of it is valid or not) */
;			}
;		}
;		return 3;	/* Not found */
;	}
;#endif
;	if (FF_MULTI_PARTITION && part > 4) return 3;	/* MBR has four primary partitions max (FatFs does not support logical partition) */
L10236:
;	for (i = 0; i < 4; i++) {		/* Load partition offset in the MBR */
	stz	<L484+i_1
L10240:
;		mbr_pt[i] = ld_32(fs->win + MBR_Table + i * SZ_PTE + PTE_StLba);
	lda	<L484+i_1
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	clc
	tdc
	adc	#<L484+mbr_pt_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	<L484+i_1
	asl	A
	asl	A
	asl	A
	asl	A
	sta	<R0
	stz	<R0+2
	lda	#$1fa
	clc
	adc	<R0
	sta	<R2
	lda	#$0
	adc	<R0+2
	sta	<R2+2
	lda	<L483+fs_0
	clc
	adc	<R2
	sta	<R0
	lda	<L483+fs_0+2
	adc	<R2+2
	pha
	pei	<R0
	jsr	_~ld_32
	sta	<17
	stx	<17+2
	sta	[<R3]
	lda	<17+2
	ldy	#$2
	sta	[<R3],Y
;	}
	inc	<L484+i_1
	lda	<L484+i_1
	cmp	#<$4
	bcc	L10240
;	i = part ? part - 1 : 0;		/* Table index to find first */
	lda	<L483+part_0
	beq	L492
	lda	#$ffff
	clc
	adc	<L483+part_0
	bra	L494
L492:
	lda	#$0
L494:
	sta	<L484+i_1
;	do {							/* Find an FAT volume */
L10243:
;		fmt = mbr_pt[i] ? check_fs(fs, mbr_pt[i]) : 3;	/* Check if the partition is FAT */
	lda	<L484+i_1
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	clc
	tdc
	adc	#<L484+mbr_pt_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	ldy	#$2
	ora	[<R3],Y
	beq	L495
	lda	<L484+i_1
	sta	<R2
	stz	<R2+2
	pei	<R2+2
	pei	<R2
	tya
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	clc
	tdc
	adc	#<L484+mbr_pt_1
	sta	<R3
	lda	#$0
	sta	<R3+2
	lda	<R3
	clc
	adc	<R0
	sta	<17
	lda	<R3+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	pei	<L483+fs_0+2
	pei	<L483+fs_0
	jsr	_~check_fs
	bra	L497
L495:
	lda	#$3
L497:
	sta	<L484+fmt_1
;	} while (part == 0 && fmt >= 2 && ++i < 4);
	lda	<L483+part_0
	beq	*+5
	brl	L486
	lda	<L484+fmt_1
	cmp	#<$2
	bcs	*+5
	brl	L486
	inc	<L484+i_1
	lda	<L484+i_1
	cmp	#<$4
	bcs	*+5
	brl	L10243
;	return fmt;
	brl	L486
;}
L483	equ	40
L484	equ	21
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* Determine logical drive number and mount the volume if needed         */
;/*-----------------------------------------------------------------------*/
;
;static FRESULT mount_volume (	/* FR_OK(0): successful, !=0: an error occurred */
;	const TCHAR** path,			/* Pointer to pointer to the path name (drive number) */
;	FATFS** rfs,				/* Pointer to pointer to the found filesystem object */
;	BYTE mode					/* Desiered access mode to check write protection */
;)
;{
	code
	func
_~mount_volume:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L502
	tcs
	phd
	tcd
path_0	set	3
rfs_0	set	7
mode_0	set	11
;	int vol;
;	FATFS *fs;
;	DSTATUS stat;
;	LBA_t bsect;
;	UINT fmt;
;
;
;	/* Get logical drive number */
;	*rfs = 0;
vol_1	set	0
fs_1	set	2
stat_1	set	6
bsect_1	set	7
fmt_1	set	11
	lda	#$0
	sta	[<L502+rfs_0]
	ldy	#$2
	sta	[<L502+rfs_0],Y
;	vol = get_ldnumber(path);
	pei	<L502+path_0+2
	pei	<L502+path_0
	jsr	_~get_ldnumber
	sta	<L503+vol_1
;	if (vol < 0) return FR_INVALID_DRIVE;
	lda	<L503+vol_1
	bpl	L10244
	lda	#$b
L505:
	tay
	lda	<L502+1
	sta	<L502+1+10
	pld
	tsc
	clc
	adc	#L502+10
	tcs
	tya
	rts
;
;	/* Check if the filesystem object is valid or not */
;	fs = FatFs[vol];					/* Get pointer to the filesystem object */
L10244:
	lda	<L503+vol_1
	asl	A
	asl	A
	clc
	adc	#<_~FatFs
	sta	<R1
	lda	(<R1)
	sta	<L503+fs_1
	ldy	#$2
	lda	(<R1),Y
	sta	<L503+fs_1+2
;	if (!fs) return FR_NOT_ENABLED;		/* Is the filesystem object available? */
	lda	<L503+fs_1
	ora	<L503+fs_1+2
	bne	L10245
	lda	#$c
	bra	L505
;#if FF_FS_REENTRANT
;	if (!lock_volume(fs, 1)) return FR_TIMEOUT;	/* Lock the volume, and system if needed */
L10245:
	pea	#<$1
	pei	<L503+fs_1+2
	pei	<L503+fs_1
	jsr	_~lock_volume
	tax
	bne	L10246
	lda	#$f
	bra	L505
;#endif
;	*rfs = fs;							/* Return pointer to the filesystem object */
L10246:
	lda	<L503+fs_1
	sta	[<L502+rfs_0]
	lda	<L503+fs_1+2
	ldy	#$2
	sta	[<L502+rfs_0],Y
;
;	mode &= (BYTE)~FA_READ;				/* Desired access mode, write access or not */
	sep	#$20
	longa	off
	lda	#$1
	trb	<L502+mode_0
	rep	#$20
	longa	on
;	if (fs->fs_type != 0) {				/* If the volume has been mounted */
	lda	[<L503+fs_1]
	and	#$ff
	beq	L10247
;		stat = disk_status(fs->pdrv);
	dey
	lda	[<L503+fs_1],Y
	pha
	jsr	_~disk_status
	sep	#$20
	longa	off
	sta	<L503+stat_1
;		if (!(stat & STA_NOINIT)) {		/* and the physical drive is kept initialized */
	and	#<$1
	rep	#$20
	longa	on
	bne	L10247
;			if (!FF_FS_READONLY && mode && (stat & STA_PROTECT)) {	/* Check write protection if needed */
	lda	<L502+mode_0
	and	#$ff
	bne	*+5
	brl	L10249
	sep	#$20
	longa	off
	lda	<L503+stat_1
	and	#<$4
	rep	#$20
	longa	on
	bne	*+5
	brl	L10249
;				return FR_WRITE_PROTECTED;
L20058:
	lda	#$a
	brl	L505
;			}
;			return FR_OK;				/* The filesystem object is already valid */
;		}
;	}
;
;	/* The filesystem object is not valid. */
;	/* Following code attempts to mount the volume. (find an FAT volume, analyze the BPB and initialize the filesystem object) */
;
;	fs->fs_type = 0;					/* Invalidate the filesystem object */
L10247:
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L503+fs_1]
	rep	#$20
	longa	on
;	stat = disk_initialize(fs->pdrv);	/* Initialize the volume hosting physical drive */
	ldy	#$1
	lda	[<L503+fs_1],Y
	pha
	jsr	_~disk_initialize
	sep	#$20
	longa	off
	sta	<L503+stat_1
;	if (stat & STA_NOINIT) { 			/* Check if the initialization succeeded */
	and	#<$1
	rep	#$20
	longa	on
	beq	L10250
;		return FR_NOT_READY;			/* Failed to initialize due to no medium or hard error */
	lda	#$3
	brl	L505
;	}
;	if (!FF_FS_READONLY && mode && (stat & STA_PROTECT)) { /* Check disk write protection if needed */
L10250:
	lda	<L502+mode_0
	and	#$ff
	beq	L10251
	sep	#$20
	longa	off
	lda	<L503+stat_1
	and	#<$4
	rep	#$20
	longa	on
	bne	L20058
;		return FR_WRITE_PROTECTED;
;	}
;#if FF_MAX_SS != FF_MIN_SS				/* Get sector size (multiple sector size cfg only) */
;	if (disk_ioctl(fs->pdrv, GET_SECTOR_SIZE, &SS(fs)) != RES_OK) return FR_DISK_ERR;
;	if (SS(fs) > FF_MAX_SS || SS(fs) < FF_MIN_SS || (SS(fs) & (SS(fs) - 1))) return FR_DISK_ERR;
;#endif
;
;	/* Find an FAT volume on the hosting drive */
;	fmt = find_volume(fs, LD2PT(vol));
L10251:
	pea	#<$0
	pei	<L503+fs_1+2
	pei	<L503+fs_1
	jsr	_~find_volume
	sta	<L503+fmt_1
;	if (fmt == 4) return FR_DISK_ERR;		/* An error occurred in the disk I/O layer */
	cmp	#<$4
	bne	L10252
	lda	#$1
	brl	L505
;	if (fmt >= 2) return FR_NO_FILESYSTEM;	/* No FAT volume is found */
L10252:
	lda	<L503+fmt_1
	cmp	#<$2
	bcc	L10253
L20059:
	lda	#$d
	brl	L505
;	bsect = fs->winsect;					/* Volume offset in the hosting physical drive */
L10253:
	ldy	#$20
	lda	[<L503+fs_1],Y
	sta	<L503+bsect_1
	iny
	iny
	lda	[<L503+fs_1],Y
	sta	<L503+bsect_1+2
;
;	/* An FAT volume is found (bsect). Following code initializes the filesystem object */
;
;#if FF_FS_EXFAT
;	if (fmt == 1) {
;		QWORD maxlba;
;		DWORD so, cv, bcl, ncl, i;
;
;		for (i = BPB_ZeroedEx; i < BPB_ZeroedEx + 53 && fs->win[i] == 0; i++) ;	/* Check zero filler */
;		if (i < BPB_ZeroedEx + 53) return FR_NO_FILESYSTEM;
;
;		if (ld_16(fs->win + BPB_FSVerEx) != 0x100) return FR_NO_FILESYSTEM;	/* Check exFAT version (must be version 1.0) */
;
;		if (1 << fs->win[BPB_BytsPerSecEx] != SS(fs)) {	/* (BPB_BytsPerSecEx must be equal to the physical sector size) */
;			return FR_NO_FILESYSTEM;
;		}
;
;		maxlba = ld_64(fs->win + BPB_TotSecEx) + bsect;	/* Last LBA of the volume + 1 */
;		if (!FF_LBA64 && maxlba >= 0x100000000) return FR_NO_FILESYSTEM;	/* (It cannot be accessed in 32-bit LBA) */
;
;		fs->fsize = ld_32(fs->win + BPB_FatSzEx);		/* Number of sectors per FAT */
;
;		fs->n_fats = fs->win[BPB_NumFATsEx];			/* Number of FATs */
;		if (fs->n_fats != 1) return FR_NO_FILESYSTEM;	/* (Supports only 1 FAT) */
;
;		fs->csize = 1 << fs->win[BPB_SecPerClusEx];		/* Cluster size */
;		if (fs->csize == 0)	return FR_NO_FILESYSTEM;	/* (Must be 1..32768 sectors) */
;
;		ncl = ld_32(fs->win + BPB_NumClusEx);			/* Number of clusters */
;		if (ncl > MAX_EXFAT) return FR_NO_FILESYSTEM;	/* (Too many clusters) */
;		fs->n_fatent = ncl + 2;
;
;		/* Boundaries and Limits */
;		fs->volbase = bsect;
;		fs->database = bsect + ld_32(fs->win + BPB_DataOfsEx);
;		fs->fatbase = bsect + ld_32(fs->win + BPB_FatOfsEx);
;		if (maxlba < (QWORD)fs->database + ncl * fs->csize) return FR_NO_FILESYSTEM;	/* (Volume size must not be smaller than the size required) */
;		fs->dirbase = ld_32(fs->win + BPB_RootClusEx);
;
;		/* Get bitmap location and check if it is contiguous (implementation assumption) */
;		so = i = 0;
;		for (;;) {	/* Find the bitmap entry in the root directory (in only first cluster) */
;			if (i == 0) {
;				if (so >= fs->csize) return FR_NO_FILESYSTEM;	/* Not found? */
;				if (move_window(fs, clst2sect(fs, (DWORD)fs->dirbase) + so) != FR_OK) return FR_DISK_ERR;
;				so++;
;			}
;			if (fs->win[i] == ET_BITMAP) break;		/* Is it a bitmap entry? */
;			i = (i + SZDIRE) % SS(fs);	/* Next entry */
;		}
;		bcl = ld_32(fs->win + i + 20);				/* Bitmap cluster */
;		if (bcl < 2 || bcl >= fs->n_fatent) return FR_NO_FILESYSTEM;	/* (Wrong cluster#) */
;		fs->bitbase = fs->database + fs->csize * (bcl - 2);	/* Bitmap sector */
;		for (;;) {	/* Check if bitmap is contiguous */
;			if (move_window(fs, fs->fatbase + bcl / (SS(fs) / 4)) != FR_OK) return FR_DISK_ERR;
;			cv = ld_32(fs->win + bcl % (SS(fs) / 4) * 4);
;			if (cv == 0xFFFFFFFF) break;				/* Last link? */
;			if (cv != ++bcl) return FR_NO_FILESYSTEM;	/* Fragmented bitmap? */
;		}
;#if !FF_FS_READONLY
;		fs->last_clst = fs->free_clst = 0xFFFFFFFF;		/* Invalidate cluster allocation information */
;		fs->fsi_flag = 0;	/* Enable to sync PercInUse value in VBR */
;#endif
;		fmt = FS_EXFAT;			/* FAT sub-type */
;	} else
;#endif	/* FF_FS_EXFAT */
;	{
;		DWORD tsect, sysect, fasize, nclst, szbfat;
;		WORD nrsv;
;
;		if (ld_16(fs->win + BPB_BytsPerSec) != SS(fs)) return FR_NO_FILESYSTEM;	/* (BPB_BytsPerSec must be equal to the physical sector size) */
tsect_2	set	13
sysect_2	set	17
fasize_2	set	21
nclst_2	set	25
szbfat_2	set	29
nrsv_2	set	33
	lda	#$3f
	clc
	adc	<L503+fs_1
	sta	<R0
	lda	#$0
	adc	<L503+fs_1+2
	pha
	pei	<R0
	jsr	_~ld_16
	cmp	#<$200
	bne	L20059
;
;		fasize = ld_16(fs->win + BPB_FATSz16);		/* Number of sectors per FAT */
	lda	#$4a
	clc
	adc	<L503+fs_1
	sta	<R0
	lda	#$0
	adc	<L503+fs_1+2
	pha
	pei	<R0
	jsr	_~ld_16
	sta	<L503+fasize_2
	stz	<L503+fasize_2+2
;		if (fasize == 0) fasize = ld_32(fs->win + BPB_FATSz32);
	lda	<L503+fasize_2
	ora	<L503+fasize_2+2
	bne	L10255
	lda	#$58
	clc
	adc	<L503+fs_1
	sta	<R0
	lda	#$0
	adc	<L503+fs_1+2
	pha
	pei	<R0
	jsr	_~ld_32
	sta	<L503+fasize_2
	stx	<L503+fasize_2+2
;		fs->fsize = fasize;
L10255:
	lda	<L503+fasize_2
	ldy	#$1c
	sta	[<L503+fs_1],Y
	lda	<L503+fasize_2+2
	iny
	iny
	sta	[<L503+fs_1],Y
;
;		fs->n_fats = fs->win[BPB_NumFATs];				/* Number of FATs */
	sep	#$20
	longa	off
	ldy	#$44
	lda	[<L503+fs_1],Y
	ldy	#$3
	sta	[<L503+fs_1],Y
;		if (fs->n_fats != 1 && fs->n_fats != 2) return FR_NO_FILESYSTEM;	/* (Must be 1 or 2) */
	cmp	#<$1
	rep	#$20
	longa	on
	beq	L10256
	sep	#$20
	longa	off
	lda	[<L503+fs_1],Y
	cmp	#<$2
	rep	#$20
	longa	on
	beq	*+5
	brl	L20059
;		fasize *= fs->n_fats;							/* Number of sectors for FAT area */
L10256:
	ldy	#$3
	lda	[<L503+fs_1],Y
	and	#$ff
	sta	<R0
	stz	<R0+2
	pei	<L503+fasize_2+2
	pei	<L503+fasize_2
	pei	<R0+2
	pei	<R0
	xref	_~~lmul
	jsr	_~~lmul
	sta	<L503+fasize_2
	stx	<L503+fasize_2+2
;
;		fs->csize = fs->win[BPB_SecPerClus];			/* Cluster size */
	ldy	#$41
	lda	[<L503+fs_1],Y
	and	#$ff
	ldy	#$a
	sta	[<L503+fs_1],Y
;		if (fs->csize == 0 || (fs->csize & (fs->csize - 1))) return FR_NO_FILESYSTEM;	/* (Must be power of 2) */
	lda	[<L503+fs_1],Y
	bne	*+5
	brl	L20059
	lda	#$ffff
	clc
	adc	[<L503+fs_1],Y
	sta	<R0
	lda	[<L503+fs_1],Y
	and	<R0
	beq	*+5
	brl	L20059
;
;		fs->n_rootdir = ld_16(fs->win + BPB_RootEntCnt);	/* Number of root directory entries */
	lda	#$45
	clc
	adc	<L503+fs_1
	sta	<R0
	lda	#$0
	adc	<L503+fs_1+2
	pha
	pei	<R0
	jsr	_~ld_16
	ldy	#$8
	sta	[<L503+fs_1],Y
;		if (fs->n_rootdir % (SS(fs) / SZDIRE)) return FR_NO_FILESYSTEM;	/* (Must be sector aligned) */
	and	#<$f
	beq	*+5
	brl	L20059
;
;		tsect = ld_16(fs->win + BPB_TotSec16);			/* Number of sectors on the volume */
	lda	#$47
	clc
	adc	<L503+fs_1
	sta	<R0
	lda	#$0
	adc	<L503+fs_1+2
	pha
	pei	<R0
	jsr	_~ld_16
	sta	<L503+tsect_2
	stz	<L503+tsect_2+2
;		if (tsect == 0) tsect = ld_32(fs->win + BPB_TotSec32);
	lda	<L503+tsect_2
	ora	<L503+tsect_2+2
	bne	L10259
	lda	#$54
	clc
	adc	<L503+fs_1
	sta	<R0
	lda	#$0
	adc	<L503+fs_1+2
	pha
	pei	<R0
	jsr	_~ld_32
	sta	<L503+tsect_2
	stx	<L503+tsect_2+2
;
;		nrsv = ld_16(fs->win + BPB_RsvdSecCnt);			/* Number of reserved sectors */
L10259:
	lda	#$42
	clc
	adc	<L503+fs_1
	sta	<R0
	lda	#$0
	adc	<L503+fs_1+2
	pha
	pei	<R0
	jsr	_~ld_16
	sta	<L503+nrsv_2
;		if (nrsv == 0) return FR_NO_FILESYSTEM;			/* (Must not be 0) */
	lda	<L503+nrsv_2
	bne	*+5
	brl	L20059
;
;		/* Determine the FAT sub type */
;		sysect = nrsv + fasize + fs->n_rootdir / (SS(fs) / SZDIRE);	/* RSV + FAT + DIR */
	ldy	#$8
	lda	[<L503+fs_1],Y
	lsr	A
	lsr	A
	lsr	A
	lsr	A
	sta	<R0
	stz	<R0+2
	lda	<L503+nrsv_2
	sta	<R1
	stz	<R1+2
	lda	<R1
	clc
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<L503+fasize_2
	sta	<L503+sysect_2
	lda	<R2+2
	adc	<L503+fasize_2+2
	sta	<L503+sysect_2+2
;		if (tsect < sysect) return FR_NO_FILESYSTEM;	/* (Invalid volume size) */
	lda	<L503+tsect_2
	cmp	<L503+sysect_2
	lda	<L503+tsect_2+2
	sbc	<L503+sysect_2+2
	bcs	*+5
	brl	L20059
;		nclst = (tsect - sysect) / fs->csize;			/* Number of clusters */
	iny
	iny
	lda	[<L503+fs_1],Y
	sta	<R0
	stz	<R0+2
	sec
	lda	<L503+tsect_2
	sbc	<L503+sysect_2
	sta	<R1
	lda	<L503+tsect_2+2
	sbc	<L503+sysect_2+2
	sta	<R1+2
	pei	<R0+2
	pei	<R0
	pei	<R1+2
	pei	<R1
	xref	_~~ludv
	jsr	_~~ludv
	sta	<L503+nclst_2
	stx	<L503+nclst_2+2
;		if (nclst == 0) return FR_NO_FILESYSTEM;		/* (Invalid volume size) */
	ora	<L503+nclst_2+2
	bne	*+5
	brl	L20059
;		fmt = 0;
	stz	<L503+fmt_1
;		if (nclst <= MAX_FAT32) fmt = FS_FAT32;
	lda	#$fff5
	cmp	<L503+nclst_2
	lda	#$fff
	sbc	<L503+nclst_2+2
	bcc	L10263
	lda	#$3
	sta	<L503+fmt_1
;		if (nclst <= MAX_FAT16) fmt = FS_FAT16;
L10263:
	lda	#$fff5
	cmp	<L503+nclst_2
	lda	#$0
	sbc	<L503+nclst_2+2
	bcc	L10264
	lda	#$2
	sta	<L503+fmt_1
;		if (nclst <= MAX_FAT12) fmt = FS_FAT12;
L10264:
	lda	#$ff5
	cmp	<L503+nclst_2
	lda	#$0
	sbc	<L503+nclst_2+2
	bcc	L10265
	lda	#$1
	sta	<L503+fmt_1
;		if (fmt == 0) return FR_NO_FILESYSTEM;
L10265:
	lda	<L503+fmt_1
	bne	*+5
	brl	L20059
;
;		/* Boundaries and Limits */
;		fs->n_fatent = nclst + 2;						/* Number of FAT entries */
	lda	#$2
	clc
	adc	<L503+nclst_2
	sta	<R0
	lda	#$0
	adc	<L503+nclst_2+2
	sta	<R0+2
	lda	<R0
	ldy	#$18
	sta	[<L503+fs_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L503+fs_1],Y
;		fs->volbase = bsect;							/* Volume start sector */
	lda	<L503+bsect_1
	ldy	#$24
	sta	[<L503+fs_1],Y
	lda	<L503+bsect_1+2
	iny
	iny
	sta	[<L503+fs_1],Y
;		fs->fatbase = bsect + nrsv; 					/* FAT start sector */
	lda	<L503+nrsv_2
	sta	<R0
	stz	<R0+2
	lda	<R0
	clc
	adc	<L503+bsect_1
	sta	<R1
	lda	<R0+2
	adc	<L503+bsect_1+2
	sta	<R1+2
	lda	<R1
	iny
	iny
	sta	[<L503+fs_1],Y
	lda	<R1+2
	iny
	iny
	sta	[<L503+fs_1],Y
;		fs->database = bsect + sysect;					/* Data start sector */
	lda	<L503+bsect_1
	clc
	adc	<L503+sysect_2
	sta	<R0
	lda	<L503+bsect_1+2
	adc	<L503+sysect_2+2
	sta	<R0+2
	lda	<R0
	ldy	#$30
	sta	[<L503+fs_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L503+fs_1],Y
;		if (fmt == FS_FAT32) {
	lda	<L503+fmt_1
	cmp	#<$3
	bne	L10267
;			if (ld_16(fs->win + BPB_FSVer32) != 0) return FR_NO_FILESYSTEM;	/* (Must be FAT32 revision 0.0) */
	lda	#$5e
	clc
	adc	<L503+fs_1
	sta	<R0
	lda	#$0
	adc	<L503+fs_1+2
	pha
	pei	<R0
	jsr	_~ld_16
	tax
	beq	*+5
	brl	L20059
;			if (fs->n_rootdir != 0) return FR_NO_FILESYSTEM;	/* (BPB_RootEntCnt must be 0) */
	ldy	#$8
	lda	[<L503+fs_1],Y
	beq	*+5
	brl	L20059
;			fs->dirbase = ld_32(fs->win + BPB_RootClus32);	/* Root directory start cluster */
	lda	#$60
	clc
	adc	<L503+fs_1
	sta	<R0
	lda	#$0
	adc	<L503+fs_1+2
	pha
	pei	<R0
	jsr	_~ld_32
	stx	<R1+2
	ldy	#$2c
	sta	[<L503+fs_1],Y
	lda	<R1+2
	iny
	iny
	sta	[<L503+fs_1],Y
;			szbfat = fs->n_fatent * 4;					/* (Needed FAT size) */
	ldy	#$1a
	lda	[<L503+fs_1],Y
	pha
	dey
	dey
	lda	[<L503+fs_1],Y
	pha
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<L503+szbfat_2
	stx	<L503+szbfat_2+2
;		} else {
	brl	L10270
L10267:
;			if (fs->n_rootdir == 0)	return FR_NO_FILESYSTEM;	/* (BPB_RootEntCnt must not be 0) */
	ldy	#$8
	lda	[<L503+fs_1],Y
	bne	*+5
	brl	L20059
;			fs->dirbase = fs->fatbase + fasize;			/* Root directory start sector */
	clc
	ldy	#$28
	lda	[<L503+fs_1],Y
	adc	<L503+fasize_2
	sta	<R0
	iny
	iny
	lda	[<L503+fs_1],Y
	adc	<L503+fasize_2+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L503+fs_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L503+fs_1],Y
;			szbfat = (fmt == FS_FAT16) ?				/* (Needed FAT size) */
;				fs->n_fatent * 2 : fs->n_fatent * 3 / 2 + (fs->n_fatent & 1);
	lda	<L503+fmt_1
	cmp	#<$2
	bne	L537
	ldy	#$1a
	lda	[<L503+fs_1],Y
	pha
	dey
	dey
	lda	[<L503+fs_1],Y
	pha
	lda	#$1
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	ldx	<R0+2
	lda	<R0
	bra	L539
L537:
	ldy	#$18
	lda	[<L503+fs_1],Y
	and	#<$1
	sta	<R0
	stz	<R0+2
	pea	#^$3
	pea	#<$3
	iny
	iny
	lda	[<L503+fs_1],Y
	pha
	dey
	dey
	lda	[<L503+fs_1],Y
	pha
	xref	_~~lmul
	jsr	_~~lmul
	sta	<R2
	stx	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$1
	xref	_~~llsr
	jsr	_~~llsr
	stx	<R1+2
	clc
	adc	<R0
	sta	<R3
	lda	<R1+2
	adc	<R0+2
	sta	<R3+2
	ldx	<R3+2
	lda	<R3
L539:
	stx	<R0+2
	sta	<L503+szbfat_2
	lda	<R0+2
	sta	<L503+szbfat_2+2
;		}
L10270:
;		if (fs->fsize < (szbfat + (SS(fs) - 1)) / SS(fs)) return FR_NO_FILESYSTEM;	/* (BPB_FATSz must not be less than the size needed) */
	lda	#$1ff
	clc
	adc	<L503+szbfat_2
	sta	<R1
	lda	#$0
	adc	<L503+szbfat_2+2
	pha
	pei	<R1
	lda	#$9
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R0
	stx	<R0+2
	ldy	#$1c
	lda	[<L503+fs_1],Y
	cmp	<R0
	iny
	iny
	lda	[<L503+fs_1],Y
	sbc	<R0+2
	bcs	*+5
	brl	L20059
;
;#if !FF_FS_READONLY
;		/* Get FSInfo if available */
;		fs->last_clst = fs->free_clst = 0xFFFFFFFF;		/* Invalidate cluster allocation information */
	lda	#$ffff
	ldy	#$10
	sta	[<L503+fs_1],Y
	iny
	iny
	sta	[<L503+fs_1],Y
	ldy	#$c
	sta	[<L503+fs_1],Y
	iny
	iny
	sta	[<L503+fs_1],Y
;		fs->fsi_flag = 0x80;	/* Disable FSInfo by default */
	sep	#$20
	longa	off
	lda	#$80
	ldy	#$5
	sta	[<L503+fs_1],Y
	rep	#$20
	longa	on
;		if (fmt == FS_FAT32
;			&& ld_16(fs->win + BPB_FSInfo32) == 1	/* FAT32: Enable FSInfo feature only if FSInfo sector is next to VBR */
;			&& move_window(fs, bsect + 1) == FR_OK)
;		{
	lda	<L503+fmt_1
	cmp	#<$3
	beq	*+5
	brl	L10273
	lda	#$64
	clc
	adc	<L503+fs_1
	sta	<R0
	lda	#$0
	adc	<L503+fs_1+2
	pha
	pei	<R0
	jsr	_~ld_16
	cmp	#<$1
	beq	*+5
	brl	L10273
	lda	#$1
	clc
	adc	<L503+bsect_1
	sta	<R1
	lda	#$0
	adc	<L503+bsect_1+2
	sta	<R1+2
	pha
	pei	<R1
	pei	<L503+fs_1+2
	pei	<L503+fs_1
	jsr	_~move_window
	tax
	beq	*+5
	brl	L10273
;			fs->fsi_flag = 0;
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$5
	sta	[<L503+fs_1],Y
	rep	#$20
	longa	on
;			if (   ld_32(fs->win + FSI_LeadSig) == 0x41615252	/* Load FSInfo data if available */
;				&& ld_32(fs->win + FSI_StrucSig) == 0x61417272
;				&& ld_32(fs->win + FSI_TrailSig) == 0xAA550000)
;			{
	lda	#$34
	clc
	adc	<L503+fs_1
	sta	<R0
	lda	#$0
	adc	<L503+fs_1+2
	pha
	pei	<R0
	jsr	_~ld_32
	stx	<R1+2
	cmp	#<$41615252
	bne	L544
	lda	<R1+2
	cmp	#^$41615252
L544:
	beq	*+5
	brl	L10273
	lda	#$218
	clc
	adc	<L503+fs_1
	sta	<R1
	lda	#$0
	adc	<L503+fs_1+2
	pha
	pei	<R1
	jsr	_~ld_32
	stx	<R2+2
	cmp	#<$61417272
	bne	L546
	lda	<R2+2
	cmp	#^$61417272
L546:
	bne	L10273
	lda	#$230
	clc
	adc	<L503+fs_1
	sta	<R2
	lda	#$0
	adc	<L503+fs_1+2
	pha
	pei	<R2
	jsr	_~ld_32
	stx	<R3+2
	cmp	#<$aa550000
	bne	L548
	lda	<R3+2
	cmp	#^$aa550000
L548:
	bne	L10273
;#if (FF_FS_NOFSINFO & 1) == 0	/* Get free cluster count if trust it */
;				fs->free_clst = ld_32(fs->win + FSI_Free_Count);
	lda	#$21c
	clc
	adc	<L503+fs_1
	sta	<R0
	lda	#$0
	adc	<L503+fs_1+2
	pha
	pei	<R0
	jsr	_~ld_32
	stx	<R1+2
	ldy	#$10
	sta	[<L503+fs_1],Y
	lda	<R1+2
	iny
	iny
	sta	[<L503+fs_1],Y
;#endif
;#if (FF_FS_NOFSINFO & 2) == 0	/* Get next free cluster if rtust it */
;				fs->last_clst = ld_32(fs->win + FSI_Nxt_Free);
	lda	#$220
	clc
	adc	<L503+fs_1
	sta	<R0
	lda	#$0
	adc	<L503+fs_1+2
	pha
	pei	<R0
	jsr	_~ld_32
	stx	<R1+2
	ldy	#$c
	sta	[<L503+fs_1],Y
	lda	<R1+2
	iny
	iny
	sta	[<L503+fs_1],Y
;#endif
;			}
;		}
;#endif	/* !FF_FS_READONLY */
;	}
L10273:
;
;	fs->fs_type = (BYTE)fmt;/* FAT sub-type (the filesystem object gets valid) */
	sep	#$20
	longa	off
	lda	<L503+fmt_1
	sta	[<L503+fs_1]
	rep	#$20
	longa	on
;	fs->id = ++Fsid;		/* Volume mount ID */
	inc	|_~Fsid
	lda	|_~Fsid
	ldy	#$6
	sta	[<L503+fs_1],Y
;
;#if FF_USE_LFN == 1			/* Initilize pointers to the static working buffers */
;	fs->lfnbuf = LfnBuf;	/* LFN working buffer */
;#if FF_FS_EXFAT
;	fs->dirbuf = DirBuf;	/* Directory block scratchpad buuffer */
;#endif
;#endif
;
;#if FF_FS_RPATH				/* Set the current directory top layer (root) */
;	fs->cdir = 0;
	lda	#$0
	ldy	#$14
	sta	[<L503+fs_1],Y
	iny
	iny
	sta	[<L503+fs_1],Y
;#if FF_FS_EXFAT
;	memset(&fs->xcwds, 0, sizeof fs->xcwds);
;#endif
;#endif
;
;#if FF_FS_LOCK				/* Clear file lock semaphores */
;	clear_share(fs);
	pei	<L503+fs_1+2
	pei	<L503+fs_1
	jsr	_~clear_share
;#endif
;
;	return FR_OK;
L10249:
	lda	#$0
	brl	L505
;}
L502	equ	51
L503	equ	17
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* Check if the file/directory object is valid or not                    */
;/*-----------------------------------------------------------------------*/
;
;static FRESULT validate (	/* Returns FR_OK or FR_INVALID_OBJECT */
;	FFOBJID* obj,			/* Pointer to the FFOBJID, the 1st member in the FIL/DIR structure, to check validity */
;	FATFS** rfs				/* Pointer to pointer to the owner filesystem object to return */
;)
;{
	code
	func
_~validate:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L550
	tcs
	phd
	tcd
obj_0	set	3
rfs_0	set	7
;	FRESULT res = FR_INVALID_OBJECT;
;
;
;	if (obj && obj->fs && obj->fs->fs_type && obj->id == obj->fs->id) {	/* Test if the object is valid */
res_1	set	0
	lda	#$9
	sta	<L551+res_1
	lda	<L550+obj_0
	ora	<L550+obj_0+2
	beq	L10275
	lda	[<L550+obj_0]
	ldy	#$2
	ora	[<L550+obj_0],Y
	beq	L10275
	lda	[<L550+obj_0]
	sta	<R0
	lda	[<L550+obj_0],Y
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	beq	L10275
	lda	[<L550+obj_0]
	sta	<R0
	lda	[<L550+obj_0],Y
	sta	<R0+2
	iny
	iny
	lda	[<L550+obj_0],Y
	iny
	iny
	cmp	[<R0],Y
	bne	L10275
;#if FF_FS_REENTRANT
;		if (lock_volume(obj->fs, 0)) {	/* Take a grant to access the volume */
	pea	#<$0
	ldy	#$2
	lda	[<L550+obj_0],Y
	pha
	lda	[<L550+obj_0]
	pha
	jsr	_~lock_volume
	tax
	beq	L10276
;			if (!(disk_status(obj->fs->pdrv) & STA_NOINIT)) { /* Test if the hosting physical drive is kept initialized */
	lda	[<L550+obj_0]
	sta	<R0
	ldy	#$2
	lda	[<L550+obj_0],Y
	sta	<R0+2
	dey
	lda	[<R0],Y
	pha
	jsr	_~disk_status
	sep	#$20
	longa	off
	and	#<$1
	rep	#$20
	longa	on
	bne	L10277
;				res = FR_OK;
	stz	<L551+res_1
;			} else {
	bra	L10275
L10277:
;				unlock_volume(obj->fs, FR_OK);	/* Invalidated volume, abort to access */
	pea	#<$0
	ldy	#$2
	lda	[<L550+obj_0],Y
	pha
	lda	[<L550+obj_0]
	pha
	jsr	_~unlock_volume
;			}
;		} else {	/* Could not take */
	bra	L10275
L10276:
;			res = FR_TIMEOUT;
	lda	#$f
	sta	<L551+res_1
;		}
;#else
;		if (!(disk_status(obj->fs->pdrv) & STA_NOINIT)) { /* Test if the hosting physical drive is kept initialized */
;			res = FR_OK;
;		}
;#endif
;	}
;	*rfs = (res == FR_OK) ? obj->fs : 0;	/* Return corresponding filesystem object if it is valid */
L10275:
	lda	<L551+res_1
	bne	L558
	ldy	#$2
	lda	[<L550+obj_0],Y
	tax
	lda	[<L550+obj_0]
	bra	L560
L558:
	lda	#$0
	tax
L560:
	stx	<R0+2
	sta	[<L550+rfs_0]
	lda	<R0+2
	ldy	#$2
	sta	[<L550+rfs_0],Y
;	return res;
	lda	<L551+res_1
	tay
	lda	<L550+1
	sta	<L550+1+8
	pld
	tsc
	clc
	adc	#L550+8
	tcs
	tya
	rts
;}
L550	equ	6
L551	equ	5
	ends
	efunc
;
;
;
;
;/*---------------------------------------------------------------------------
;
;   Public Functions (FatFs API)
;
;----------------------------------------------------------------------------*/
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Mount/Unmount a Logical Drive                                    */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_mount (
;	FATFS* fs,			/* Pointer to the filesystem object to be registered (NULL:unmount)*/
;	const TCHAR* path,	/* Logical drive number to be mounted/unmounted */
;	BYTE opt			/* Mount option: 0=Do not mount (delayed mount), 1=Mount immediately */
;)
;{
	code
	xdef	_~f_mount
	func
_~f_mount:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L562
	tcs
	phd
	tcd
fs_0	set	3
path_0	set	7
opt_0	set	11
;	FATFS *cfs;
;	int vol;
;	FRESULT res;
;	const TCHAR *rp = path;
;
;
;	/* Get volume ID (logical drive number) */
;	vol = get_ldnumber(&rp);
cfs_1	set	0
vol_1	set	4
res_1	set	6
rp_1	set	8
	lda	<L562+path_0
	sta	<L563+rp_1
	lda	<L562+path_0+2
	sta	<L563+rp_1+2
	pea	#0
	clc
	tdc
	adc	#<L563+rp_1
	pha
	jsr	_~get_ldnumber
	sta	<L563+vol_1
;	if (vol < 0) return FR_INVALID_DRIVE;
	lda	<L563+vol_1
	bpl	L10280
	lda	#$b
L565:
	tay
	lda	<L562+1
	sta	<L562+1+10
	pld
	tsc
	clc
	adc	#L562+10
	tcs
	tya
	rts
;
;	cfs = FatFs[vol];			/* Pointer to the filesystem object of the volume */
L10280:
	lda	<L563+vol_1
	asl	A
	asl	A
	clc
	adc	#<_~FatFs
	sta	<R1
	lda	(<R1)
	sta	<L563+cfs_1
	ldy	#$2
	lda	(<R1),Y
	sta	<L563+cfs_1+2
;	if (cfs) {					/* Unregister current filesystem object */
	lda	<L563+cfs_1
	ora	<L563+cfs_1+2
	beq	L10281
;		FatFs[vol] = 0;
	lda	<L563+vol_1
	asl	A
	asl	A
	clc
	adc	#<_~FatFs
	sta	<R1
	lda	#$0
	sta	(<R1)
	sta	(<R1),Y
;#if FF_FS_LOCK					/* Clear file lock semaphores correspond to this volume */
;		clear_share(cfs);
	pei	<L563+cfs_1+2
	pei	<L563+cfs_1
	jsr	_~clear_share
;#endif
;#if FF_FS_REENTRANT				/* Discard mutex of the current volume */
;		ff_mutex_delete(vol);
	pei	<L563+vol_1
	jsr	_~ff_mutex_delete
;#endif
;		cfs->fs_type = 0;		/* Invalidate the filesystem object to be unregistered */
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L563+cfs_1]
	rep	#$20
	longa	on
;	}
;
;	if (fs) {					/* Register new filesystem object */
L10281:
	lda	<L562+fs_0
	ora	<L562+fs_0+2
	beq	L10282
;		fs->pdrv = LD2PD(vol);	/* Volume hosting physical drive */
	sep	#$20
	longa	off
	lda	<L563+vol_1
	ldy	#$1
	sta	[<L562+fs_0],Y
;#if FF_FS_REENTRANT				/* Create a volume mutex */
;		fs->ldrv = (BYTE)vol;	/* Owner volume ID */
	lda	<L563+vol_1
	iny
	sta	[<L562+fs_0],Y
	rep	#$20
	longa	on
;		if (!ff_mutex_create(vol)) return FR_INT_ERR;
	pei	<L563+vol_1
	jsr	_~ff_mutex_create
	tax
	beq	L20060
	sep	#$20
	longa	off
	lda	|_~SysLock	; volatile
	rep	#$20
	longa	on
	and	#$ff
	bne	L10284
;			if (!ff_mutex_create(FF_VOLUMES)) {
	pea	#<$1
	jsr	_~ff_mutex_create
	tax
	beq	L20062
;			}
;			SysLock = 1;		/* System mutex is ready */
	sep	#$20
	longa	off
	lda	#$1
	sta	|_~SysLock	; volatile
	rep	#$20
	longa	on
;		}
;#endif
;#endif
;		fs->fs_type = 0;		/* Invalidate the new filesystem object */
L10284:
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L562+fs_0]
	rep	#$20
	longa	on
;		FatFs[vol] = fs;		/* Register it */
	lda	<L563+vol_1
	asl	A
	asl	A
	clc
	adc	#<_~FatFs
	sta	<R1
	lda	<L562+fs_0
	sta	(<R1)
	lda	<L562+fs_0+2
	ldy	#$2
	sta	(<R1),Y
;	}
;
;	if (opt == 0) return FR_OK;	/* Do not mount now, it will be mounted in subsequent file functions */
L10282:
	lda	<L562+opt_0
	and	#$ff
	bne	L10286
	lda	#$0
	brl	L565
L20062:
;				ff_mutex_delete(vol);
	pei	<L563+vol_1
	jsr	_~ff_mutex_delete
;				return FR_INT_ERR;
L20060:
	lda	#$2
	brl	L565
;#if FF_FS_LOCK
;		if (SysLock == 0) {		/* Create a system mutex if needed */
;
;	res = mount_volume(&path, &fs, 0);	/* Force mounted the volume in this function */
L10286:
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L562+fs_0
	pha
	pea	#0
	clc
	tdc
	adc	#<L562+path_0
	pha
	jsr	_~mount_volume
	sta	<L563+res_1
;	LEAVE_FF(fs, res);
	pha
	pei	<L562+fs_0+2
	pei	<L562+fs_0
	jsr	_~unlock_volume
	lda	<L563+res_1
	brl	L565
;}
L562	equ	20
L563	equ	9
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Open or Create a File                                            */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_open (
;	FIL* fp,			/* Pointer to the blank file object */
;	const TCHAR* path,	/* Pointer to the file name */
;	BYTE mode			/* Access mode and open mode flags */
;)
;{
	code
	xdef	_~f_open
	func
_~f_open:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L572
	tcs
	phd
	tcd
fp_0	set	3
path_0	set	7
mode_0	set	11
;	FRESULT res;
;	DIR dj;
;	FATFS *fs;
;	DEF_NAMEBUFF
;
;
;	if (!fp) return FR_INVALID_OBJECT;	/* Reject null pointer */
res_1	set	0
dj_1	set	2
fs_1	set	52
	lda	<L572+fp_0
	ora	<L572+fp_0+2
	bne	L10287
	lda	#$9
L575:
	tay
	lda	<L572+1
	sta	<L572+1+10
	pld
	tsc
	clc
	adc	#L572+10
	tcs
	tya
	rts
;
;	/* Get logical drive number and mount the volume if needed */
;	mode &= FF_FS_READONLY ? FA_READ : FA_READ | FA_WRITE | FA_CREATE_ALWAYS | FA_CREATE_NEW | FA_OPEN_ALWAYS | FA_OPEN_APPEND;
L10287:
	sep	#$20
	longa	off
	lda	#$c0
	trb	<L572+mode_0
	rep	#$20
	longa	on
;	res = mount_volume(&path, &fs, mode);
	pei	<L572+mode_0
	pea	#0
	clc
	tdc
	adc	#<L573+fs_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L572+path_0
	pha
	jsr	_~mount_volume
	sta	<L573+res_1
;
;	if (res == FR_OK) {
	lda	<L573+res_1
	beq	*+5
	brl	L10288
;		fp->obj.fs = fs;
	lda	<L573+fs_1
	sta	[<L572+fp_0]
	lda	<L573+fs_1+2
	ldy	#$2
	sta	[<L572+fp_0],Y
;		dj.obj.fs = fs;
	lda	<L573+fs_1
	sta	<L573+dj_1
	lda	<L573+fs_1+2
	sta	<L573+dj_1+2
;		INIT_NAMEBUFF(fs);
;		res = follow_path(&dj, path);	/* Follow the file path */
	pei	<L572+path_0+2
	pei	<L572+path_0
	pea	#0
	clc
	tdc
	adc	#<L573+dj_1
	pha
	jsr	_~follow_path
	sta	<L573+res_1
;#if !FF_FS_READONLY	/* Read/Write configuration */
;		if (res == FR_OK) {
	lda	<L573+res_1
	bne	L10289
;			if (dj.fn[NSFLAG] & NS_NONAME) {	/* Origin directory itself? */
	sep	#$20
	longa	off
	lda	<L573+dj_1+45
	and	#<$80
	rep	#$20
	longa	on
	beq	L10290
;				res = FR_INVALID_NAME;
	lda	#$6
	bra	L20063
;			}
;#if FF_FS_LOCK
;			else {
L10290:
;				res = chk_share(&dj, (mode & ~FA_READ) ? 1 : 0);	/* Check if the file can be used */
	lda	<L572+mode_0
	and	#$ff
	and	#<$fffffffe
	beq	L579
	lda	#$1
	bra	L581
L579:
	lda	#$0
L581:
	pha
	pea	#0
	clc
	tdc
	adc	#<L573+dj_1
	pha
	jsr	_~chk_share
L20063:
	sta	<L573+res_1
;			}
;#endif
;		}
;		/* Create or Open a file */
;		if (mode & (FA_CREATE_ALWAYS | FA_OPEN_ALWAYS | FA_CREATE_NEW)) {
L10289:
	sep	#$20
	longa	off
	lda	<L572+mode_0
	and	#<$1c
	rep	#$20
	longa	on
	bne	*+5
	brl	L10292
;			if (res != FR_OK) {					/* No file, create new */
	lda	<L573+res_1
	beq	L10293
;				if (res == FR_NO_FILE) {		/* There is no file to open, create a new entry */
	lda	<L573+res_1
	cmp	#<$4
	bne	L10294
;#if FF_FS_LOCK
;					res = enq_share() ? dir_register(&dj) : FR_TOO_MANY_OPEN_FILES;
	jsr	_~enq_share
	tax
	beq	L585
	pea	#0
	clc
	tdc
	adc	#<L573+dj_1
	pha
	jsr	_~dir_register
	bra	L587
L585:
	lda	#$12
L587:
	sta	<L573+res_1
;#else
;					res = dir_register(&dj);
;#endif
;				}
;				mode |= FA_CREATE_ALWAYS;		/* File is created */
L10294:
	sep	#$20
	longa	off
	lda	#$8
	tsb	<L572+mode_0
	rep	#$20
	longa	on
;			}
;			else {								/* An object with the same name is already existing */
	bra	L10295
L10293:
;				if (mode & FA_CREATE_NEW) {
	sep	#$20
	longa	off
	lda	<L572+mode_0
	and	#<$4
	rep	#$20
	longa	on
	beq	L10296
;					res = FR_EXIST;				/* Cannot create as new file */
	lda	#$8
	bra	L20064
;				} else {
L10296:
;					if (dj.obj.attr & (AM_RDO | AM_DIR)) res = FR_DENIED;	/* Cannot overwrite it (R/O or DIR) */
	sep	#$20
	longa	off
	lda	<L573+dj_1+6
	and	#<$11
	rep	#$20
	longa	on
	beq	L10295
	lda	#$7
L20064:
	sta	<L573+res_1
;				}
;			}
L10295:
;			if (res == FR_OK && (mode & FA_CREATE_ALWAYS)) {	/* Truncate the file if overwrite mode */
	lda	<L573+res_1
	beq	*+5
	brl	L10302
	sep	#$20
	longa	off
	lda	<L572+mode_0
	and	#<$8
	rep	#$20
	longa	on
	bne	*+5
	brl	L10302
;				DWORD tm = GET_FATTIME();
;#if FF_FS_EXFAT
;				if (fs->fs_type == FS_EXFAT) {
;					/* Get current allocation info */
;					init_alloc_info(&fp->obj, 0);
;					/* Set exFAT directory entry block initial state */
;					memset(fs->dirbuf + 2, 0, 30);	/* Clear 85 entry except for NumSec */
;					memset(fs->dirbuf + 38, 0, 26);	/* Clear C0 entry except for NumName and NameHash */
;					fs->dirbuf[XDIR_Attr] = AM_ARC;
;					st_32(fs->dirbuf + XDIR_CrtTime, tm);	/* Set created time */
;					st_32(fs->dirbuf + XDIR_ModTime, tm);	/* Set modified time (tmp setting) */
;					fs->dirbuf[XDIR_GenFlags] = 1;
;					res = store_xdir(&dj);
;					if (res == FR_OK && fp->obj.sclust != 0) {	/* Remove the cluster chain if exist */
;						res = remove_chain(&fp->obj, fp->obj.sclust, 0);
;						fs->last_clst = fp->obj.sclust - 1;		/* Reuse the cluster hole */
;					}
;				} else
;#endif
;				{
tm_2	set	56
	lda	#$0
	sta	<L573+tm_2
	lda	#$5a21
	sta	<L573+tm_2+2
;					DWORD cl;
;					/* Set FAT directory entry initial state */
;					st_32(dj.dir + DIR_CrtTime, tm);	/* Set created time */
cl_3	set	60
	pei	<L573+tm_2+2
	pei	<L573+tm_2
	lda	#$e
	clc
	adc	<L573+dj_1+30
	sta	<R0
	lda	#$0
	adc	<L573+dj_1+32
	pha
	pei	<R0
	jsr	_~st_32
;					st_32(dj.dir + DIR_ModTime, tm);	/* Set modified time (tmp setting) */
	pei	<L573+tm_2+2
	pei	<L573+tm_2
	lda	#$16
	clc
	adc	<L573+dj_1+30
	sta	<R0
	lda	#$0
	adc	<L573+dj_1+32
	pha
	pei	<R0
	jsr	_~st_32
;					cl = ld_clust(fs, dj.dir);			/* Get current cluster chain */
	pei	<L573+dj_1+32
	pei	<L573+dj_1+30
	pei	<L573+fs_1+2
	pei	<L573+fs_1
	jsr	_~ld_clust
	sta	<L573+cl_3
	stx	<L573+cl_3+2
;					dj.dir[DIR_Attr] = AM_ARC;			/* Reset attribute */
	sep	#$20
	longa	off
	lda	#$20
	ldy	#$b
	sta	[<L573+dj_1+30],Y
	rep	#$20
	longa	on
;					st_clust(fs, dj.dir, 0);			/* Reset file allocation info */
	pea	#^$0
	pea	#<$0
	pei	<L573+dj_1+32
	pei	<L573+dj_1+30
	pei	<L573+fs_1+2
	pei	<L573+fs_1
	jsr	_~st_clust
;					st_32(dj.dir + DIR_FileSize, 0);
	pea	#^$0
	pea	#<$0
	lda	#$1c
	clc
	adc	<L573+dj_1+30
	sta	<R0
	lda	#$0
	adc	<L573+dj_1+32
	pha
	pei	<R0
	jsr	_~st_32
;					fs->wflag = 1;
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$4
	sta	[<L573+fs_1],Y
	rep	#$20
	longa	on
;					if (cl != 0) {						/* Remove the cluster chain if exist */
	lda	<L573+cl_3
	ora	<L573+cl_3+2
	bne	*+5
	brl	L10302
;						LBA_t sc = fs->winsect;
;
;						res = remove_chain(&dj.obj, cl, 0);
sc_4	set	64
	ldy	#$20
	lda	[<L573+fs_1],Y
	sta	<L573+sc_4
	iny
	iny
	lda	[<L573+fs_1],Y
	sta	<L573+sc_4+2
	pea	#^$0
	pea	#<$0
	pei	<L573+cl_3+2
	pei	<L573+cl_3
	pea	#0
	clc
	tdc
	adc	#<L573+dj_1
	pha
	jsr	_~remove_chain
	sta	<L573+res_1
;						if (res == FR_OK) {
	lda	<L573+res_1
	bne	L10302
;							res = move_window(fs, sc);
	pei	<L573+sc_4+2
	pei	<L573+sc_4
	pei	<L573+fs_1+2
	pei	<L573+fs_1
	jsr	_~move_window
	sta	<L573+res_1
;							fs->last_clst = cl - 1;		/* Reuse the cluster hole */
	lda	#$ffff
	clc
	adc	<L573+cl_3
	sta	<R0
	lda	#$ffff
	adc	<L573+cl_3+2
	sta	<R0+2
	lda	<R0
	ldy	#$c
	sta	[<L573+fs_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L573+fs_1],Y
;						}
;					}
;				}
;			}
;		}
;		else {	/* Open an existing file */
	bra	L10302
L10292:
;			if (res == FR_OK) {					/* Is the object exsiting? */
	lda	<L573+res_1
	bne	L10302
;				if (dj.obj.attr & AM_DIR) {		/* File open against a directory */
	sep	#$20
	longa	off
	lda	<L573+dj_1+6
	and	#<$10
	rep	#$20
	longa	on
	beq	L10304
;					res = FR_NO_FILE;
	lda	#$4
	bra	L20065
;				} else {
L10304:
;					if ((mode & FA_WRITE) && (dj.obj.attr & AM_RDO)) { /* Write mode open against R/O file */
	sep	#$20
	longa	off
	lda	<L572+mode_0
	and	#<$2
	rep	#$20
	longa	on
	beq	L10302
	sep	#$20
	longa	off
	lda	<L573+dj_1+6
	and	#<$1
	rep	#$20
	longa	on
	beq	L10302
;						res = FR_DENIED;
	lda	#$7
L20065:
	sta	<L573+res_1
;					}
;				}
;			}
;		}
L10302:
;		if (res == FR_OK) {
	lda	<L573+res_1
	bne	L10307
;			if (mode & FA_CREATE_ALWAYS) mode |= FA_MODIFIED;	/* Set file change flag if created or overwritten */
	sep	#$20
	longa	off
	lda	<L572+mode_0
	and	#<$8
	rep	#$20
	longa	on
	beq	L10308
	sep	#$20
	longa	off
	lda	#$40
	tsb	<L572+mode_0
	rep	#$20
	longa	on
;			fp->dir_sect = fs->winsect;			/* Pointer to the directory entry */
L10308:
	ldy	#$20
	lda	[<L573+fs_1],Y
	sta	[<L572+fp_0],Y
	iny
	iny
	lda	[<L573+fs_1],Y
	sta	[<L572+fp_0],Y
;			fp->dir_ptr = dj.dir;
	lda	<L573+dj_1+30
	iny
	iny
	sta	[<L572+fp_0],Y
	lda	<L573+dj_1+32
	iny
	iny
	sta	[<L572+fp_0],Y
;#if FF_FS_LOCK
;			fp->obj.lockid = inc_share(&dj, (mode & ~FA_READ) ? 1 : 0);	/* Lock the file for this session */
	lda	<L572+mode_0
	and	#$ff
	and	#<$fffffffe
	beq	L600
	lda	#$1
	bra	L602
L600:
	lda	#$0
L602:
	pha
	pea	#0
	clc
	tdc
	adc	#<L573+dj_1
	pha
	jsr	_~inc_share
	ldy	#$10
	sta	[<L572+fp_0],Y
;			if (fp->obj.lockid == 0) res = FR_INT_ERR;
	lda	[<L572+fp_0],Y
	bne	L10307
	lda	#$2
	sta	<L573+res_1
;#endif
;		}
;
;#else	/* R/O configuration */
;		if (res == FR_OK) {
;			if (dj.fn[NSFLAG] & NS_NONAME) {	/* Is it origin directory itself? */
;				res = FR_INVALID_NAME;
;			} else {
;				if (dj.obj.attr & AM_DIR) {		/* Is it a directory? */
;					res = FR_NO_FILE;
;				}
;			}
;		}
;#endif
;
;		if (res == FR_OK) {
L10307:
	lda	<L573+res_1
	beq	*+5
	brl	L10288
;#if FF_FS_EXFAT
;			if (fs->fs_type == FS_EXFAT) {
;				init_alloc_info(&fp->obj, &dj);
;			} else
;#endif
;			{
;				fp->obj.sclust = ld_clust(fs, dj.dir);					/* Get object allocation info */
	pei	<L573+dj_1+32
	pei	<L573+dj_1+30
	pei	<L573+fs_1+2
	pei	<L573+fs_1
	jsr	_~ld_clust
	stx	<R0+2
	ldy	#$8
	sta	[<L572+fp_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L572+fp_0],Y
;				fp->obj.objsize = ld_32(dj.dir + DIR_FileSize);
	lda	#$1c
	clc
	adc	<L573+dj_1+30
	sta	<R0
	lda	#$0
	adc	<L573+dj_1+32
	pha
	pei	<R0
	jsr	_~ld_32
	stx	<R1+2
	ldy	#$c
	sta	[<L572+fp_0],Y
	lda	<R1+2
	iny
	iny
	sta	[<L572+fp_0],Y
;			}
;#if FF_USE_FASTSEEK
;			fp->cltbl = 0;		/* Disable fast seek mode */
	lda	#$0
	ldy	#$28
	sta	[<L572+fp_0],Y
	iny
	iny
	sta	[<L572+fp_0],Y
;#endif
;			fp->obj.id = fs->id;	/* Set current volume mount ID */
	ldy	#$6
	lda	[<L573+fs_1],Y
	dey
	dey
	sta	[<L572+fp_0],Y
;			fp->flag = mode;	/* Set file access mode */
	sep	#$20
	longa	off
	lda	<L572+mode_0
	ldy	#$12
	sta	[<L572+fp_0],Y
;			fp->err = 0;		/* Clear error flag */
	lda	#$0
	iny
	sta	[<L572+fp_0],Y
	rep	#$20
	longa	on
;			fp->sect = 0;		/* Invalidate current data sector */
	lda	#$0
	ldy	#$1c
	sta	[<L572+fp_0],Y
	iny
	iny
	sta	[<L572+fp_0],Y
;			fp->fptr = 0;		/* Set file pointer top of the file */
	ldy	#$14
	sta	[<L572+fp_0],Y
	iny
	iny
	sta	[<L572+fp_0],Y
;#if !FF_FS_READONLY
;#if !FF_FS_TINY
;			memset(fp->buf, 0, sizeof fp->buf);	/* Clear sector buffer */
	pea	#<$200
	pea	#<$0
	lda	#$2c
	clc
	adc	<L572+fp_0
	sta	<R0
	lda	#$0
	adc	<L572+fp_0+2
	sta	<R0+2
	pha
	pei	<R0
	jsr	_~memset
;#endif
;			if ((mode & FA_SEEKEND) && fp->obj.objsize > 0) {	/* Seek to end of file if FA_OPEN_APPEND is specified */
	sep	#$20
	longa	off
	lda	<L572+mode_0
	and	#<$20
	rep	#$20
	longa	on
	bne	*+5
	brl	L10288
	lda	#$0
	ldy	#$c
	cmp	[<L572+fp_0],Y
	iny
	iny
	sbc	[<L572+fp_0],Y
	bcc	*+5
	brl	L10288
;				DWORD bcs, clst;
;				FSIZE_t ofs;
;
;				fp->fptr = fp->obj.objsize;			/* Offset to seek */
bcs_5	set	56
clst_5	set	60
ofs_5	set	64
	dey
	dey
	lda	[<L572+fp_0],Y
	ldy	#$14
	sta	[<L572+fp_0],Y
	ldy	#$e
	lda	[<L572+fp_0],Y
	ldy	#$16
	sta	[<L572+fp_0],Y
;				bcs = (DWORD)fs->csize * SS(fs);	/* Cluster size in byte */
	ldy	#$a
	lda	[<L573+fs_1],Y
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$9
	xref	_~~lasl
	jsr	_~~lasl
	sta	<L573+bcs_5
	stx	<L573+bcs_5+2
;				clst = fp->obj.sclust;				/* Follow the cluster chain */
	ldy	#$8
	lda	[<L572+fp_0],Y
	sta	<L573+clst_5
	iny
	iny
	lda	[<L572+fp_0],Y
	sta	<L573+clst_5+2
;				for (ofs = fp->obj.objsize; res == FR_OK && ofs > bcs; ofs -= bcs) {
	iny
	iny
	lda	[<L572+fp_0],Y
	sta	<L573+ofs_5
	iny
	iny
	lda	[<L572+fp_0],Y
	bra	L20066
L10314:
;					clst = get_fat(&fp->obj, clst);
	pei	<L573+clst_5+2
	pei	<L573+clst_5
	pei	<L572+fp_0+2
	pei	<L572+fp_0
	jsr	_~get_fat
	sta	<L573+clst_5
	stx	<L573+clst_5+2
;					if (clst <= 1) res = FR_INT_ERR;
	lda	#$1
	cmp	<L573+clst_5
	dea
	sbc	<L573+clst_5+2
	bcc	L10316
	lda	#$2
	sta	<L573+res_1
;					if (clst == 0xFFFFFFFF) res = FR_DISK_ERR;
L10316:
	lda	<L573+clst_5
	cmp	#<$ffffffff
	bne	L608
	lda	<L573+clst_5+2
	cmp	#^$ffffffff
L608:
	bne	L10312
	lda	#$1
	sta	<L573+res_1
;				}
L10312:
	sec
	lda	<L573+ofs_5
	sbc	<L573+bcs_5
	sta	<L573+ofs_5
	lda	<L573+ofs_5+2
	sbc	<L573+bcs_5+2
L20066:
	sta	<L573+ofs_5+2
	lda	<L573+res_1
	bne	L10313
	lda	<L573+bcs_5
	cmp	<L573+ofs_5
	lda	<L573+bcs_5+2
	sbc	<L573+ofs_5+2
	bcc	L10314
L10313:
;				fp->clust = clst;
	lda	<L573+clst_5
	ldy	#$18
	sta	[<L572+fp_0],Y
	lda	<L573+clst_5+2
	iny
	iny
	sta	[<L572+fp_0],Y
;				if (res == FR_OK && ofs % SS(fs)) {	/* Fill sector buffer if not on the sector boundary */
	lda	<L573+res_1
	bne	L10318
	lda	<L573+ofs_5
	and	#<$1ff
	beq	L10318
;					LBA_t sec = clst2sect(fs, clst);
;
;					if (sec == 0) {
sec_6	set	68
	pei	<L573+clst_5+2
	pei	<L573+clst_5
	pei	<L573+fs_1+2
	pei	<L573+fs_1
	jsr	_~clst2sect
	sta	<L573+sec_6
	stx	<L573+sec_6+2
	ora	<L573+sec_6+2
	bne	L10319
;						res = FR_INT_ERR;
	lda	#$2
	bra	L20067
;					} else {
L10319:
;						fp->sect = sec + (DWORD)(ofs / SS(fs));
	pei	<L573+ofs_5+2
	pei	<L573+ofs_5
	lda	#$9
	xref	_~~llsr
	jsr	_~~llsr
	stx	<R0+2
	clc
	adc	<L573+sec_6
	sta	<R1
	lda	<R0+2
	adc	<L573+sec_6+2
	sta	<R1+2
	lda	<R1
	ldy	#$1c
	sta	[<L572+fp_0],Y
	lda	<R1+2
	iny
	iny
	sta	[<L572+fp_0],Y
;#if !FF_FS_TINY
;						if (disk_read(fs->pdrv, fp->buf, fp->sect, 1) != RES_OK) res = FR_DISK_ERR;
	pea	#<$1
	lda	[<L572+fp_0],Y
	pha
	dey
	dey
	lda	[<L572+fp_0],Y
	pha
	lda	#$2c
	clc
	adc	<L572+fp_0
	sta	<R0
	lda	#$0
	adc	<L572+fp_0+2
	pha
	pei	<R0
	ldy	#$1
	lda	[<L573+fs_1],Y
	pha
	jsr	_~disk_read
	tax
	beq	L10318
	lda	#$1
L20067:
	sta	<L573+res_1
;#endif
;					}
;				}
;#if FF_FS_LOCK
;				if (res != FR_OK) dec_share(fp->obj.lockid); /* Decrement file open counter if seek failed */
L10318:
	lda	<L573+res_1
	beq	L10288
	ldy	#$10
	lda	[<L572+fp_0],Y
	pha
	jsr	_~dec_share
;#endif
;			}
;#endif
;		}
;
;		FREE_NAMEBUFF();
;	}
;
;	if (res != FR_OK) fp->obj.fs = 0;	/* Invalidate file object on error */
L10288:
	lda	<L573+res_1
	beq	L10323
	lda	#$0
	sta	[<L572+fp_0]
	ldy	#$2
	sta	[<L572+fp_0],Y
;
;	LEAVE_FF(fs, res);
L10323:
	pei	<L573+res_1
	pei	<L573+fs_1+2
	pei	<L573+fs_1
	jsr	_~unlock_volume
	lda	<L573+res_1
	brl	L575
;}
L572	equ	80
L573	equ	9
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Read File                                                        */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_read (
;	FIL* fp, 	/* Open file to be read */
;	void* buff,	/* Data buffer to store the read data */
;	UINT btr,	/* Number of bytes to read */
;	UINT* br	/* Number of bytes read */
;)
;{
	code
	xdef	_~f_read
	func
_~f_read:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L619
	tcs
	phd
	tcd
fp_0	set	3
buff_0	set	7
btr_0	set	11
br_0	set	13
;	FRESULT res;
;	FATFS *fs;
;	LBA_t sect;
;	FSIZE_t remain;
;	UINT rcnt, cc, csect;
;	BYTE *rbuff = (BYTE*)buff;
;
;
;	*br = 0;	/* Clear read byte counter */
res_1	set	0
fs_1	set	2
sect_1	set	6
remain_1	set	10
rcnt_1	set	14
cc_1	set	16
csect_1	set	18
rbuff_1	set	20
	lda	<L619+buff_0
	sta	<L620+rbuff_1
	lda	<L619+buff_0+2
	sta	<L620+rbuff_1+2
	lda	#$0
	sta	[<L619+br_0]
;	res = validate(&fp->obj, &fs);				/* Check validity of the file object */
	pea	#0
	clc
	tdc
	adc	#<L620+fs_1
	pha
	pei	<L619+fp_0+2
	pei	<L619+fp_0
	jsr	_~validate
	sta	<L620+res_1
;	if (res != FR_OK || (res = (FRESULT)fp->err) != FR_OK) LEAVE_FF(fs, res);	/* Check validity */
	lda	<L620+res_1
	bne	L621
	ldy	#$13
	lda	[<L619+fp_0],Y
	and	#$ff
	sta	<L620+res_1
	lda	<L620+res_1
	beq	L10324
L621:
	pei	<L620+res_1
	pei	<L620+fs_1+2
	pei	<L620+fs_1
	jsr	_~unlock_volume
	lda	<L620+res_1
L624:
	tay
	lda	<L619+1
	sta	<L619+1+14
	pld
	tsc
	clc
	adc	#L619+14
	tcs
	tya
	rts
L10324:
;	if (!(fp->flag & FA_READ)) LEAVE_FF(fs, FR_DENIED); /* Check access mode */
	sep	#$20
	longa	off
	ldy	#$12
	lda	[<L619+fp_0],Y
	and	#<$1
	rep	#$20
	longa	on
	bne	L10325
	pea	#<$7
	pei	<L620+fs_1+2
	pei	<L620+fs_1
	jsr	_~unlock_volume
	lda	#$7
	bra	L624
L10325:
;	remain = fp->obj.objsize - fp->fptr;
	sec
	ldy	#$c
	lda	[<L619+fp_0],Y
	ldy	#$14
	sbc	[<L619+fp_0],Y
	sta	<L620+remain_1
	ldy	#$e
	lda	[<L619+fp_0],Y
	ldy	#$16
	sbc	[<L619+fp_0],Y
	sta	<L620+remain_1+2
;	if (btr > remain) btr = (UINT)remain;		/* Truncate btr by remaining bytes */
	lda	<L619+btr_0
	sta	<R0
	stz	<R0+2
	lda	<L620+remain_1
	cmp	<R0
	lda	<L620+remain_1+2
	sbc	<R0+2
	bcc	*+5
	brl	L10330
	lda	<L620+remain_1
	sta	<L619+btr_0
;
;	for ( ; btr > 0; btr -= rcnt, *br += rcnt, rbuff += rcnt, fp->fptr += rcnt) {	/* Repeat until btr bytes read */
	brl	L10330
L10329:
;		if (fp->fptr % SS(fs) == 0) {			/* On the sector boundary? */
	ldy	#$14
	lda	[<L619+fp_0],Y
	and	#<$1ff
	beq	*+5
	brl	L10331
;			csect = (UINT)(fp->fptr / SS(fs) & (fs->csize - 1));	/* Sector offset in the cluster */
	iny
	iny
	lda	[<L619+fp_0],Y
	pha
	dey
	dey
	lda	[<L619+fp_0],Y
	pha
	lda	#$9
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R0
	stx	<R0+2
	clc
	lda	#$ffff
	ldy	#$a
	adc	[<L620+fs_1],Y
	sta	<R1
	stz	<R1+2
	lda	<R1
	and	<R0
	sta	<R2
	lda	<R1+2
	and	<R0+2
	sta	<R2+2
	lda	<R2
	sta	<L620+csect_1
;			if (csect == 0) {					/* On the cluster boundary? */
	lda	<L620+csect_1
	beq	*+5
	brl	L10332
;				DWORD clst;
;
;				if (fp->fptr == 0) {			/* On the top of the file? */
clst_2	set	24
	ldy	#$14
	lda	[<L619+fp_0],Y
	iny
	iny
	ora	[<L619+fp_0],Y
	bne	L10333
;					clst = fp->obj.sclust;		/* Follow cluster chain from the origin */
	ldy	#$8
	lda	[<L619+fp_0],Y
	sta	<L620+clst_2
	iny
	iny
	lda	[<L619+fp_0],Y
	sta	<L620+clst_2+2
;				} else {						/* Middle or end of the file */
	bra	L10334
L10333:
;#if FF_USE_FASTSEEK
;					if (fp->cltbl) {
	ldy	#$28
	lda	[<L619+fp_0],Y
	iny
	iny
	ora	[<L619+fp_0],Y
	beq	L10335
;						clst = clmt_clust(fp, fp->fptr);	/* Get cluster# from the CLMT */
	ldy	#$16
	lda	[<L619+fp_0],Y
	pha
	dey
	dey
	lda	[<L619+fp_0],Y
	pha
	pei	<L619+fp_0+2
	pei	<L619+fp_0
	jsr	_~clmt_clust
	bra	L20069
;					} else
L10335:
;#endif
;					{
;						clst = get_fat(&fp->obj, fp->clust);	/* Follow cluster chain on the FAT */
	ldy	#$1a
	lda	[<L619+fp_0],Y
	pha
	dey
	dey
	lda	[<L619+fp_0],Y
	pha
	pei	<L619+fp_0+2
	pei	<L619+fp_0
	jsr	_~get_fat
L20069:
	sta	<L620+clst_2
	stx	<L620+clst_2+2
;					}
;				}
L10334:
;				if (clst < 2) ABORT(fs, FR_INT_ERR);
	lda	<L620+clst_2
	cmp	#<$2
	lda	<L620+clst_2+2
	sbc	#^$2
	bcs	L10337
	sep	#$20
	longa	off
	lda	#$2
	ldy	#$13
	sta	[<L619+fp_0],Y
	rep	#$20
	longa	on
L20074:
	pea	#<$2
	pei	<L620+fs_1+2
	pei	<L620+fs_1
	jsr	_~unlock_volume
	lda	#$2
	brl	L624
L10337:
;				if (clst == 0xFFFFFFFF) ABORT(fs, FR_DISK_ERR);
	lda	<L620+clst_2
	cmp	#<$ffffffff
	bne	L632
	lda	<L620+clst_2+2
	cmp	#^$ffffffff
L632:
	bne	L10338
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L619+fp_0],Y
	rep	#$20
	longa	on
L20079:
	pea	#<$1
	pei	<L620+fs_1+2
	pei	<L620+fs_1
	jsr	_~unlock_volume
	lda	#$1
	brl	L624
L10338:
;				fp->clust = clst;				/* Update current cluster */
	lda	<L620+clst_2
	ldy	#$18
	sta	[<L619+fp_0],Y
	lda	<L620+clst_2+2
	iny
	iny
	sta	[<L619+fp_0],Y
;			}
;			sect = clst2sect(fs, fp->clust);	/* Get current sector */
L10332:
	ldy	#$1a
	lda	[<L619+fp_0],Y
	pha
	dey
	dey
	lda	[<L619+fp_0],Y
	pha
	pei	<L620+fs_1+2
	pei	<L620+fs_1
	jsr	_~clst2sect
	sta	<L620+sect_1
	stx	<L620+sect_1+2
;			if (sect == 0) ABORT(fs, FR_INT_ERR);
	ora	<L620+sect_1+2
	bne	L10339
	sep	#$20
	longa	off
	lda	#$2
	ldy	#$13
	sta	[<L619+fp_0],Y
	rep	#$20
	longa	on
	bra	L20074
L10339:
;			sect += csect;
	lda	<L620+csect_1
	sta	<R0
	stz	<R0+2
	lda	<R0
	clc
	adc	<L620+sect_1
	sta	<L620+sect_1
	lda	<R0+2
	adc	<L620+sect_1+2
	sta	<L620+sect_1+2
;			cc = btr / SS(fs);					/* When remaining bytes >= sector size, */
	lda	<L619+btr_0
	ldx	#<$9
	xref	_~~lsr
	jsr	_~~lsr
	sta	<L620+cc_1
;			if (cc > 0) {						/* Read maximum contiguous sectors directly */
	lda	#$0
	cmp	<L620+cc_1
	bcc	*+5
	brl	L10340
;				if (csect + cc > fs->csize) {	/* Clip at cluster boundary */
	lda	<L620+csect_1
	clc
	adc	<L620+cc_1
	sta	<R0
	ldy	#$a
	lda	[<L620+fs_1],Y
	cmp	<R0
	bcs	L10341
;					cc = fs->csize - csect;
	sec
	lda	[<L620+fs_1],Y
	sbc	<L620+csect_1
	sta	<L620+cc_1
;				}
;				if (disk_read(fs->pdrv, rbuff, sect, cc) != RES_OK) ABORT(fs, FR_DISK_ERR);
L10341:
	pei	<L620+cc_1
	pei	<L620+sect_1+2
	pei	<L620+sect_1
	pei	<L620+rbuff_1+2
	pei	<L620+rbuff_1
	ldy	#$1
	lda	[<L620+fs_1],Y
	pha
	jsr	_~disk_read
	tax
	beq	L10342
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L619+fp_0],Y
	rep	#$20
	longa	on
	brl	L20079
L10342:
;#if !FF_FS_READONLY && FF_FS_MINIMIZE <= 2		/* Replace one of the read sectors with cached data if it contains a dirty sector */
;#if FF_FS_TINY
;				if (fs->wflag && fs->winsect - sect < cc) {
;					memcpy(rbuff + ((fs->winsect - sect) * SS(fs)), fs->win, SS(fs));
;				}
;#else
;				if ((fp->flag & FA_DIRTY) && fp->sect - sect < cc) {
	sep	#$20
	longa	off
	ldy	#$12
	lda	[<L619+fp_0],Y
	and	#<$80
	rep	#$20
	longa	on
	beq	L10343
	lda	<L620+cc_1
	sta	<R0
	stz	<R0+2
	sec
	ldy	#$1c
	lda	[<L619+fp_0],Y
	sbc	<L620+sect_1
	sta	<R1
	iny
	iny
	lda	[<L619+fp_0],Y
	sbc	<L620+sect_1+2
	sta	<R1+2
	lda	<R1
	cmp	<R0
	lda	<R1+2
	sbc	<R0+2
	bcs	L10343
;					memcpy(rbuff + ((fp->sect - sect) * SS(fs)), fp->buf, SS(fs));
	pea	#<$200
	lda	#$2c
	clc
	adc	<L619+fp_0
	sta	<R0
	lda	#$0
	adc	<L619+fp_0+2
	pha
	pei	<R0
	sec
	dey
	dey
	lda	[<L619+fp_0],Y
	sbc	<L620+sect_1
	sta	<R2
	iny
	iny
	lda	[<L619+fp_0],Y
	sbc	<L620+sect_1+2
	pha
	pei	<R2
	lda	#$9
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R1
	stx	<R1+2
	lda	<L620+rbuff_1
	clc
	adc	<R1
	sta	<R3
	lda	<L620+rbuff_1+2
	adc	<R1+2
	pha
	pei	<R3
	jsr	_~memcpy
;				}
;#endif
;#endif
;				rcnt = SS(fs) * cc;				/* Number of bytes transferred */
L10343:
	lda	<L620+cc_1
	ldx	#<$9
	xref	_~~asl
	jsr	_~~asl
	sta	<L620+rcnt_1
;				continue;
	brl	L10327
;			}
;#if !FF_FS_TINY
;			if (fp->sect != sect) {			/* Load data sector if not in cache */
L10340:
	ldy	#$1c
	lda	[<L619+fp_0],Y
	cmp	<L620+sect_1
	bne	L640
	iny
	iny
	lda	[<L619+fp_0],Y
	cmp	<L620+sect_1+2
L640:
	bne	*+5
	brl	L10344
;#if !FF_FS_READONLY
;				if (fp->flag & FA_DIRTY) {		/* Write-back dirty sector cache */
	sep	#$20
	longa	off
	ldy	#$12
	lda	[<L619+fp_0],Y
	and	#<$80
	rep	#$20
	longa	on
	beq	L10345
;					if (disk_write(fs->pdrv, fp->buf, fp->sect, 1) != RES_OK) ABORT(fs, FR_DISK_ERR);
	pea	#<$1
	ldy	#$1e
	lda	[<L619+fp_0],Y
	pha
	dey
	dey
	lda	[<L619+fp_0],Y
	pha
	lda	#$2c
	clc
	adc	<L619+fp_0
	sta	<R0
	lda	#$0
	adc	<L619+fp_0+2
	pha
	pei	<R0
	ldy	#$1
	lda	[<L620+fs_1],Y
	pha
	jsr	_~disk_write
	tax
	beq	L10346
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L619+fp_0],Y
	rep	#$20
	longa	on
	brl	L20079
L10346:
;					fp->flag &= (BYTE)~FA_DIRTY;
	lda	#$12
	clc
	adc	<L619+fp_0
	sta	<R0
	lda	#$0
	adc	<L619+fp_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	and	#<$7f
	sta	[<R0]
	rep	#$20
	longa	on
;				}
;#endif
;				if (disk_read(fs->pdrv, fp->buf, sect, 1) != RES_OK) ABORT(fs, FR_DISK_ERR);	/* Fill sector cache */
L10345:
	pea	#<$1
	pei	<L620+sect_1+2
	pei	<L620+sect_1
	lda	#$2c
	clc
	adc	<L619+fp_0
	sta	<R0
	lda	#$0
	adc	<L619+fp_0+2
	pha
	pei	<R0
	ldy	#$1
	lda	[<L620+fs_1],Y
	pha
	jsr	_~disk_read
	tax
	beq	L10344
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L619+fp_0],Y
	rep	#$20
	longa	on
	brl	L20079
;			}
;#endif
;			fp->sect = sect;
L10344:
	lda	<L620+sect_1
	ldy	#$1c
	sta	[<L619+fp_0],Y
	lda	<L620+sect_1+2
	iny
	iny
	sta	[<L619+fp_0],Y
;		}
;		rcnt = SS(fs) - (UINT)fp->fptr % SS(fs);	/* Number of bytes remains in the sector */
L10331:
	ldy	#$14
	lda	[<L619+fp_0],Y
	and	#<$1ff
	sta	<R0
	sec
	lda	#$200
	sbc	<R0
	sta	<L620+rcnt_1
;		if (rcnt > btr) rcnt = btr;					/* Clip it by btr if needed */
	lda	<L619+btr_0
	cmp	<L620+rcnt_1
	bcs	L10348
	lda	<L619+btr_0
	sta	<L620+rcnt_1
;#if FF_FS_TINY
;		if (move_window(fs, fp->sect) != FR_OK) ABORT(fs, FR_DISK_ERR);	/* Move sector window */
;		memcpy(rbuff, fs->win + fp->fptr % SS(fs), rcnt);	/* Extract partial sector */
;#else
;		memcpy(rbuff, fp->buf + fp->fptr % SS(fs), rcnt);	/* Extract partial sector */
L10348:
	pei	<L620+rcnt_1
	ldy	#$14
	lda	[<L619+fp_0],Y
	and	#<$1ff
	sta	<R0
	stz	<R0+2
	lda	#$2c
	clc
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	<L619+fp_0
	clc
	adc	<R1
	sta	<R0
	lda	<L619+fp_0+2
	adc	<R1+2
	pha
	pei	<R0
	pei	<L620+rbuff_1+2
	pei	<L620+rbuff_1
	jsr	_~memcpy
;#endif
;	}
L10327:
	sec
	lda	<L619+btr_0
	sbc	<L620+rcnt_1
	sta	<L619+btr_0
	lda	[<L619+br_0]
	clc
	adc	<L620+rcnt_1
	sta	[<L619+br_0]
	lda	<L620+rcnt_1
	sta	<R0
	stz	<R0+2
	lda	<L620+rbuff_1
	clc
	adc	<R0
	sta	<L620+rbuff_1
	lda	<L620+rbuff_1+2
	adc	<R0+2
	sta	<L620+rbuff_1+2
	lda	#$14
	clc
	adc	<L619+fp_0
	sta	<R0
	lda	#$0
	adc	<L619+fp_0+2
	sta	<R0+2
	lda	<L620+rcnt_1
	sta	<R1
	stz	<R1+2
	lda	<R1
	clc
	adc	[<R0]
	sta	[<R0]
	lda	<R1+2
	ldy	#$2
	adc	[<R0],Y
	sta	[<R0],Y
L10330:
	lda	#$0
	cmp	<L619+btr_0
	bcs	*+5
	brl	L10329
;
;	LEAVE_FF(fs, FR_OK);
	pea	#<$0
	pei	<L620+fs_1+2
	pei	<L620+fs_1
	jsr	_~unlock_volume
	lda	#$0
	brl	L624
;}
L619	equ	44
L620	equ	17
	ends
	efunc
;
;
;
;
;#if !FF_FS_READONLY
;/*-----------------------------------------------------------------------*/
;/* API: Write File                                                       */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_write (
;	FIL* fp,			/* Open file to be written */
;	const void* buff,	/* Data to be written */
;	UINT btw,			/* Number of bytes to write */
;	UINT* bw			/* Number of bytes written */
;)
;{
	code
	xdef	_~f_write
	func
_~f_write:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L647
	tcs
	phd
	tcd
fp_0	set	3
buff_0	set	7
btw_0	set	11
bw_0	set	13
;	FRESULT res;
;	FATFS *fs;
;	DWORD clst;
;	LBA_t sect;
;	UINT wcnt, cc, csect;
;	const BYTE *wbuff = (const BYTE*)buff;
;
;
;	*bw = 0;	/* Clear write byte counter */
res_1	set	0
fs_1	set	2
clst_1	set	6
sect_1	set	10
wcnt_1	set	14
cc_1	set	16
csect_1	set	18
wbuff_1	set	20
	lda	<L647+buff_0
	sta	<L648+wbuff_1
	lda	<L647+buff_0+2
	sta	<L648+wbuff_1+2
	lda	#$0
	sta	[<L647+bw_0]
;	res = validate(&fp->obj, &fs);			/* Check validity of the file object */
	pea	#0
	clc
	tdc
	adc	#<L648+fs_1
	pha
	pei	<L647+fp_0+2
	pei	<L647+fp_0
	jsr	_~validate
	sta	<L648+res_1
;	if (res != FR_OK || (res = (FRESULT)fp->err) != FR_OK) LEAVE_FF(fs, res);	/* Check validity */
	lda	<L648+res_1
	bne	L649
	ldy	#$13
	lda	[<L647+fp_0],Y
	and	#$ff
	sta	<L648+res_1
	lda	<L648+res_1
	beq	L10349
L649:
	pei	<L648+res_1
	pei	<L648+fs_1+2
	pei	<L648+fs_1
	jsr	_~unlock_volume
	lda	<L648+res_1
L652:
	tay
	lda	<L647+1
	sta	<L647+1+14
	pld
	tsc
	clc
	adc	#L647+14
	tcs
	tya
	rts
L10349:
;	if (!(fp->flag & FA_WRITE)) LEAVE_FF(fs, FR_DENIED);	/* Check access mode */
	sep	#$20
	longa	off
	ldy	#$12
	lda	[<L647+fp_0],Y
	and	#<$2
	rep	#$20
	longa	on
	bne	L10350
	pea	#<$7
	pei	<L648+fs_1+2
	pei	<L648+fs_1
	jsr	_~unlock_volume
	lda	#$7
	bra	L652
L10350:
;
;	/* Check fptr wrap-around (file size cannot reach 4 GiB at FAT volume) */
;	if ((!FF_FS_EXFAT || fs->fs_type != FS_EXFAT) && (DWORD)(fp->fptr + btw) < (DWORD)fp->fptr) {
	lda	<L647+btw_0
	sta	<R0
	stz	<R0+2
	clc
	lda	<R0
	ldy	#$14
	adc	[<L647+fp_0],Y
	sta	<R1
	lda	<R0+2
	iny
	iny
	adc	[<L647+fp_0],Y
	sta	<R1+2
	lda	<R1
	dey
	dey
	cmp	[<L647+fp_0],Y
	lda	<R1+2
	iny
	iny
	sbc	[<L647+fp_0],Y
	bcc	*+5
	brl	L10355
;		btw = (UINT)(0xFFFFFFFF - (DWORD)fp->fptr);
	sec
	lda	#$ffff
	dey
	dey
	sbc	[<L647+fp_0],Y
	sta	<R0
	lda	#$ffff
	iny
	iny
	sbc	[<L647+fp_0],Y
	sta	<R0+2
	lda	<R0
	sta	<L647+btw_0
;	}
;
;	for ( ; btw > 0; btw -= wcnt, *bw += wcnt, wbuff += wcnt, fp->fptr += wcnt, fp->obj.objsize = (fp->fptr > fp->obj.objsize) ? fp->fptr : fp->obj.objsize) {	/* Repeat until all data written */
	brl	L10355
L10354:
;		if (fp->fptr % SS(fs) == 0) {		/* On the sector boundary? */
	ldy	#$14
	lda	[<L647+fp_0],Y
	and	#<$1ff
	beq	*+5
	brl	L10356
;			csect = (UINT)(fp->fptr / SS(fs)) & (fs->csize - 1);	/* Sector offset in the cluster */
	iny
	iny
	lda	[<L647+fp_0],Y
	pha
	dey
	dey
	lda	[<L647+fp_0],Y
	pha
	lda	#$9
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R0
	stx	<R0+2
	clc
	lda	#$ffff
	ldy	#$a
	adc	[<L648+fs_1],Y
	and	<R0
	sta	<L648+csect_1
;			if (csect == 0) {				/* On the cluster boundary? */
	lda	<L648+csect_1
	beq	*+5
	brl	L10357
;				if (fp->fptr == 0) {		/* On the top of the file? */
	ldy	#$14
	lda	[<L647+fp_0],Y
	iny
	iny
	ora	[<L647+fp_0],Y
	bne	L10358
;					clst = fp->obj.sclust;	/* Follow from the origin */
	ldy	#$8
	lda	[<L647+fp_0],Y
	sta	<L648+clst_1
	iny
	iny
	lda	[<L647+fp_0],Y
	sta	<L648+clst_1+2
;					if (clst == 0) {		/* If no cluster is allocated, */
	lda	<L648+clst_1
	ora	<L648+clst_1+2
	bne	L10360
;						clst = create_chain(&fp->obj, 0);	/* create a new cluster chain */
	pea	#^$0
	pea	#<$0
	bra	L20093
;					}
;				} else {					/* On the middle or end of the file */
L10358:
;#if FF_USE_FASTSEEK
;					if (fp->cltbl) {
	ldy	#$28
	lda	[<L647+fp_0],Y
	iny
	iny
	ora	[<L647+fp_0],Y
	beq	L10361
;						clst = clmt_clust(fp, fp->fptr);	/* Get cluster# from the CLMT */
	ldy	#$16
	lda	[<L647+fp_0],Y
	pha
	dey
	dey
	lda	[<L647+fp_0],Y
	pha
	pei	<L647+fp_0+2
	pei	<L647+fp_0
	jsr	_~clmt_clust
	bra	L20090
;					} else
L10361:
;#endif
;					{
;						clst = create_chain(&fp->obj, fp->clust);	/* Follow or stretch cluster chain on the FAT */
	ldy	#$1a
	lda	[<L647+fp_0],Y
	pha
	dey
	dey
	lda	[<L647+fp_0],Y
	pha
L20093:
	pei	<L647+fp_0+2
	pei	<L647+fp_0
	jsr	_~create_chain
L20090:
	sta	<L648+clst_1
	stx	<L648+clst_1+2
;					}
;				}
L10360:
;				if (clst == 0) break;		/* Could not allocate a new cluster (disk full) */
	lda	<L648+clst_1
	ora	<L648+clst_1+2
	bne	*+5
	brl	L10353
;				if (clst == 1) ABORT(fs, FR_INT_ERR);
	lda	<L648+clst_1
	cmp	#<$1
	bne	L663
	lda	<L648+clst_1+2
	cmp	#^$1
L663:
	bne	L10363
	sep	#$20
	longa	off
	lda	#$2
	ldy	#$13
	sta	[<L647+fp_0],Y
	rep	#$20
	longa	on
L20098:
	pea	#<$2
	pei	<L648+fs_1+2
	pei	<L648+fs_1
	jsr	_~unlock_volume
	lda	#$2
	brl	L652
L10363:
;				if (clst == 0xFFFFFFFF) ABORT(fs, FR_DISK_ERR);
	lda	<L648+clst_1
	cmp	#<$ffffffff
	bne	L665
	lda	<L648+clst_1+2
	cmp	#^$ffffffff
L665:
	bne	L10364
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L647+fp_0],Y
	rep	#$20
	longa	on
L20103:
	pea	#<$1
	pei	<L648+fs_1+2
	pei	<L648+fs_1
	jsr	_~unlock_volume
	lda	#$1
	brl	L652
L10364:
;				fp->clust = clst;			/* Update current cluster */
	lda	<L648+clst_1
	ldy	#$18
	sta	[<L647+fp_0],Y
	lda	<L648+clst_1+2
	iny
	iny
	sta	[<L647+fp_0],Y
;				if (fp->obj.sclust == 0) fp->obj.sclust = clst;	/* Set start cluster if the first write */
	ldy	#$8
	lda	[<L647+fp_0],Y
	iny
	iny
	ora	[<L647+fp_0],Y
	bne	L10357
	lda	<L648+clst_1
	dey
	dey
	sta	[<L647+fp_0],Y
	lda	<L648+clst_1+2
	iny
	iny
	sta	[<L647+fp_0],Y
;			}
;#if FF_FS_TINY
;			if (fs->winsect == fp->sect && sync_window(fs) != FR_OK) ABORT(fs, FR_DISK_ERR);	/* Write-back sector cache */
;#else
;			if (fp->flag & FA_DIRTY) {		/* Write-back sector cache */
L10357:
	sep	#$20
	longa	off
	ldy	#$12
	lda	[<L647+fp_0],Y
	and	#<$80
	rep	#$20
	longa	on
	beq	L10366
;				if (disk_write(fs->pdrv, fp->buf, fp->sect, 1) != RES_OK) ABORT(fs, FR_DISK_ERR);
	pea	#<$1
	ldy	#$1e
	lda	[<L647+fp_0],Y
	pha
	dey
	dey
	lda	[<L647+fp_0],Y
	pha
	lda	#$2c
	clc
	adc	<L647+fp_0
	sta	<R0
	lda	#$0
	adc	<L647+fp_0+2
	pha
	pei	<R0
	ldy	#$1
	lda	[<L648+fs_1],Y
	pha
	jsr	_~disk_write
	tax
	beq	L10367
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L647+fp_0],Y
	rep	#$20
	longa	on
	bra	L20103
L10367:
;				fp->flag &= (BYTE)~FA_DIRTY;
	lda	#$12
	clc
	adc	<L647+fp_0
	sta	<R0
	lda	#$0
	adc	<L647+fp_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	and	#<$7f
	sta	[<R0]
	rep	#$20
	longa	on
;			}
;#endif
;			sect = clst2sect(fs, fp->clust);	/* Get current sector */
L10366:
	ldy	#$1a
	lda	[<L647+fp_0],Y
	pha
	dey
	dey
	lda	[<L647+fp_0],Y
	pha
	pei	<L648+fs_1+2
	pei	<L648+fs_1
	jsr	_~clst2sect
	sta	<L648+sect_1
	stx	<L648+sect_1+2
;			if (sect == 0) ABORT(fs, FR_INT_ERR);
	ora	<L648+sect_1+2
	bne	L10368
	sep	#$20
	longa	off
	lda	#$2
	ldy	#$13
	sta	[<L647+fp_0],Y
	rep	#$20
	longa	on
	brl	L20098
L10368:
;			sect += csect;
	lda	<L648+csect_1
	sta	<R0
	stz	<R0+2
	lda	<R0
	clc
	adc	<L648+sect_1
	sta	<L648+sect_1
	lda	<R0+2
	adc	<L648+sect_1+2
	sta	<L648+sect_1+2
;			cc = btw / SS(fs);				/* When remaining bytes >= sector size, */
	lda	<L647+btw_0
	ldx	#<$9
	xref	_~~lsr
	jsr	_~~lsr
	sta	<L648+cc_1
;			if (cc > 0) {					/* Write maximum contiguous sectors directly */
	lda	#$0
	cmp	<L648+cc_1
	bcc	*+5
	brl	L10369
;				if (csect + cc > fs->csize) {	/* Clip at cluster boundary */
	lda	<L648+csect_1
	clc
	adc	<L648+cc_1
	sta	<R0
	ldy	#$a
	lda	[<L648+fs_1],Y
	cmp	<R0
	bcs	L10370
;					cc = fs->csize - csect;
	sec
	lda	[<L648+fs_1],Y
	sbc	<L648+csect_1
	sta	<L648+cc_1
;				}
;				if (disk_write(fs->pdrv, wbuff, sect, cc) != RES_OK) ABORT(fs, FR_DISK_ERR);
L10370:
	pei	<L648+cc_1
	pei	<L648+sect_1+2
	pei	<L648+sect_1
	pei	<L648+wbuff_1+2
	pei	<L648+wbuff_1
	ldy	#$1
	lda	[<L648+fs_1],Y
	pha
	jsr	_~disk_write
	tax
	beq	L10371
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L647+fp_0],Y
	rep	#$20
	longa	on
	brl	L20103
L10371:
;#if FF_FS_MINIMIZE <= 2
;#if FF_FS_TINY
;				if (fs->winsect - sect < cc) {	/* Refill sector cache if it gets invalidated by the direct write */
;					memcpy(fs->win, wbuff + ((fs->winsect - sect) * SS(fs)), SS(fs));
;					fs->wflag = 0;
;				}
;#else
;				if (fp->sect - sect < cc) { /* Refill sector cache if it gets invalidated by the direct write */
	lda	<L648+cc_1
	sta	<R0
	stz	<R0+2
	sec
	ldy	#$1c
	lda	[<L647+fp_0],Y
	sbc	<L648+sect_1
	sta	<R1
	iny
	iny
	lda	[<L647+fp_0],Y
	sbc	<L648+sect_1+2
	sta	<R1+2
	lda	<R1
	cmp	<R0
	lda	<R1+2
	sbc	<R0+2
	bcs	L10372
;					memcpy(fp->buf, wbuff + ((fp->sect - sect) * SS(fs)), SS(fs));
	pea	#<$200
	sec
	dey
	dey
	lda	[<L647+fp_0],Y
	sbc	<L648+sect_1
	sta	<R1
	iny
	iny
	lda	[<L647+fp_0],Y
	sbc	<L648+sect_1+2
	pha
	pei	<R1
	lda	#$9
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L648+wbuff_1
	clc
	adc	<R0
	sta	<R2
	lda	<L648+wbuff_1+2
	adc	<R0+2
	pha
	pei	<R2
	lda	#$2c
	clc
	adc	<L647+fp_0
	sta	<R0
	lda	#$0
	adc	<L647+fp_0+2
	pha
	pei	<R0
	jsr	_~memcpy
;					fp->flag &= (BYTE)~FA_DIRTY;
	lda	#$12
	clc
	adc	<L647+fp_0
	sta	<R0
	lda	#$0
	adc	<L647+fp_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	and	#<$7f
	sta	[<R0]
	rep	#$20
	longa	on
;				}
;#endif
;#endif
;				wcnt = SS(fs) * cc;		/* Number of bytes transferred */
L10372:
	lda	<L648+cc_1
	ldx	#<$9
	xref	_~~asl
	jsr	_~~asl
	sta	<L648+wcnt_1
;				continue;
	brl	L10352
;			}
;#if FF_FS_TINY
;			if (fp->fptr >= fp->obj.objsize) {	/* Avoid silly cache filling on the growing edge */
;				if (sync_window(fs) != FR_OK) ABORT(fs, FR_DISK_ERR);
;				fs->winsect = sect;
;			}
;#else
;			if (fp->sect != sect && 		/* Fill sector cache with file data */
L10369:
;				fp->fptr < fp->obj.objsize &&
;				disk_read(fs->pdrv, fp->buf, sect, 1) != RES_OK) {
	ldy	#$1c
	lda	[<L647+fp_0],Y
	cmp	<L648+sect_1
	bne	L675
	iny
	iny
	lda	[<L647+fp_0],Y
	cmp	<L648+sect_1+2
L675:
	beq	L10373
	ldy	#$14
	lda	[<L647+fp_0],Y
	ldy	#$c
	cmp	[<L647+fp_0],Y
	ldy	#$16
	lda	[<L647+fp_0],Y
	ldy	#$e
	sbc	[<L647+fp_0],Y
	bcs	L10373
	pea	#<$1
	pei	<L648+sect_1+2
	pei	<L648+sect_1
	lda	#$2c
	clc
	adc	<L647+fp_0
	sta	<R0
	lda	#$0
	adc	<L647+fp_0+2
	pha
	pei	<R0
	ldy	#$1
	lda	[<L648+fs_1],Y
	pha
	jsr	_~disk_read
	tax
	beq	L10373
;					ABORT(fs, FR_DISK_ERR);
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L647+fp_0],Y
	rep	#$20
	longa	on
	brl	L20103
;			}
;#endif
;			fp->sect = sect;
L10373:
	lda	<L648+sect_1
	ldy	#$1c
	sta	[<L647+fp_0],Y
	lda	<L648+sect_1+2
	iny
	iny
	sta	[<L647+fp_0],Y
;		}
;		wcnt = SS(fs) - (UINT)fp->fptr % SS(fs);	/* Number of bytes remains in the sector */
L10356:
	ldy	#$14
	lda	[<L647+fp_0],Y
	and	#<$1ff
	sta	<R0
	sec
	lda	#$200
	sbc	<R0
	sta	<L648+wcnt_1
;		if (wcnt > btw) wcnt = btw;					/* Clip it by btw if needed */
	lda	<L647+btw_0
	cmp	<L648+wcnt_1
	bcs	L10374
	lda	<L647+btw_0
	sta	<L648+wcnt_1
;#if FF_FS_TINY
;		if (move_window(fs, fp->sect) != FR_OK) ABORT(fs, FR_DISK_ERR);	/* Move sector window */
;		memcpy(fs->win + fp->fptr % SS(fs), wbuff, wcnt);	/* Fit data to the sector */
;		fs->wflag = 1;
;#else
;		memcpy(fp->buf + fp->fptr % SS(fs), wbuff, wcnt);	/* Fit data to the sector */
L10374:
	pei	<L648+wcnt_1
	pei	<L648+wbuff_1+2
	pei	<L648+wbuff_1
	ldy	#$14
	lda	[<L647+fp_0],Y
	and	#<$1ff
	sta	<R0
	stz	<R0+2
	lda	#$2c
	clc
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	<L647+fp_0
	clc
	adc	<R1
	sta	<R0
	lda	<L647+fp_0+2
	adc	<R1+2
	pha
	pei	<R0
	jsr	_~memcpy
;		fp->flag |= FA_DIRTY;
	lda	#$12
	clc
	adc	<L647+fp_0
	sta	<R0
	lda	#$0
	adc	<L647+fp_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$80
	sta	[<R0]
	rep	#$20
	longa	on
;#endif
;	}
L10352:
	sec
	lda	<L647+btw_0
	sbc	<L648+wcnt_1
	sta	<L647+btw_0
	lda	[<L647+bw_0]
	clc
	adc	<L648+wcnt_1
	sta	[<L647+bw_0]
	lda	<L648+wcnt_1
	sta	<R0
	stz	<R0+2
	lda	<L648+wbuff_1
	clc
	adc	<R0
	sta	<L648+wbuff_1
	lda	<L648+wbuff_1+2
	adc	<R0+2
	sta	<L648+wbuff_1+2
	lda	#$14
	clc
	adc	<L647+fp_0
	sta	<R0
	lda	#$0
	adc	<L647+fp_0+2
	sta	<R0+2
	lda	<L648+wcnt_1
	sta	<R1
	stz	<R1+2
	lda	<R1
	clc
	adc	[<R0]
	sta	[<R0]
	lda	<R1+2
	ldy	#$2
	adc	[<R0],Y
	sta	[<R0],Y
	ldy	#$c
	lda	[<L647+fp_0],Y
	ldy	#$14
	cmp	[<L647+fp_0],Y
	ldy	#$e
	lda	[<L647+fp_0],Y
	ldy	#$16
	sbc	[<L647+fp_0],Y
	bcc	L20115
	ldy	#$e
L20115:
	lda	[<L647+fp_0],Y
	tax
	dey
	dey
	lda	[<L647+fp_0],Y
	stx	<R0+2
	ldy	#$c
	sta	[<L647+fp_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L647+fp_0],Y
L10355:
	lda	#$0
	cmp	<L647+btw_0
	bcs	*+5
	brl	L10354
L10353:
;
;	fp->flag |= FA_MODIFIED;				/* Set file change flag */
	lda	#$12
	clc
	adc	<L647+fp_0
	sta	<R0
	lda	#$0
	adc	<L647+fp_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$40
	sta	[<R0]
	rep	#$20
	longa	on
;
;	LEAVE_FF(fs, FR_OK);
	pea	#<$0
	pei	<L648+fs_1+2
	pei	<L648+fs_1
	jsr	_~unlock_volume
	lda	#$0
	brl	L652
;}
L647	equ	36
L648	equ	13
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Synchronize the File                                             */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_sync (
;	FIL* fp		/* Open file to be synced */
;)
;{
	code
	xdef	_~f_sync
	func
_~f_sync:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L684
	tcs
	phd
	tcd
fp_0	set	3
;	FRESULT res;
;	FATFS *fs;
;
;
;	res = validate(&fp->obj, &fs);	/* Check validity of the file object */
res_1	set	0
fs_1	set	2
	pea	#0
	clc
	tdc
	adc	#<L685+fs_1
	pha
	pei	<L684+fp_0+2
	pei	<L684+fp_0
	jsr	_~validate
	sta	<L685+res_1
;	if (res == FR_OK) {
	lda	<L685+res_1
	beq	*+5
	brl	L10375
;		if (fp->flag & FA_MODIFIED) {	/* Is there any change to the file? */
	sep	#$20
	longa	off
	ldy	#$12
	lda	[<L684+fp_0],Y
	and	#<$40
	rep	#$20
	longa	on
	bne	*+5
	brl	L10375
;#if !FF_FS_TINY
;			if (fp->flag & FA_DIRTY) {	/* Write-back cached data if needed */
	sep	#$20
	longa	off
	lda	[<L684+fp_0],Y
	and	#<$80
	rep	#$20
	longa	on
	beq	L10377
;				if (disk_write(fs->pdrv, fp->buf, fp->sect, 1) != RES_OK) LEAVE_FF(fs, FR_DISK_ERR);
	pea	#<$1
	ldy	#$1e
	lda	[<L684+fp_0],Y
	pha
	dey
	dey
	lda	[<L684+fp_0],Y
	pha
	lda	#$2c
	clc
	adc	<L684+fp_0
	sta	<R0
	lda	#$0
	adc	<L684+fp_0+2
	pha
	pei	<R0
	ldy	#$1
	lda	[<L685+fs_1],Y
	pha
	jsr	_~disk_write
	tax
	beq	L10378
	pea	#<$1
	pei	<L685+fs_1+2
	pei	<L685+fs_1
	jsr	_~unlock_volume
	lda	#$1
L690:
	tay
	lda	<L684+1
	sta	<L684+1+4
	pld
	tsc
	clc
	adc	#L684+4
	tcs
	tya
	rts
L10378:
;				fp->flag &= (BYTE)~FA_DIRTY;
	lda	#$12
	clc
	adc	<L684+fp_0
	sta	<R0
	lda	#$0
	adc	<L684+fp_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	and	#<$7f
	sta	[<R0]
	rep	#$20
	longa	on
;			}
;#endif
;			/* Update the directory entry */
;#if FF_FS_EXFAT
;			if (fs->fs_type == FS_EXFAT) {
;				res = fill_first_frag(&fp->obj);	/* Fill first fragment on the FAT if needed */
;				if (res == FR_OK) {
;					res = fill_last_frag(&fp->obj, fp->clust, 0xFFFFFFFF);	/* Fill last fragment on the FAT if needed */
;				}
;				if (res == FR_OK) {
;					DIR dj;
;					DEF_NAMEBUFF
;
;					INIT_NAMEBUFF(fs);
;					res = load_obj_xdir(&dj, &fp->obj);	/* Load directory entry block */
;					if (res == FR_OK) {
;						fs->dirbuf[XDIR_Attr] |= AM_ARC;					/* Set archive attribute to indicate that the file has been changed */
;						fs->dirbuf[XDIR_GenFlags] = fp->obj.stat | 1;		/* Update file allocation information */
;						st_32(fs->dirbuf + XDIR_FstClus, fp->obj.sclust);	/* Update start cluster */
;						st_64(fs->dirbuf + XDIR_FileSize, fp->obj.objsize);	/* Update file size */
;						st_64(fs->dirbuf + XDIR_ValidFileSize, fp->obj.objsize);	/* (FatFs does not support Valid File Size feature) */
;						st_32(fs->dirbuf + XDIR_ModTime, GET_FATTIME());	/* Update modified time */
;						fs->dirbuf[XDIR_ModTime10] = 0;
;						fs->dirbuf[XDIR_ModTZ] = 0;
;						st_32(fs->dirbuf + XDIR_AccTime, 0);				/* Invalidate last access time */
;						fs->dirbuf[XDIR_AccTZ] = 0;
;						res = store_xdir(&dj);								/* Restore it to the directory */
;						if (res == FR_OK) {
;							res = sync_fs(fs);
;							fp->flag &= (BYTE)~FA_MODIFIED;
;						}
;					}
;					FREE_NAMEBUFF();
;				}
;			} else
;#endif
;			{
L10377:
;				res = move_window(fs, fp->dir_sect);
	ldy	#$22
	lda	[<L684+fp_0],Y
	pha
	dey
	dey
	lda	[<L684+fp_0],Y
	pha
	pei	<L685+fs_1+2
	pei	<L685+fs_1
	jsr	_~move_window
	sta	<L685+res_1
;				if (res == FR_OK) {
	lda	<L685+res_1
	beq	*+5
	brl	L10375
;					BYTE *dir = fp->dir_ptr;
;
;					dir[DIR_Attr] |= AM_ARC;					/* Set archive attribute to indicate that the file has been changed */
dir_2	set	6
	ldy	#$24
	lda	[<L684+fp_0],Y
	sta	<L685+dir_2
	iny
	iny
	lda	[<L684+fp_0],Y
	sta	<L685+dir_2+2
	lda	#$b
	clc
	adc	<L685+dir_2
	sta	<R0
	lda	#$0
	adc	<L685+dir_2+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$20
	sta	[<R0]
	rep	#$20
	longa	on
;					st_clust(fp->obj.fs, dir, fp->obj.sclust);	/* Update file allocation information  */
	ldy	#$a
	lda	[<L684+fp_0],Y
	pha
	dey
	dey
	lda	[<L684+fp_0],Y
	pha
	pei	<L685+dir_2+2
	pei	<L685+dir_2
	ldy	#$2
	lda	[<L684+fp_0],Y
	pha
	lda	[<L684+fp_0]
	pha
	jsr	_~st_clust
;					st_32(dir + DIR_FileSize, (DWORD)fp->obj.objsize);	/* Update file size */
	ldy	#$e
	lda	[<L684+fp_0],Y
	pha
	dey
	dey
	lda	[<L684+fp_0],Y
	pha
	lda	#$1c
	clc
	adc	<L685+dir_2
	sta	<R0
	lda	#$0
	adc	<L685+dir_2+2
	pha
	pei	<R0
	jsr	_~st_32
;					st_32(dir + DIR_ModTime, GET_FATTIME());	/* Update modified time */
	pea	#^$5a210000
	pea	#<$5a210000
	lda	#$16
	clc
	adc	<L685+dir_2
	sta	<R0
	lda	#$0
	adc	<L685+dir_2+2
	pha
	pei	<R0
	jsr	_~st_32
;					st_16(dir + DIR_LstAccDate, 0);				/* Invalidate last access date */
	pea	#<$0
	lda	#$12
	clc
	adc	<L685+dir_2
	sta	<R0
	lda	#$0
	adc	<L685+dir_2+2
	pha
	pei	<R0
	jsr	_~st_16
;					fs->wflag = 1;
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$4
	sta	[<L685+fs_1],Y
	rep	#$20
	longa	on
;					res = sync_fs(fs);							/* Restore it to the directory */
	pei	<L685+fs_1+2
	pei	<L685+fs_1
	jsr	_~sync_fs
	sta	<L685+res_1
;					fp->flag &= (BYTE)~FA_MODIFIED;
	lda	#$12
	clc
	adc	<L684+fp_0
	sta	<R0
	lda	#$0
	adc	<L684+fp_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	and	#<$bf
	sta	[<R0]
	rep	#$20
	longa	on
;				}
;			}
;		}
;	}
;
;	LEAVE_FF(fs, res);
L10375:
	pei	<L685+res_1
	pei	<L685+fs_1+2
	pei	<L685+fs_1
	jsr	_~unlock_volume
	lda	<L685+res_1
	brl	L690
;}
L684	equ	14
L685	equ	5
	ends
	efunc
;
;#endif /* !FF_FS_READONLY */
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Close File                                                       */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_close (
;	FIL* fp		/* Open file to be closed */
;)
;{
	code
	xdef	_~f_close
	func
_~f_close:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L692
	tcs
	phd
	tcd
fp_0	set	3
;	FRESULT res;
;	FATFS *fs;
;
;#if !FF_FS_READONLY
;	res = f_sync(fp);					/* Flush cached data */
res_1	set	0
fs_1	set	2
	pei	<L692+fp_0+2
	pei	<L692+fp_0
	jsr	_~f_sync
	sta	<L693+res_1
;	if (res == FR_OK)
;#endif
;	{
	lda	<L693+res_1
	bne	L10380
;		res = validate(&fp->obj, &fs);	/* Lock volume */
	pea	#0
	clc
	tdc
	adc	#<L693+fs_1
	pha
	pei	<L692+fp_0+2
	pei	<L692+fp_0
	jsr	_~validate
	sta	<L693+res_1
;		if (res == FR_OK) {
	lda	<L693+res_1
	bne	L10380
;#if FF_FS_LOCK
;			res = dec_share(fp->obj.lockid);		/* Decrement file open counter */
	ldy	#$10
	lda	[<L692+fp_0],Y
	pha
	jsr	_~dec_share
	sta	<L693+res_1
;			if (res == FR_OK) fp->obj.fs = 0;	/* Invalidate file object */
	lda	<L693+res_1
	bne	L10382
	lda	#$0
	sta	[<L692+fp_0]
	ldy	#$2
	sta	[<L692+fp_0],Y
;#else
;			fp->obj.fs = 0;	/* Invalidate file object */
;#endif
;#if FF_FS_REENTRANT
;			unlock_volume(fs, FR_OK);		/* Unlock volume */
L10382:
	pea	#<$0
	pei	<L693+fs_1+2
	pei	<L693+fs_1
	jsr	_~unlock_volume
;#endif
;		}
;	}
;	return res;
L10380:
	lda	<L693+res_1
	tay
	lda	<L692+1
	sta	<L692+1+4
	pld
	tsc
	clc
	adc	#L692+4
	tcs
	tya
	rts
;}
L692	equ	6
L693	equ	1
	ends
	efunc
;
;
;
;
;#if FF_FS_RPATH >= 1
;/*-----------------------------------------------------------------------*/
;/* API: Change Current Drive                                             */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_chdrive (
;	const TCHAR* path		/* Drive number to set */
;)
;{
	code
	xdef	_~f_chdrive
	func
_~f_chdrive:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L698
	tcs
	phd
	tcd
path_0	set	3
;	int vol;
;
;
;	/* Get logical drive number */
;	vol = get_ldnumber(&path);
vol_1	set	0
	pea	#0
	clc
	tdc
	adc	#<L698+path_0
	pha
	jsr	_~get_ldnumber
	sta	<L699+vol_1
;	if (vol < 0) return FR_INVALID_DRIVE;
	lda	<L699+vol_1
	bpl	L10383
	lda	#$b
L701:
	tay
	lda	<L698+1
	sta	<L698+1+4
	pld
	tsc
	clc
	adc	#L698+4
	tcs
	tya
	rts
;	CurrVol = (BYTE)vol;	/* Set it as current volume */
L10383:
	sep	#$20
	longa	off
	lda	<L699+vol_1
	sta	|_~CurrVol
	rep	#$20
	longa	on
;
;	return FR_OK;
	lda	#$0
	bra	L701
;}
L698	equ	2
L699	equ	1
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Change Current Directory                                         */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_chdir (
;	const TCHAR* path	/* Pointer to the directory path */
;)
;{
	code
	xdef	_~f_chdir
	func
_~f_chdir:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L702
	tcs
	phd
	tcd
path_0	set	3
;	FRESULT res;
;	DIR dj;
;	FATFS *fs;
;	DEF_NAMEBUFF
;
;
;	res = mount_volume(&path, &fs, 0);	/* Get logical drive and mount the volume if needed */
res_1	set	0
dj_1	set	2
fs_1	set	52
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L703+fs_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L702+path_0
	pha
	jsr	_~mount_volume
	sta	<L703+res_1
;	if (res == FR_OK) {
	lda	<L703+res_1
	bne	L10384
;		dj.obj.fs = fs;
	lda	<L703+fs_1
	sta	<L703+dj_1
	lda	<L703+fs_1+2
	sta	<L703+dj_1+2
;		INIT_NAMEBUFF(fs);
;		res = follow_path(&dj, path);		/* Follow the path */
	pei	<L702+path_0+2
	pei	<L702+path_0
	pea	#0
	clc
	tdc
	adc	#<L703+dj_1
	pha
	jsr	_~follow_path
	sta	<L703+res_1
;		if (res == FR_OK) {					/* Follow completed */
	lda	<L703+res_1
	bne	L10385
;			if (dj.fn[NSFLAG] & NS_NONAME) {	/* Is it the start directory itself? */
	sep	#$20
	longa	off
	lda	<L703+dj_1+45
	and	#<$80
	rep	#$20
	longa	on
	beq	L10386
;#if FF_FS_EXFAT
;				if (fs->fs_type == FS_EXFAT) {
;					memcpy(&fs->xcwds, &fs->xcwds2, sizeof fs->xcwds);
;				}
;#endif
;				fs->cdir = dj.obj.sclust;
	lda	<L703+dj_1+8
	ldy	#$14
	sta	[<L703+fs_1],Y
	lda	<L703+dj_1+10
	bra	L20117
L20119:
;#if FF_FS_EXFAT
;					if (fs->fs_type == FS_EXFAT) {
;						memcpy(&fs->xcwds, &fs->xcwds2, sizeof fs->xcwds);
;						fs->cdir = fs->xcwds.tbl[fs->xcwds.depth].d_scl;	/* Sub-directory cluster */
;					} else
;#endif
;					{
;						fs->cdir = ld_clust(fs, dj.dir);	/* Sub-directory cluster */
	pei	<L703+dj_1+32
	pei	<L703+dj_1+30
	pei	<L703+fs_1+2
	pei	<L703+fs_1
	jsr	_~ld_clust
	stx	<R0+2
	ldy	#$14
	sta	[<L703+fs_1],Y
	lda	<R0+2
;					}
;				} else {
L20117:
	ldy	#$16
	sta	[<L703+fs_1],Y
;			} else {
	bra	L10385
L10386:
;				if (dj.obj.attr & AM_DIR) {	/* It is a sub-directory */
	sep	#$20
	longa	off
	lda	<L703+dj_1+6
	and	#<$10
	rep	#$20
	longa	on
	bne	L20119
;					res = FR_NO_PATH;		/* Reached but a file */
	lda	#$5
	sta	<L703+res_1
;				}
;			}
;		}
;		FREE_NAMEBUFF();
L10385:
;		if (res == FR_NO_FILE) res = FR_NO_PATH;
	lda	<L703+res_1
	cmp	#<$4
	bne	L10384
	lda	#$5
	sta	<L703+res_1
;#if FF_STR_VOLUME_ID == 2	/* Also current drive is changed if in Unix style volume ID */
;		if (res == FR_OK) {
;			UINT i;
;
;			for (i = FF_VOLUMES - 1; i && fs != FatFs[i]; i--) ;	/* Set current drive */
;			CurrVol = (BYTE)i;
;		}
;#endif
;	}
;
;	LEAVE_FF(fs, res);
L10384:
	pei	<L703+res_1
	pei	<L703+fs_1+2
	pei	<L703+fs_1
	jsr	_~unlock_volume
	lda	<L703+res_1
	tay
	lda	<L702+1
	sta	<L702+1+4
	pld
	tsc
	clc
	adc	#L702+4
	tcs
	tya
	rts
;}
L702	equ	60
L703	equ	5
	ends
	efunc
;
;
;
;
;#if FF_FS_RPATH >= 2
;/*-----------------------------------------------------------------------*/
;/* API: Get Curent Directory                                             */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_getcwd (
;	TCHAR* buff,	/* Pointer to the buffer to store the current direcotry path */
;	UINT len		/* Size of buff in unit of TCHAR */
;)
;{
	code
	xdef	_~f_getcwd
	func
_~f_getcwd:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L710
	tcs
	phd
	tcd
buff_0	set	3
len_0	set	7
;	FRESULT res;
;	DIR dj;
;	FATFS *fs;
;#if FF_VOLUMES >= 2
;	UINT vl;
;#if FF_STR_VOLUME_ID
;	const char *vid;
;#endif
;#endif
;	FILINFO fno;
;	DEF_NAMEBUFF
;
;
;	buff[0] = 0;	/* A null str to get current drive */
res_1	set	0
dj_1	set	2
fs_1	set	52
fno_1	set	56
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L710+buff_0]
	rep	#$20
	longa	on
;	res = mount_volume((const TCHAR**)&buff, &fs, 0);
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L711+fs_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L710+buff_0
	pha
	jsr	_~mount_volume
	sta	<L711+res_1
;	if (res == FR_OK) {
	lda	<L711+res_1
	beq	*+5
	brl	L10391
;		dj.obj.fs = fs;
	lda	<L711+fs_1
	sta	<L711+dj_1
	lda	<L711+fs_1+2
	sta	<L711+dj_1+2
;		INIT_NAMEBUFF(fs);
;#if FF_FS_EXFAT
;		if (fs->fs_type == FS_EXFAT) {	/* On the exFAT volume */
;			UINT wi = 0;
;			UINT di, ni;
;
;#if FF_VOLUMES >= 2			/* Add drive prefix if needed */
;#if FF_STR_VOLUME_ID == 0	/* Numeric volume ID */
;			if (wi < len) buff[wi++] = '0' + CurrVol;
;#else						/* String volume ID */
;			if (FF_STR_VOLUME_ID == 2 && wi < len) buff[wi++] = '/';
;			for (vid = (const char*)VolumeStr[CurrVol]; *vid && wi < len; buff[wi++] = *vid++) ;
;#endif
;			if (FF_STR_VOLUME_ID <= 1 && wi < len) buff[wi++] = ':';
;#endif
;			if (wi < len) buff[wi++] = '/';
;			for (di = 0; wi < len && di < fs->xcwds.depth; di++) {	/* Follow current directory path with cwd structure */
;				dj.obj.sclust = fs->xcwds.tbl[di].d_scl;		/* Open this directory */
;				dj.obj.stat = (BYTE)fs->xcwds.tbl[di].d_size;
;				dj.obj.objsize = fs->xcwds.tbl[di].d_size & 0xFFFFFF00;
;				res = dir_sdi(&dj, fs->xcwds.tbl[di].nxt_ofs);	/* Find next directory */
;				if (res != FR_OK) break;
;				res = DIR_READ_FILE(&dj);						/* Get the directory name */
;				if (res != FR_OK) break;
;				get_fileinfo(&dj, &fno);
;				if (di > 0 && wi < len) buff[wi++] = '/';		/* Add the directory name with a directory separator */
;				for (ni = 0; fno.fname[ni] && wi < len; buff[wi++] = fno.fname[ni++]) ;
;			}
;			if (wi == len) {	/* Buffer overflow? */
;				res = FR_NOT_ENOUGH_CORE;
;			} else {
;				buff[wi] = 0;	/* Terminate the string */
;			}
;		}
;		else
;#endif
;		{	/* On the FAT/FAT32 volume */
;			TCHAR *tp = buff;
;			UINT i, nl;
;			DWORD ccl;
;
;			/* Follow parent directories toward the root directory and create the cwd path */
;			i = len;			/* Bottom of buffer (directory stack base) */
tp_2	set	78
i_2	set	82
nl_2	set	84
ccl_2	set	86
	lda	<L710+buff_0
	sta	<L711+tp_2
	lda	<L710+buff_0+2
	sta	<L711+tp_2+2
	lda	<L710+len_0
	sta	<L711+i_2
;			dj.obj.sclust = fs->cdir;				/* Start to follow upper directory from current directory */
	ldy	#$14
	lda	[<L711+fs_1],Y
	sta	<L711+dj_1+8
	iny
	iny
	lda	[<L711+fs_1],Y
	sta	<L711+dj_1+10
;			while ((ccl = dj.obj.sclust) != 0) {	/* Repeat while current directory is a sub-directory */
L10392:
	lda	<L711+dj_1+8
	sta	<L711+ccl_2
	lda	<L711+dj_1+10
	sta	<L711+ccl_2+2
	lda	<L711+dj_1+8
	ora	<L711+dj_1+10
	bne	*+5
	brl	L10393
;				res = dir_sdi(&dj, 1 * SZDIRE);		/* Get parent directory */
	pea	#^$20
	pea	#<$20
	pea	#0
	clc
	tdc
	adc	#<L711+dj_1
	pha
	jsr	_~dir_sdi
	sta	<L711+res_1
;				if (res != FR_OK) break;
	lda	<L711+res_1
	beq	*+5
	brl	L10393
;				res = move_window(fs, dj.sect);
	pei	<L711+dj_1+28
	pei	<L711+dj_1+26
	pei	<L711+fs_1+2
	pei	<L711+fs_1
	jsr	_~move_window
	sta	<L711+res_1
;				if (res != FR_OK) break;
	lda	<L711+res_1
	beq	*+5
	brl	L10393
;				dj.obj.sclust = ld_clust(fs, dj.dir);	/* Go to parent directory */
	pei	<L711+dj_1+32
	pei	<L711+dj_1+30
	pei	<L711+fs_1+2
	pei	<L711+fs_1
	jsr	_~ld_clust
	sta	<L711+dj_1+8
	stx	<L711+dj_1+10
;				res = dir_sdi(&dj, 0);
	pea	#^$0
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L711+dj_1
	pha
	jsr	_~dir_sdi
	sta	<L711+res_1
;				if (res != FR_OK) break;
	lda	<L711+res_1
	beq	*+5
	brl	L10393
;				do {								/* Find the entry links to this sub-directory */
L10396:
;					res = DIR_READ_FILE(&dj);
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L711+dj_1
	pha
	jsr	_~dir_read
	sta	<L711+res_1
;					if (res != FR_OK) break;
	lda	<L711+res_1
	bne	L10395
;					if (ccl == ld_clust(fs, dj.dir)) break;	/* Found the entry */
	pei	<L711+dj_1+32
	pei	<L711+dj_1+30
	pei	<L711+fs_1+2
	pei	<L711+fs_1
	jsr	_~ld_clust
	stx	<R0+2
	cmp	<L711+ccl_2
	bne	L718
	lda	<R0+2
	cmp	<L711+ccl_2+2
L718:
	beq	L10395
;					res = dir_next(&dj, 0);
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L711+dj_1
	pha
	jsr	_~dir_next
	sta	<L711+res_1
;				} while (res == FR_OK);
	lda	<L711+res_1
	beq	L10396
L10395:
;				if (res == FR_NO_FILE) res = FR_INT_ERR;	/* It cannot be 'not found'. */
	lda	<L711+res_1
	cmp	#<$4
	bne	L10397
	lda	#$2
	sta	<L711+res_1
;				if (res != FR_OK) break;
L10397:
	lda	<L711+res_1
	bne	L10393
;				get_fileinfo(&dj, &fno);			/* Get the directory name and push it to the buffer */
	pea	#0
	clc
	tdc
	adc	#<L711+fno_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L711+dj_1
	pha
	jsr	_~get_fileinfo
;				for (nl = 0; fno.fname[nl]; nl++) ;	/* Name length */
	stz	<L711+nl_2
	bra	L10401
L10398:
	inc	<L711+nl_2
L10401:
	ldx	<L711+nl_2
	lda	<L711+fno_1+9,X
	and	#$ff
	bne	L10398
;				if (i < nl + 1) {	/* Insufficient space to store the path name? */
	lda	<L711+nl_2
	ina
	sta	<R0
	lda	<L711+i_2
	cmp	<R0
	bcs	L10403
;					res = FR_NOT_ENOUGH_CORE; break;
	lda	#$11
	sta	<L711+res_1
L10393:
;			if (res == FR_OK) {
	lda	<L711+res_1
	beq	L726
L10405:
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L711+tp_2]
	rep	#$20
	longa	on
;		}
;		FREE_NAMEBUFF();
;	}
;
;	LEAVE_FF(fs, res);
L10391:
	pei	<L711+res_1
	pei	<L711+fs_1+2
	pei	<L711+fs_1
	jsr	_~unlock_volume
	lda	<L711+res_1
	tay
	lda	<L710+1
	sta	<L710+1+6
	pld
	tsc
	clc
	adc	#L710+6
	tcs
	tya
	rts
;				}
;				while (nl) buff[--i] = fno.fname[--nl];	/* Stack the name */
L10403:
	lda	<L711+nl_2
	beq	L10404
	dec	<L711+i_2
	dec	<L711+nl_2
	sep	#$20
	longa	off
	ldx	<L711+nl_2
	lda	<L711+fno_1+9,X
	ldy	<L711+i_2
	sta	[<L710+buff_0],Y
	rep	#$20
	longa	on
	bra	L10403
L10404:
;				buff[--i] = '/';
	dec	<L711+i_2
	sep	#$20
	longa	off
	lda	#$2f
	ldy	<L711+i_2
	sta	[<L710+buff_0],Y
	rep	#$20
	longa	on
;			}
	brl	L10392
L726:
;				if (i == len) buff[--i] = '/';	/* Is it the root-directory? */
	lda	<L711+i_2
	cmp	<L710+len_0
	bne	L10406
	dec	<L711+i_2
	sep	#$20
	longa	off
	lda	#$2f
	ldy	<L711+i_2
	sta	[<L710+buff_0],Y
	rep	#$20
	longa	on
;#if FF_VOLUMES >= 2			/* Put drive prefix */
;				vl = 0;
;#if FF_STR_VOLUME_ID >= 1	/* String volume ID */
;				for (nl = 0, vid = (const char*)VolumeStr[CurrVol]; vid[nl]; nl++) ;	/* Volume ID length */
;				if (i >= nl + 2) {
;					if (FF_STR_VOLUME_ID == 2) *tp++ = '/';	/* Unix style */
;					for (vl = 0; vl < nl; *tp++ = vid[vl], vl++) ;
;					if (FF_STR_VOLUME_ID == 1) *tp++ = ':';	/* DOS/Windows style */
;					vl++;
;				}
;#else						/* Numeric volume ID */
;				if (i >= 3) {
;					*tp++ = '0' + CurrVol;
;					*tp++ = ':';
;					vl = 2;
;				}
;#endif
;				if (vl == 0) res = FR_NOT_ENOUGH_CORE;
;#endif
;				/* Add current directory path */
;				if (res == FR_OK) {
L10406:
	lda	<L711+res_1
	bne	L10405
;					do {	/* Copy stacked path string */
L10410:
;						*tp++ = buff[i++];
	sep	#$20
	longa	off
	ldy	<L711+i_2
	lda	[<L710+buff_0],Y
	sta	[<L711+tp_2]
	rep	#$20
	longa	on
	inc	<L711+i_2
	inc	<L711+tp_2
	bne	L10408
	inc	<L711+tp_2+2
;					} while (i < len);
L10408:
	lda	<L711+i_2
	cmp	<L710+len_0
	bcc	L10410
	bra	L10405
;				}
;			}
;			*tp = 0;
;}
L710	equ	94
L711	equ	5
	ends
	efunc
;
;#endif /* FF_FS_RPATH >= 2 */
;#endif /* FF_FS_RPATH >= 1 */
;
;
;
;#if FF_FS_MINIMIZE <= 2
;/*-----------------------------------------------------------------------*/
;/* API: Seek File Read/Write Pointer                                     */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_lseek (
;	FIL* fp,		/* Pointer to the file object */
;	FSIZE_t ofs		/* File pointer from top of file */
;)
;{
	code
	xdef	_~f_lseek
	func
_~f_lseek:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L732
	tcs
	phd
	tcd
fp_0	set	3
ofs_0	set	7
;	FRESULT res;
;	FATFS *fs;
;	DWORD clst, bcs;
;	LBA_t nsect;
;	FSIZE_t ifptr;
;
;
;	res = validate(&fp->obj, &fs);		/* Check validity of the file object */
res_1	set	0
fs_1	set	2
clst_1	set	6
bcs_1	set	10
nsect_1	set	14
ifptr_1	set	18
	pea	#0
	clc
	tdc
	adc	#<L733+fs_1
	pha
	pei	<L732+fp_0+2
	pei	<L732+fp_0
	jsr	_~validate
	sta	<L733+res_1
;	if (res == FR_OK) res = (FRESULT)fp->err;
	lda	<L733+res_1
	bne	L10411
	ldy	#$13
	lda	[<L732+fp_0],Y
	and	#$ff
	sta	<L733+res_1
;#if FF_FS_EXFAT && !FF_FS_READONLY
;	if (res == FR_OK && fs->fs_type == FS_EXFAT) {
;		res = fill_last_frag(&fp->obj, fp->clust, 0xFFFFFFFF);	/* Fill last fragment on the FAT if needed */
;	}
;#endif
;	if (res != FR_OK) LEAVE_FF(fs, res);
L10411:
	lda	<L733+res_1
	beq	L10412
L20127:
	pei	<L733+res_1
	pei	<L733+fs_1+2
	pei	<L733+fs_1
	jsr	_~unlock_volume
	lda	<L733+res_1
L736:
	tay
	lda	<L732+1
	sta	<L732+1+8
	pld
	tsc
	clc
	adc	#L732+8
	tcs
	tya
	rts
L10412:
;
;#if FF_USE_FASTSEEK
;	if (fp->cltbl) {	/* Fast seek */
	ldy	#$28
	lda	[<L732+fp_0],Y
	iny
	iny
	ora	[<L732+fp_0],Y
	bne	*+5
	brl	L10413
;		DWORD cl, pcl, ncl, tcl, tlen, ulen;
;		DWORD *tbl;
;		LBA_t dsc;
;
;		if (ofs == CREATE_LINKMAP) {	/* Create CLMT */
cl_2	set	22
pcl_2	set	26
ncl_2	set	30
tcl_2	set	34
tlen_2	set	38
ulen_2	set	42
tbl_2	set	46
dsc_2	set	50
	lda	<L732+ofs_0
	cmp	#<$ffffffff
	bne	L738
	lda	<L732+ofs_0+2
	cmp	#^$ffffffff
L738:
	beq	*+5
	brl	L10414
;			tbl = fp->cltbl;
	ldy	#$28
	lda	[<L732+fp_0],Y
	sta	<L733+tbl_2
	iny
	iny
	lda	[<L732+fp_0],Y
	sta	<L733+tbl_2+2
;			tlen = *tbl++; ulen = 2;	/* Given table size and required table size */
	lda	[<L733+tbl_2]
	sta	<L733+tlen_2
	ldy	#$2
	lda	[<L733+tbl_2],Y
	sta	<L733+tlen_2+2
	lda	#$4
	clc
	adc	<L733+tbl_2
	sta	<L733+tbl_2
	bcc	L740
	inc	<L733+tbl_2+2
L740:
	lda	#$2
	sta	<L733+ulen_2
	dea
	dea
	sta	<L733+ulen_2+2
;			cl = fp->obj.sclust;		/* Origin of the chain */
	ldy	#$8
	lda	[<L732+fp_0],Y
	sta	<L733+cl_2
	iny
	iny
	lda	[<L732+fp_0],Y
	sta	<L733+cl_2+2
;			if (cl != 0) {
	lda	<L733+cl_2
	ora	<L733+cl_2+2
	bne	*+5
	brl	L10415
;				do {
L10418:
;					/* Get a fragment */
;					tcl = cl; ncl = 0; ulen += 2;	/* Top, length and used items */
	lda	<L733+cl_2
	sta	<L733+tcl_2
	lda	<L733+cl_2+2
	sta	<L733+tcl_2+2
	stz	<L733+ncl_2
	stz	<L733+ncl_2+2
	lda	#$2
	clc
	adc	<L733+ulen_2
	sta	<L733+ulen_2
	bcc	L10421
	inc	<L733+ulen_2+2
;					do {
L10421:
;						pcl = cl; ncl++;
	lda	<L733+cl_2
	sta	<L733+pcl_2
	lda	<L733+cl_2+2
	sta	<L733+pcl_2+2
	inc	<L733+ncl_2
	bne	L743
	inc	<L733+ncl_2+2
L743:
;						cl = get_fat(&fp->obj, cl);
	pei	<L733+cl_2+2
	pei	<L733+cl_2
	pei	<L732+fp_0+2
	pei	<L732+fp_0
	jsr	_~get_fat
	sta	<L733+cl_2
	stx	<L733+cl_2+2
;						if (cl <= 1) ABORT(fs, FR_INT_ERR);
	lda	#$1
	cmp	<L733+cl_2
	dea
	sbc	<L733+cl_2+2
	bcc	L10422
	sep	#$20
	longa	off
	lda	#$2
	ldy	#$13
	sta	[<L732+fp_0],Y
	rep	#$20
	longa	on
L20132:
	pea	#<$2
	pei	<L733+fs_1+2
	pei	<L733+fs_1
	jsr	_~unlock_volume
	lda	#$2
	brl	L736
L10422:
;						if (cl == 0xFFFFFFFF) ABORT(fs, FR_DISK_ERR);
	lda	<L733+cl_2
	cmp	#<$ffffffff
	bne	L745
	lda	<L733+cl_2+2
	cmp	#^$ffffffff
L745:
	bne	L10419
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L732+fp_0],Y
	rep	#$20
	longa	on
L20149:
	pea	#<$1
	pei	<L733+fs_1+2
	pei	<L733+fs_1
	jsr	_~unlock_volume
	lda	#$1
	brl	L736
;					} while (cl == pcl + 1);
L10419:
	lda	#$1
	clc
	adc	<L733+pcl_2
	sta	<R0
	lda	#$0
	adc	<L733+pcl_2+2
	sta	<R0+2
	lda	<R0
	cmp	<L733+cl_2
	bne	L747
	lda	<R0+2
	cmp	<L733+cl_2+2
L747:
	bne	*+5
	brl	L10421
;					if (ulen <= tlen) {		/* Store the length and top of the fragment */
	lda	<L733+tlen_2
	cmp	<L733+ulen_2
	lda	<L733+tlen_2+2
	sbc	<L733+ulen_2+2
	bcc	L10416
;						*tbl++ = ncl; *tbl++ = tcl;
	lda	<L733+ncl_2
	sta	[<L733+tbl_2]
	lda	<L733+ncl_2+2
	ldy	#$2
	sta	[<L733+tbl_2],Y
	lda	#$4
	clc
	adc	<L733+tbl_2
	sta	<L733+tbl_2
	bcc	L750
	inc	<L733+tbl_2+2
L750:
	lda	<L733+tcl_2
	sta	[<L733+tbl_2]
	lda	<L733+tcl_2+2
	ldy	#$2
	sta	[<L733+tbl_2],Y
	lda	#$4
	clc
	adc	<L733+tbl_2
	sta	<L733+tbl_2
	bcc	L10416
	inc	<L733+tbl_2+2
;					}
;				} while (cl < fs->n_fatent);	/* Repeat until end of chain */
L10416:
	lda	<L733+cl_2
	ldy	#$18
	cmp	[<L733+fs_1],Y
	lda	<L733+cl_2+2
	iny
	iny
	sbc	[<L733+fs_1],Y
	bcs	*+5
	brl	L10418
;			}
;			*fp->cltbl = ulen;	/* Number of items used */
L10415:
	ldy	#$28
	lda	[<L732+fp_0],Y
	sta	<R0
	iny
	iny
	lda	[<L732+fp_0],Y
	sta	<R0+2
	lda	<L733+ulen_2
	sta	[<R0]
	lda	<L733+ulen_2+2
	ldy	#$2
	sta	[<R0],Y
;			if (ulen <= tlen) {
	lda	<L733+tlen_2
	cmp	<L733+ulen_2
	lda	<L733+tlen_2+2
	sbc	<L733+ulen_2+2
	bcc	L10425
;				*tbl = 0;		/* Terminate table */
	lda	#$0
	sta	[<L733+tbl_2]
	sta	[<L733+tbl_2],Y
;			} else {
	brl	L20127
L10425:
;				res = FR_NOT_ENOUGH_CORE;	/* Given table size is smaller than required */
	lda	#$11
	sta	<L733+res_1
;			}
;		} else {						/* Fast seek */
	brl	L20127
L10414:
;			if (ofs > fp->obj.objsize) ofs = fp->obj.objsize;	/* Clip offset at the file size */
	ldy	#$c
	lda	[<L732+fp_0],Y
	cmp	<L732+ofs_0
	iny
	iny
	lda	[<L732+fp_0],Y
	sbc	<L732+ofs_0+2
	bcs	L10428
	dey
	dey
	lda	[<L732+fp_0],Y
	sta	<L732+ofs_0
	iny
	iny
	lda	[<L732+fp_0],Y
	sta	<L732+ofs_0+2
;			fp->fptr = ofs;				/* Set file pointer */
L10428:
	lda	<L732+ofs_0
	ldy	#$14
	sta	[<L732+fp_0],Y
	lda	<L732+ofs_0+2
	iny
	iny
	sta	[<L732+fp_0],Y
;			if (ofs > 0) {
	lda	#$0
	cmp	<L732+ofs_0
	sbc	<L732+ofs_0+2
	bcc	*+5
	brl	L20127
;				fp->clust = clmt_clust(fp, ofs - 1);
	lda	#$ffff
	clc
	adc	<L732+ofs_0
	sta	<R0
	lda	#$ffff
	adc	<L732+ofs_0+2
	pha
	pei	<R0
	pei	<L732+fp_0+2
	pei	<L732+fp_0
	jsr	_~clmt_clust
	stx	<R1+2
	ldy	#$18
	sta	[<L732+fp_0],Y
	lda	<R1+2
	iny
	iny
	sta	[<L732+fp_0],Y
;				dsc = clst2sect(fs, fp->clust);
	pha
	dey
	dey
	lda	[<L732+fp_0],Y
	pha
	pei	<L733+fs_1+2
	pei	<L733+fs_1
	jsr	_~clst2sect
	sta	<L733+dsc_2
	stx	<L733+dsc_2+2
;				if (dsc == 0) ABORT(fs, FR_INT_ERR);
	ora	<L733+dsc_2+2
	bne	L10430
	sep	#$20
	longa	off
	lda	#$2
	ldy	#$13
	sta	[<L732+fp_0],Y
	rep	#$20
	longa	on
	brl	L20132
L10430:
;				dsc += (DWORD)((ofs - 1) / SS(fs)) & (fs->csize - 1);
	lda	#$ffff
	clc
	adc	<L732+ofs_0
	sta	<R1
	lda	#$ffff
	adc	<L732+ofs_0+2
	pha
	pei	<R1
	lda	#$9
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R0
	stx	<R0+2
	clc
	lda	#$ffff
	ldy	#$a
	adc	[<L733+fs_1],Y
	sta	<R2
	stz	<R2+2
	lda	<R2
	and	<R0
	sta	<R3
	lda	<R2+2
	and	<R0+2
	sta	<R3+2
	lda	<R3
	clc
	adc	<L733+dsc_2
	sta	<L733+dsc_2
	lda	<R3+2
	adc	<L733+dsc_2+2
	sta	<L733+dsc_2+2
;				if (fp->fptr % SS(fs) && dsc != fp->sect) {	/* Refill sector cache if needed */
	ldy	#$14
	lda	[<L732+fp_0],Y
	and	#<$1ff
	bne	*+5
	brl	L20127
	lda	<L733+dsc_2
	ldy	#$1c
	cmp	[<L732+fp_0],Y
	bne	L758
	lda	<L733+dsc_2+2
	iny
	iny
	cmp	[<L732+fp_0],Y
L758:
	bne	*+5
	brl	L20127
;#if !FF_FS_TINY
;#if !FF_FS_READONLY
;					if (fp->flag & FA_DIRTY) {		/* Write-back dirty sector cache */
	sep	#$20
	longa	off
	ldy	#$12
	lda	[<L732+fp_0],Y
	and	#<$80
	rep	#$20
	longa	on
	beq	L10432
;						if (disk_write(fs->pdrv, fp->buf, fp->sect, 1) != RES_OK) ABORT(fs, FR_DISK_ERR);
	pea	#<$1
	ldy	#$1e
	lda	[<L732+fp_0],Y
	pha
	dey
	dey
	lda	[<L732+fp_0],Y
	pha
	lda	#$2c
	clc
	adc	<L732+fp_0
	sta	<R0
	lda	#$0
	adc	<L732+fp_0+2
	pha
	pei	<R0
	ldy	#$1
	lda	[<L733+fs_1],Y
	pha
	jsr	_~disk_write
	tax
	beq	L10433
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L732+fp_0],Y
	rep	#$20
	longa	on
	brl	L20149
L10433:
;						fp->flag &= (BYTE)~FA_DIRTY;
	lda	#$12
	clc
	adc	<L732+fp_0
	sta	<R0
	lda	#$0
	adc	<L732+fp_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	and	#<$7f
	sta	[<R0]
	rep	#$20
	longa	on
;					}
;#endif
;					if (disk_read(fs->pdrv, fp->buf, dsc, 1) != RES_OK) ABORT(fs, FR_DISK_ERR);	/* Load current sector */
L10432:
	pea	#<$1
	pei	<L733+dsc_2+2
	pei	<L733+dsc_2
	lda	#$2c
	clc
	adc	<L732+fp_0
	sta	<R0
	lda	#$0
	adc	<L732+fp_0+2
	pha
	pei	<R0
	ldy	#$1
	lda	[<L733+fs_1],Y
	pha
	jsr	_~disk_read
	tax
	beq	L10434
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L732+fp_0],Y
	rep	#$20
	longa	on
	brl	L20149
L10434:
;#endif
;					fp->sect = dsc;
	lda	<L733+dsc_2
	ldy	#$1c
	sta	[<L732+fp_0],Y
	lda	<L733+dsc_2+2
	brl	L20124
;				}
;			}
;		}
;	} else
L10413:
;#endif
;
;	/* Normal Seek */
;	{
;#if FF_FS_EXFAT
;		if (fs->fs_type != FS_EXFAT && ofs >= 0x100000000) ofs = 0xFFFFFFFF;	/* Clip at 4 GiB - 1 if at FATxx */
;#endif
;		if (ofs > fp->obj.objsize && (FF_FS_READONLY || !(fp->flag & FA_WRITE))) {	/* In read-only mode, clip offset with the file size */
	ldy	#$c
	lda	[<L732+fp_0],Y
	cmp	<L732+ofs_0
	iny
	iny
	lda	[<L732+fp_0],Y
	sbc	<L732+ofs_0+2
	bcs	L10436
	sep	#$20
	longa	off
	ldy	#$12
	lda	[<L732+fp_0],Y
	and	#<$2
	rep	#$20
	longa	on
	bne	L10436
;			ofs = fp->obj.objsize;
	ldy	#$c
	lda	[<L732+fp_0],Y
	sta	<L732+ofs_0
	iny
	iny
	lda	[<L732+fp_0],Y
	sta	<L732+ofs_0+2
;		}
;		ifptr = fp->fptr;
L10436:
	ldy	#$14
	lda	[<L732+fp_0],Y
	sta	<L733+ifptr_1
	iny
	iny
	lda	[<L732+fp_0],Y
	sta	<L733+ifptr_1+2
;		fp->fptr = nsect = 0;
	stz	<L733+nsect_1
	stz	<L733+nsect_1+2
	lda	#$0
	dey
	dey
	sta	[<L732+fp_0],Y
	iny
	iny
	sta	[<L732+fp_0],Y
;		if (ofs > 0) {
	cmp	<L732+ofs_0
	sbc	<L732+ofs_0+2
	bcc	*+5
	brl	L10437
;			bcs = (DWORD)fs->csize * SS(fs);	/* Cluster size (byte) */
	ldy	#$a
	lda	[<L733+fs_1],Y
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$9
	xref	_~~lasl
	jsr	_~~lasl
	sta	<L733+bcs_1
	stx	<L733+bcs_1+2
;			if (ifptr > 0 &&
;				(ofs - 1) / bcs >= (ifptr - 1) / bcs) {	/* When seek to same or following cluster, */
	lda	#$0
	cmp	<L733+ifptr_1
	sbc	<L733+ifptr_1+2
	bcc	*+5
	brl	L10438
	lda	#$ffff
	clc
	adc	<L733+ifptr_1
	sta	<R0
	lda	#$ffff
	adc	<L733+ifptr_1+2
	sta	<R0+2
	pei	<L733+bcs_1+2
	pei	<L733+bcs_1
	pei	<R0+2
	pei	<R0
	xref	_~~ludv
	jsr	_~~ludv
	sta	<R0
	stx	<R0+2
	lda	#$ffff
	clc
	adc	<L732+ofs_0
	sta	<R1
	lda	#$ffff
	adc	<L732+ofs_0+2
	sta	<R1+2
	pei	<L733+bcs_1+2
	pei	<L733+bcs_1
	pei	<R1+2
	pei	<R1
	xref	_~~ludv
	jsr	_~~ludv
	stx	<R1+2
	cmp	<R0
	lda	<R1+2
	sbc	<R0+2
	bcc	L10438
;				fp->fptr = (ifptr - 1) & ~(FSIZE_t)(bcs - 1);	/* start from the current cluster */
	lda	#$ffff
	clc
	adc	<L733+ifptr_1
	sta	<R0
	lda	#$ffff
	adc	<L733+ifptr_1+2
	sta	<R0+2
	lda	#$ffff
	clc
	adc	<L733+bcs_1
	sta	<R1
	lda	#$ffff
	adc	<L733+bcs_1+2
	sta	<R1+2
	lda	<R1
	eor	#<$ffffffff
	sta	<R2
	lda	<R1+2
	eor	#^$ffffffff
	sta	<R2+2
	lda	<R2
	and	<R0
	sta	<R1
	lda	<R2+2
	and	<R0+2
	sta	<R1+2
	lda	<R1
	ldy	#$14
	sta	[<L732+fp_0],Y
	lda	<R1+2
	iny
	iny
	sta	[<L732+fp_0],Y
;				ofs -= fp->fptr;
	sec
	lda	<L732+ofs_0
	dey
	dey
	sbc	[<L732+fp_0],Y
	sta	<L732+ofs_0
	lda	<L732+ofs_0+2
	iny
	iny
	sbc	[<L732+fp_0],Y
	sta	<L732+ofs_0+2
;				clst = fp->clust;
	iny
	iny
	lda	[<L732+fp_0],Y
	sta	<L733+clst_1
	iny
	iny
	lda	[<L732+fp_0],Y
	sta	<L733+clst_1+2
;			} else {									/* When seek to back cluster, */
	bra	L10439
L10438:
;				clst = fp->obj.sclust;					/* start from the first cluster */
	ldy	#$8
	lda	[<L732+fp_0],Y
	sta	<L733+clst_1
	iny
	iny
	lda	[<L732+fp_0],Y
	sta	<L733+clst_1+2
;#if !FF_FS_READONLY
;				if (clst == 0) {						/* If no cluster chain, create a new chain */
	lda	<L733+clst_1
	ora	<L733+clst_1+2
	bne	L10440
;					clst = create_chain(&fp->obj, 0);
	pea	#^$0
	pea	#<$0
	pei	<L732+fp_0+2
	pei	<L732+fp_0
	jsr	_~create_chain
	sta	<L733+clst_1
	stx	<L733+clst_1+2
;					if (clst == 1) ABORT(fs, FR_INT_ERR);
	cmp	#<$1
	bne	L770
	lda	<L733+clst_1+2
	cmp	#^$1
L770:
	bne	L10441
	sep	#$20
	longa	off
	lda	#$2
	ldy	#$13
	sta	[<L732+fp_0],Y
	rep	#$20
	longa	on
	brl	L20132
L10441:
;					if (clst == 0xFFFFFFFF) ABORT(fs, FR_DISK_ERR);
	lda	<L733+clst_1
	cmp	#<$ffffffff
	bne	L772
	lda	<L733+clst_1+2
	cmp	#^$ffffffff
L772:
	bne	L10442
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L732+fp_0],Y
	rep	#$20
	longa	on
	brl	L20149
L10442:
;					fp->obj.sclust = clst;
	lda	<L733+clst_1
	ldy	#$8
	sta	[<L732+fp_0],Y
	lda	<L733+clst_1+2
	iny
	iny
	sta	[<L732+fp_0],Y
;				}
;#endif
;				fp->clust = clst;
L10440:
	lda	<L733+clst_1
	ldy	#$18
	sta	[<L732+fp_0],Y
	lda	<L733+clst_1+2
	iny
	iny
	sta	[<L732+fp_0],Y
;			}
L10439:
;			if (clst != 0) {
	lda	<L733+clst_1
	ora	<L733+clst_1+2
	bne	*+5
	brl	L10437
;				while (ofs > bcs) {						/* Cluster following loop */
L10444:
	lda	<L733+bcs_1
	cmp	<L732+ofs_0
	lda	<L733+bcs_1+2
	sbc	<L732+ofs_0+2
	bcc	*+5
	brl	L10445
;					ofs -= bcs; fp->fptr += bcs;
	sec
	lda	<L732+ofs_0
	sbc	<L733+bcs_1
	sta	<L732+ofs_0
	lda	<L732+ofs_0+2
	sbc	<L733+bcs_1+2
	sta	<L732+ofs_0+2
	lda	#$14
	clc
	adc	<L732+fp_0
	sta	<R0
	lda	#$0
	adc	<L732+fp_0+2
	sta	<R0+2
	lda	[<R0]
	clc
	adc	<L733+bcs_1
	sta	[<R0]
	ldy	#$2
	lda	[<R0],Y
	adc	<L733+bcs_1+2
	sta	[<R0],Y
;#if !FF_FS_READONLY
;					if (fp->flag & FA_WRITE) {			/* Check if in write mode or not */
	sep	#$20
	longa	off
	ldy	#$12
	lda	[<L732+fp_0],Y
	and	#<$2
	rep	#$20
	longa	on
	bne	L10447
;#endif
;					{
;						clst = get_fat(&fp->obj, clst);	/* Follow cluster chain if not in write mode */
	pei	<L733+clst_1+2
	pei	<L733+clst_1
	pei	<L732+fp_0+2
	pei	<L732+fp_0
	jsr	_~get_fat
	sta	<L733+clst_1
	stx	<L733+clst_1+2
;					}
L10448:
;					if (clst == 0xFFFFFFFF) ABORT(fs, FR_DISK_ERR);
	lda	<L733+clst_1
	cmp	#<$ffffffff
	bne	L779
	lda	<L733+clst_1+2
	cmp	#^$ffffffff
L779:
	bne	L20120
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L732+fp_0],Y
	rep	#$20
	longa	on
	brl	L20149
L20120:
;					if (clst <= 1 || clst >= fs->n_fatent) ABORT(fs, FR_INT_ERR);
	lda	#$1
	cmp	<L733+clst_1
	dea
	sbc	<L733+clst_1+2
	bcc	L782
L781:
	sep	#$20
	longa	off
	lda	#$2
	ldy	#$13
	sta	[<L732+fp_0],Y
	rep	#$20
	longa	on
	brl	L20132
;						if (FF_FS_EXFAT && fp->fptr > fp->obj.objsize) {	/* No FAT chain object needs correct objsize to generate FAT value */
;							fp->obj.objsize = fp->fptr;
;							fp->flag |= FA_MODIFIED;
;						}
;						clst = create_chain(&fp->obj, clst);	/* Follow chain with forceed stretch */
L10447:
	pei	<L733+clst_1+2
	pei	<L733+clst_1
	pei	<L732+fp_0+2
	pei	<L732+fp_0
	jsr	_~create_chain
	sta	<L733+clst_1
	stx	<L733+clst_1+2
;						if (clst == 0) {				/* Clip file size in case of disk full */
	ora	<L733+clst_1+2
	bne	L10448
;							ofs = 0; break;
	stz	<L732+ofs_0
	stz	<L732+ofs_0+2
L10445:
;				fp->fptr += ofs;
	lda	#$14
	clc
	adc	<L732+fp_0
	sta	<R0
	lda	#$0
	adc	<L732+fp_0+2
	sta	<R0+2
	lda	[<R0]
	clc
	adc	<L732+ofs_0
	sta	[<R0]
	ldy	#$2
	lda	[<R0],Y
	adc	<L732+ofs_0+2
	sta	[<R0],Y
;				if (ofs % SS(fs)) {
	lda	<L732+ofs_0
	and	#<$1ff
	bne	L784
	bra	L10437
;						}
;					} else
L782:
	lda	<L733+clst_1
	ldy	#$18
	cmp	[<L733+fs_1],Y
	lda	<L733+clst_1+2
	iny
	iny
	sbc	[<L733+fs_1],Y
	bcs	L781
;					fp->clust = clst;
	lda	<L733+clst_1
	dey
	dey
	sta	[<L732+fp_0],Y
	lda	<L733+clst_1+2
	iny
	iny
	sta	[<L732+fp_0],Y
;				}
	brl	L10444
L784:
;					nsect = clst2sect(fs, clst);	/* Current sector */
	pei	<L733+clst_1+2
	pei	<L733+clst_1
	pei	<L733+fs_1+2
	pei	<L733+fs_1
	jsr	_~clst2sect
	sta	<L733+nsect_1
	stx	<L733+nsect_1+2
;					if (nsect == 0) ABORT(fs, FR_INT_ERR);
	ora	<L733+nsect_1+2
	bne	L10453
	sep	#$20
	longa	off
	lda	#$2
	ldy	#$13
	sta	[<L732+fp_0],Y
	rep	#$20
	longa	on
	brl	L20132
L10453:
;					nsect += (DWORD)(ofs / SS(fs));
	pei	<L732+ofs_0+2
	pei	<L732+ofs_0
	lda	#$9
	xref	_~~llsr
	jsr	_~~llsr
	stx	<R0+2
	clc
	adc	<L733+nsect_1
	sta	<L733+nsect_1
	lda	<R0+2
	adc	<L733+nsect_1+2
	sta	<L733+nsect_1+2
;				}
;			}
;		}
;		if (!FF_FS_READONLY && fp->fptr > fp->obj.objsize) {	/* Set file change flag if the file size is extended */
L10437:
	ldy	#$c
	lda	[<L732+fp_0],Y
	ldy	#$14
	cmp	[<L732+fp_0],Y
	ldy	#$e
	lda	[<L732+fp_0],Y
	ldy	#$16
	sbc	[<L732+fp_0],Y
	bcs	L10454
;			fp->obj.objsize = fp->fptr;
	dey
	dey
	lda	[<L732+fp_0],Y
	ldy	#$c
	sta	[<L732+fp_0],Y
	ldy	#$16
	lda	[<L732+fp_0],Y
	ldy	#$e
	sta	[<L732+fp_0],Y
;			fp->flag |= FA_MODIFIED;
	lda	#$12
	clc
	adc	<L732+fp_0
	sta	<R0
	lda	#$0
	adc	<L732+fp_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$40
	sta	[<R0]
	rep	#$20
	longa	on
;		}
;		if (fp->fptr % SS(fs) && nsect != fp->sect) {	/* Fill sector cache if needed */
L10454:
	ldy	#$14
	lda	[<L732+fp_0],Y
	and	#<$1ff
	bne	*+5
	brl	L20127
	lda	<L733+nsect_1
	ldy	#$1c
	cmp	[<L732+fp_0],Y
	bne	L788
	lda	<L733+nsect_1+2
	iny
	iny
	cmp	[<L732+fp_0],Y
L788:
	bne	*+5
	brl	L20127
;#if !FF_FS_TINY
;#if !FF_FS_READONLY
;			if (fp->flag & FA_DIRTY) {			/* Write-back dirty sector cache */
	sep	#$20
	longa	off
	ldy	#$12
	lda	[<L732+fp_0],Y
	and	#<$80
	rep	#$20
	longa	on
	beq	L10456
;				if (disk_write(fs->pdrv, fp->buf, fp->sect, 1) != RES_OK) ABORT(fs, FR_DISK_ERR);
	pea	#<$1
	ldy	#$1e
	lda	[<L732+fp_0],Y
	pha
	dey
	dey
	lda	[<L732+fp_0],Y
	pha
	lda	#$2c
	clc
	adc	<L732+fp_0
	sta	<R0
	lda	#$0
	adc	<L732+fp_0+2
	pha
	pei	<R0
	ldy	#$1
	lda	[<L733+fs_1],Y
	pha
	jsr	_~disk_write
	tax
	beq	L10457
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L732+fp_0],Y
	rep	#$20
	longa	on
	brl	L20149
L10457:
;				fp->flag &= (BYTE)~FA_DIRTY;
	lda	#$12
	clc
	adc	<L732+fp_0
	sta	<R0
	lda	#$0
	adc	<L732+fp_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	and	#<$7f
	sta	[<R0]
	rep	#$20
	longa	on
;			}
;#endif
;			if (disk_read(fs->pdrv, fp->buf, nsect, 1) != RES_OK) ABORT(fs, FR_DISK_ERR);	/* Fill sector cache */
L10456:
	pea	#<$1
	pei	<L733+nsect_1+2
	pei	<L733+nsect_1
	lda	#$2c
	clc
	adc	<L732+fp_0
	sta	<R0
	lda	#$0
	adc	<L732+fp_0+2
	pha
	pei	<R0
	ldy	#$1
	lda	[<L733+fs_1],Y
	pha
	jsr	_~disk_read
	tax
	beq	L10458
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L732+fp_0],Y
	rep	#$20
	longa	on
	brl	L20149
L10458:
;#endif
;			fp->sect = nsect;
	lda	<L733+nsect_1
	ldy	#$1c
	sta	[<L732+fp_0],Y
	lda	<L733+nsect_1+2
L20124:
	ldy	#$1e
	sta	[<L732+fp_0],Y
;		}
;	}
;
;	LEAVE_FF(fs, res);
	brl	L20127
;}
L732	equ	70
L733	equ	17
	ends
	efunc
;
;
;
;#if FF_FS_MINIMIZE <= 1
;/*-----------------------------------------------------------------------*/
;/* API: Create a Directory Object                                        */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_opendir (
;	DIR* dp,			/* Pointer to directory object to create */
;	const TCHAR* path	/* Pointer to the directory path */
;)
;{
	code
	xdef	_~f_opendir
	func
_~f_opendir:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L793
	tcs
	phd
	tcd
dp_0	set	3
path_0	set	7
;	FRESULT res;
;	FATFS *fs;
;	DEF_NAMEBUFF
;
;
;	if (!dp) return FR_INVALID_OBJECT;	/* Reject null pointer */
res_1	set	0
fs_1	set	2
	lda	<L793+dp_0
	ora	<L793+dp_0+2
	bne	L10459
	lda	#$9
L796:
	tay
	lda	<L793+1
	sta	<L793+1+8
	pld
	tsc
	clc
	adc	#L793+8
	tcs
	tya
	rts
;
;	res = mount_volume(&path, &fs, 0);	/* Get logical drive and mount the volume if needed */
L10459:
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L794+fs_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L793+path_0
	pha
	jsr	_~mount_volume
	sta	<L794+res_1
;	if (res == FR_OK) {
	lda	<L794+res_1
	beq	*+5
	brl	L10460
;		dp->obj.fs = fs;
	lda	<L794+fs_1
	sta	[<L793+dp_0]
	lda	<L794+fs_1+2
	ldy	#$2
	sta	[<L793+dp_0],Y
;		INIT_NAMEBUFF(fs);
;		res = follow_path(dp, path);			/* Follow the path to the directory */
	pei	<L793+path_0+2
	pei	<L793+path_0
	pei	<L793+dp_0+2
	pei	<L793+dp_0
	jsr	_~follow_path
	sta	<L794+res_1
;		if (res == FR_OK) {						/* Follow completed */
	lda	<L794+res_1
	beq	*+5
	brl	L10461
;			if (!(dp->fn[NSFLAG] & NS_NONAME)) {	/* It is neither the origin directory itself nor dot name in exFAT */
	sep	#$20
	longa	off
	ldy	#$2d
	lda	[<L793+dp_0],Y
	and	#<$80
	rep	#$20
	longa	on
	bne	L10462
;				if (dp->obj.attr & AM_DIR) {		/* This object is a sub-directory */
	sep	#$20
	longa	off
	ldy	#$6
	lda	[<L793+dp_0],Y
	and	#<$10
	rep	#$20
	longa	on
	beq	L10463
;#if FF_FS_EXFAT
;					if (fs->fs_type == FS_EXFAT) {
;						init_alloc_info(&dp->obj, dp);	/* Get object allocation info */
;					} else
;#endif
;					{
;						dp->obj.sclust = ld_clust(fs, dp->dir);	/* Get object allocation info */
	ldy	#$20
	lda	[<L793+dp_0],Y
	pha
	dey
	dey
	lda	[<L793+dp_0],Y
	pha
	pei	<L794+fs_1+2
	pei	<L794+fs_1
	jsr	_~ld_clust
	stx	<R0+2
	ldy	#$8
	sta	[<L793+dp_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L793+dp_0],Y
;					}
;				} else {						/* This object is a file */
	bra	L10462
L10463:
;					res = FR_NO_PATH;
	lda	#$5
	sta	<L794+res_1
;				}
;			}
;			if (res == FR_OK) {
L10462:
	lda	<L794+res_1
	bne	L10461
;				dp->obj.id = fs->id;		/* Set current volume mount ID */
	ldy	#$6
	lda	[<L794+fs_1],Y
	dey
	dey
	sta	[<L793+dp_0],Y
;				res = dir_sdi(dp, 0);		/* Rewind directory */
	pea	#^$0
	pea	#<$0
	pei	<L793+dp_0+2
	pei	<L793+dp_0
	jsr	_~dir_sdi
	sta	<L794+res_1
;#if FF_FS_LOCK
;				if (res == FR_OK) {
	lda	<L794+res_1
	bne	L10461
;					if (dp->obj.sclust) {	/* Is this a sub-directory? */
	ldy	#$8
	lda	[<L793+dp_0],Y
	iny
	iny
	ora	[<L793+dp_0],Y
	beq	L10467
;						dp->obj.lockid = inc_share(dp, 0);	/* Lock the sub-directory */
	pea	#<$0
	pei	<L793+dp_0+2
	pei	<L793+dp_0
	jsr	_~inc_share
	ldy	#$10
	sta	[<L793+dp_0],Y
;						if (!dp->obj.lockid) res = FR_TOO_MANY_OPEN_FILES;
	lda	[<L793+dp_0],Y
	bne	L10461
	lda	#$12
	sta	<L794+res_1
;					} else {
	bra	L10461
L10467:
;						dp->obj.lockid = 0;	/* Root directory does not need to be locked */
	lda	#$0
	ldy	#$10
	sta	[<L793+dp_0],Y
;					}
;				}
;#endif
;			}
;		}
;		FREE_NAMEBUFF();
L10461:
;		if (res == FR_NO_FILE) res = FR_NO_PATH;
	lda	<L794+res_1
	cmp	#<$4
	bne	L10460
	lda	#$5
	sta	<L794+res_1
;	}
;	if (res != FR_OK) dp->obj.fs = 0;		/* Invalidate the directory object if function failed */
L10460:
	lda	<L794+res_1
	beq	L10471
	lda	#$0
	sta	[<L793+dp_0]
	ldy	#$2
	sta	[<L793+dp_0],Y
;
;	LEAVE_FF(fs, res);
L10471:
	pei	<L794+res_1
	pei	<L794+fs_1+2
	pei	<L794+fs_1
	jsr	_~unlock_volume
	lda	<L794+res_1
	brl	L796
;}
L793	equ	10
L794	equ	5
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Close Directory                                                  */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_closedir (
;	DIR *dp		/* Pointer to the directory object to be closed */
;)
;{
	code
	xdef	_~f_closedir
	func
_~f_closedir:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L807
	tcs
	phd
	tcd
dp_0	set	3
;	FRESULT res;
;	FATFS *fs;
;
;
;	res = validate(&dp->obj, &fs);	/* Check validity of the file object */
res_1	set	0
fs_1	set	2
	pea	#0
	clc
	tdc
	adc	#<L808+fs_1
	pha
	pei	<L807+dp_0+2
	pei	<L807+dp_0
	jsr	_~validate
	sta	<L808+res_1
;	if (res == FR_OK) {
	lda	<L808+res_1
	bne	L10472
;#if FF_FS_LOCK
;		if (dp->obj.lockid) res = dec_share(dp->obj.lockid);	/* Decrement sub-directory open counter */
	ldy	#$10
	lda	[<L807+dp_0],Y
	beq	L10473
	lda	[<L807+dp_0],Y
	pha
	jsr	_~dec_share
	sta	<L808+res_1
;		if (res == FR_OK) dp->obj.fs = 0;	/* Invalidate directory object */
L10473:
	lda	<L808+res_1
	bne	L10474
	lda	#$0
	sta	[<L807+dp_0]
	ldy	#$2
	sta	[<L807+dp_0],Y
;#else
;		dp->obj.fs = 0;	/* Invalidate directory object */
;#endif
;#if FF_FS_REENTRANT
;		unlock_volume(fs, FR_OK);	/* Unlock volume */
L10474:
	pea	#<$0
	pei	<L808+fs_1+2
	pei	<L808+fs_1
	jsr	_~unlock_volume
;#endif
;	}
;	return res;
L10472:
	lda	<L808+res_1
	tay
	lda	<L807+1
	sta	<L807+1+4
	pld
	tsc
	clc
	adc	#L807+4
	tcs
	tya
	rts
;}
L807	equ	6
L808	equ	1
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Read Directory Entries in Sequence                               */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_readdir (
;	DIR* dp,			/* Pointer to the open directory object */
;	FILINFO* fno		/* Pointer to file information to return */
;)
;{
	code
	xdef	_~f_readdir
	func
_~f_readdir:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L813
	tcs
	phd
	tcd
dp_0	set	3
fno_0	set	7
;	FRESULT res;
;	FATFS *fs;
;	DEF_NAMEBUFF
;
;
;	res = validate(&dp->obj, &fs);	/* Check validity of the directory object */
res_1	set	0
fs_1	set	2
	pea	#0
	clc
	tdc
	adc	#<L814+fs_1
	pha
	pei	<L813+dp_0+2
	pei	<L813+dp_0
	jsr	_~validate
	sta	<L814+res_1
;	if (res == FR_OK) {
	lda	<L814+res_1
	bne	L10475
;		if (!fno) {
	lda	<L813+fno_0
	ora	<L813+fno_0+2
	bne	L10476
;			res = dir_sdi(dp, 0);		/* Rewind the directory object */
	pea	#^$0
	pea	#<$0
	pei	<L813+dp_0+2
	pei	<L813+dp_0
	jsr	_~dir_sdi
	sta	<L814+res_1
;		} else {
	bra	L10475
L10476:
;			INIT_NAMEBUFF(fs);
;			fno->fname[0] = 0;				/* Clear file information */
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$9
	sta	[<L813+fno_0],Y
	rep	#$20
	longa	on
;			res = DIR_READ_FILE(dp);		/* Read an item */
	pea	#<$0
	pei	<L813+dp_0+2
	pei	<L813+dp_0
	jsr	_~dir_read
	sta	<L814+res_1
;			if (res == FR_NO_FILE) res = FR_OK;	/* Ignore end of directory */
	cmp	#<$4
	bne	L10478
	stz	<L814+res_1
;			if (res == FR_OK) {				/* A valid entry is found */
L10478:
	lda	<L814+res_1
	bne	L10475
;				get_fileinfo(dp, fno);		/* Get the object information */
	pei	<L813+fno_0+2
	pei	<L813+fno_0
	pei	<L813+dp_0+2
	pei	<L813+dp_0
	jsr	_~get_fileinfo
;				res = dir_next(dp, 0);		/* Increment index for next */
	pea	#<$0
	pei	<L813+dp_0+2
	pei	<L813+dp_0
	jsr	_~dir_next
	sta	<L814+res_1
;				if (res == FR_NO_FILE) res = FR_OK;	/* Ignore end of directory now */
	cmp	#<$4
	bne	L10475
	stz	<L814+res_1
;			}
;			FREE_NAMEBUFF();
;		}
;	}
;
;	if (fno && res != FR_OK) fno->fname[0] = 0;	/* Clear the file information if any error occured */
L10475:
	lda	<L813+fno_0
	ora	<L813+fno_0+2
	beq	L10481
	lda	<L814+res_1
	beq	L10481
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$9
	sta	[<L813+fno_0],Y
	rep	#$20
	longa	on
;	LEAVE_FF(fs, res);
L10481:
	pei	<L814+res_1
	pei	<L814+fs_1+2
	pei	<L814+fs_1
	jsr	_~unlock_volume
	lda	<L814+res_1
	tay
	lda	<L813+1
	sta	<L813+1+8
	pld
	tsc
	clc
	adc	#L813+8
	tcs
	tya
	rts
;}
L813	equ	6
L814	equ	1
	ends
	efunc
;
;
;
;#if FF_USE_FIND
;/*-----------------------------------------------------------------------*/
;/* API: Find Next File                                                   */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_findnext (
;	DIR* dp,		/* Pointer to the open directory object */
;	FILINFO* fno	/* Pointer to the file information structure */
;)
;{
	code
	xdef	_~f_findnext
	func
_~f_findnext:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L823
	tcs
	phd
	tcd
dp_0	set	3
fno_0	set	7
;	FRESULT res;
;
;
;	for (;;) {
res_1	set	0
L10484:
;		res = f_readdir(dp, fno);		/* Get a directory item */
	pei	<L823+fno_0+2
	pei	<L823+fno_0
	pei	<L823+dp_0+2
	pei	<L823+dp_0
	jsr	_~f_readdir
	sta	<L824+res_1
;		if (res != FR_OK || !fno || !fno->fname[0]) break;	/* Terminate if any error or end of directory */
	lda	<L824+res_1
	bne	L10483
	lda	<L823+fno_0
	ora	<L823+fno_0+2
	beq	L10483
	ldy	#$9
	lda	[<L823+fno_0],Y
	and	#$ff
	beq	L10483
;		if (pattern_match(dp->pat, fno->fname, 0, FIND_RECURS)) break;		/* Test for the file name */
	pea	#<$4
	pea	#<$0
	tya
	clc
	adc	<L823+fno_0
	sta	<R0
	lda	#$0
	adc	<L823+fno_0+2
	pha
	pei	<R0
	ldy	#$30
	lda	[<L823+dp_0],Y
	pha
	dey
	dey
	lda	[<L823+dp_0],Y
	pha
	jsr	_~pattern_match
	tax
	beq	L10484
;#if FF_USE_LFN && FF_USE_FIND == 2
;		if (pattern_match(dp->pat, fno->altname, 0, FIND_RECURS)) break;	/* Test for alternative name if exist */
;#endif
;	}
L10483:
;	return res;
	lda	<L824+res_1
	tay
	lda	<L823+1
	sta	<L823+1+8
	pld
	tsc
	clc
	adc	#L823+8
	tcs
	tya
	rts
;}
L823	equ	6
L824	equ	5
	ends
	efunc
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Find First File                                                  */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_findfirst (
;	DIR* dp,				/* Pointer to the blank directory object */
;	FILINFO* fno,			/* Pointer to the file information structure */
;	const TCHAR* path,		/* Pointer to the directory to open */
;	const TCHAR* pattern	/* Pointer to the matching pattern */
;)
;{
	code
	xdef	_~f_findfirst
	func
_~f_findfirst:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L830
	tcs
	phd
	tcd
dp_0	set	3
fno_0	set	7
path_0	set	11
pattern_0	set	15
;	FRESULT res;
;
;
;	dp->pat = pattern;		/* Save pointer to pattern string */
res_1	set	0
	lda	<L830+pattern_0
	ldy	#$2e
	sta	[<L830+dp_0],Y
	lda	<L830+pattern_0+2
	iny
	iny
	sta	[<L830+dp_0],Y
;	res = f_opendir(dp, path);		/* Open the target directory */
	pei	<L830+path_0+2
	pei	<L830+path_0
	pei	<L830+dp_0+2
	pei	<L830+dp_0
	jsr	_~f_opendir
	sta	<L831+res_1
;	if (res == FR_OK) {
	lda	<L831+res_1
	bne	L10485
;		res = f_findnext(dp, fno);	/* Find the first item */
	pei	<L830+fno_0+2
	pei	<L830+fno_0
	pei	<L830+dp_0+2
	pei	<L830+dp_0
	jsr	_~f_findnext
	sta	<L831+res_1
;	}
;	return res;
L10485:
	lda	<L831+res_1
	tay
	lda	<L830+1
	sta	<L830+1+16
	pld
	tsc
	clc
	adc	#L830+16
	tcs
	tya
	rts
;}
L830	equ	2
L831	equ	1
	ends
	efunc
;
;#endif	/* FF_USE_FIND */
;
;
;
;#if FF_FS_MINIMIZE == 0
;/*-----------------------------------------------------------------------*/
;/* API: Get File Status                                                  */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_stat (
;	const TCHAR* path,	/* Pointer to the file path */
;	FILINFO* fno		/* Pointer to file information to return */
;)
;{
	code
	xdef	_~f_stat
	func
_~f_stat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L834
	tcs
	phd
	tcd
path_0	set	3
fno_0	set	7
;	FRESULT res;
;	DIR dj;
;	DEF_NAMEBUFF
;
;
;	/* Get logical drive and mount the volume if needed */
;	res = mount_volume(&path, &dj.obj.fs, 0);
res_1	set	0
dj_1	set	2
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L835+dj_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L834+path_0
	pha
	jsr	_~mount_volume
	sta	<L835+res_1
;
;	if (res == FR_OK) {
	lda	<L835+res_1
	bne	L10486
;		INIT_NAMEBUFF(dj.obj.fs);
;		res = follow_path(&dj, path);	/* Follow the file path */
	pei	<L834+path_0+2
	pei	<L834+path_0
	pea	#0
	clc
	tdc
	adc	#<L835+dj_1
	pha
	jsr	_~follow_path
	sta	<L835+res_1
;		if (res == FR_OK) {				/* Follow completed */
	lda	<L835+res_1
	bne	L10486
;			if (dj.fn[NSFLAG] & NS_NONAME) {	/* It is origin directory */
	sep	#$20
	longa	off
	lda	<L835+dj_1+45
	and	#<$80
	rep	#$20
	longa	on
	beq	L10488
;				res = FR_INVALID_NAME;
	lda	#$6
	sta	<L835+res_1
;			} else {							/* Found an object */
	bra	L10486
L10488:
;				if (fno) get_fileinfo(&dj, fno);
	lda	<L834+fno_0
	ora	<L834+fno_0+2
	beq	L10486
	pei	<L834+fno_0+2
	pei	<L834+fno_0
	pea	#0
	clc
	tdc
	adc	#<L835+dj_1
	pha
	jsr	_~get_fileinfo
;			}
;		}
;		FREE_NAMEBUFF();
;	}
;
;	if (fno && res != FR_OK) fno->fname[0] = 0;	/* Invalidate the file information if an error occured */
L10486:
	lda	<L834+fno_0
	ora	<L834+fno_0+2
	beq	L10491
	lda	<L835+res_1
	beq	L10491
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$9
	sta	[<L834+fno_0],Y
	rep	#$20
	longa	on
;	LEAVE_FF(dj.obj.fs, res);
L10491:
	pei	<L835+res_1
	pei	<L835+dj_1+2
	pei	<L835+dj_1
	jsr	_~unlock_volume
	lda	<L835+res_1
	tay
	lda	<L834+1
	sta	<L834+1+8
	pld
	tsc
	clc
	adc	#L834+8
	tcs
	tya
	rts
;}
L834	equ	52
L835	equ	1
	ends
	efunc
;
;
;
;#if !FF_FS_READONLY
;/*-----------------------------------------------------------------------*/
;/* API: Get Number of Free Clusters                                      */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_getfree (
;	const TCHAR* path,	/* Logical drive number */
;	DWORD* nclst,		/* Pointer to a variable to return number of free clusters */
;	FATFS** fatfs		/* Pointer to a pointer to return corresponding filesystem object */
;)
;{
	code
	xdef	_~f_getfree
	func
_~f_getfree:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L843
	tcs
	phd
	tcd
path_0	set	3
nclst_0	set	7
fatfs_0	set	11
;	FRESULT res;
;	FATFS *fs;
;	DWORD nfree, clst, stat;
;	LBA_t sect;
;	UINT i;
;	FFOBJID obj;
;
;
;	/* Get logical drive and mount the volume if needed */
;	res = mount_volume(&path, &fs, 0);
res_1	set	0
fs_1	set	2
nfree_1	set	6
clst_1	set	10
stat_1	set	14
sect_1	set	18
i_1	set	22
obj_1	set	24
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L844+fs_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L843+path_0
	pha
	jsr	_~mount_volume
	sta	<L844+res_1
;
;	if (res == FR_OK) {
	lda	<L844+res_1
	beq	*+5
	brl	L10492
;		*fatfs = fs;				/* Return ptr to the fs object */
	lda	<L844+fs_1
	sta	[<L843+fatfs_0]
	lda	<L844+fs_1+2
	ldy	#$2
	sta	[<L843+fatfs_0],Y
;		/* If free_clst is valid, return it without full FAT scan */
;		if (fs->free_clst <= fs->n_fatent - 2) {
	clc
	lda	#$fffe
	ldy	#$18
	adc	[<L844+fs_1],Y
	sta	<R0
	lda	#$ffff
	iny
	iny
	adc	[<L844+fs_1],Y
	sta	<R0+2
	lda	<R0
	ldy	#$10
	cmp	[<L844+fs_1],Y
	lda	<R0+2
	iny
	iny
	sbc	[<L844+fs_1],Y
	bcc	L10493
;			*nclst = fs->free_clst;
	dey
	dey
	lda	[<L844+fs_1],Y
	sta	[<L843+nclst_0]
	iny
	iny
	lda	[<L844+fs_1],Y
	ldy	#$2
	sta	[<L843+nclst_0],Y
;		} else {
	brl	L10492
L10493:
;			/* Scan FAT to obtain the correct free cluster count */
;			nfree = 0;
	stz	<L844+nfree_1
	stz	<L844+nfree_1+2
;			if (fs->fs_type == FS_FAT12) {	/* FAT12: Scan bit field FAT entries */
	sep	#$20
	longa	off
	lda	[<L844+fs_1]
	cmp	#<$1
	rep	#$20
	longa	on
	bne	L10495
;				clst = 2; obj.fs = fs;
	lda	#$2
	sta	<L844+clst_1
	dea
	dea
	sta	<L844+clst_1+2
	lda	<L844+fs_1
	sta	<L844+obj_1
	lda	<L844+fs_1+2
	sta	<L844+obj_1+2
;				do {
L10498:
;					stat = get_fat(&obj, clst);
	pei	<L844+clst_1+2
	pei	<L844+clst_1
	pea	#0
	clc
	tdc
	adc	#<L844+obj_1
	pha
	jsr	_~get_fat
	sta	<L844+stat_1
	stx	<L844+stat_1+2
;					if (stat == 0xFFFFFFFF) {
	cmp	#<$ffffffff
	bne	L848
	lda	<L844+stat_1+2
	cmp	#^$ffffffff
L848:
	bne	L10499
;						res = FR_DISK_ERR; break;
	lda	#$1
L20170:
	sta	<L844+res_1
	brl	L10502
L20172:
;						res = FR_INT_ERR; break;
	lda	#$2
	bra	L20170
;					}
;					if (stat == 1) {
L10499:
	lda	<L844+stat_1
	cmp	#<$1
	bne	L850
	lda	<L844+stat_1+2
	cmp	#^$1
L850:
	beq	L20172
;					}
;					if (stat == 0) nfree++;
	lda	<L844+stat_1
	ora	<L844+stat_1+2
	bne	L10496
	inc	<L844+nfree_1
	bne	L10496
	inc	<L844+nfree_1+2
;				} while (++clst < fs->n_fatent);
L10496:
	inc	<L844+clst_1
	bne	L854
	inc	<L844+clst_1+2
L854:
	lda	<L844+clst_1
	ldy	#$18
	cmp	[<L844+fs_1],Y
	lda	<L844+clst_1+2
	iny
	iny
	sbc	[<L844+fs_1],Y
	bcc	L10498
	brl	L10502
;			} else {
L10495:
;#if FF_FS_EXFAT
;				if (fs->fs_type == FS_EXFAT) {	/* exFAT: Scan allocation bitmap */
;					BYTE bm;
;					UINT b;
;
;					clst = fs->n_fatent - 2;	/* Number of clusters */
;					sect = fs->bitbase;			/* Bitmap sector */
;					i = 0;						/* Offset in the sector */
;					do {	/* Counts numbuer of clear bits (free clusters) in the bitmap */
;						if (i == 0) {	/* New sector? */
;							res = move_window(fs, sect++);
;							if (res != FR_OK) break;
;						}
;						for (b = 8, bm = ~fs->win[i]; b && clst; b--, clst--) {	/* Count clear bits in a byte */
;							nfree += bm & 1;
;							bm >>= 1;
;						}
;						i = (i + 1) % SS(fs);	/* Next byte */
;					} while (clst);
;				} else
;#endif
;				{	/* FAT16/32: Scan WORD/DWORD FAT entries */
;					clst = fs->n_fatent;	/* Number of entries */
	ldy	#$18
	lda	[<L844+fs_1],Y
	sta	<L844+clst_1
	iny
	iny
	lda	[<L844+fs_1],Y
	sta	<L844+clst_1+2
;					sect = fs->fatbase;		/* Top of the FAT */
	ldy	#$28
	lda	[<L844+fs_1],Y
	sta	<L844+sect_1
	iny
	iny
	lda	[<L844+fs_1],Y
	sta	<L844+sect_1+2
;					i = 0;					/* Offset in the sector */
	stz	<L844+i_1
;					do {	/* Counts numbuer of entries with zero in the FAT */
L10505:
;						if (i == 0) {	/* New sector? */
	lda	<L844+i_1
	bne	L10506
;							res = move_window(fs, sect++);
	lda	<L844+sect_1
	sta	<R0
	lda	<L844+sect_1+2
	sta	<R0+2
	inc	<L844+sect_1
	bne	L857
	inc	<L844+sect_1+2
L857:
	pei	<R0+2
	pei	<R0
	pei	<L844+fs_1+2
	pei	<L844+fs_1
	jsr	_~move_window
	sta	<L844+res_1
;							if (res != FR_OK) break;
	lda	<L844+res_1
	beq	*+5
	brl	L10502
;						}
;						if (fs->fs_type == FS_FAT16) {
L10506:
	sep	#$20
	longa	off
	lda	[<L844+fs_1]
	cmp	#<$2
	rep	#$20
	longa	on
	bne	L10507
;							if (ld_16(fs->win + i) == 0) nfree++;	/* FAT16: Is this cluster free? */
	lda	<L844+i_1
	sta	<R0
	stz	<R0+2
	lda	#$34
	clc
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	<L844+fs_1
	clc
	adc	<R1
	sta	<R0
	lda	<L844+fs_1+2
	adc	<R1+2
	pha
	pei	<R0
	jsr	_~ld_16
	tax
	bne	L10508
	inc	<L844+nfree_1
	bne	L10508
	inc	<L844+nfree_1+2
;							i += 2;	/* Next entry */
L10508:
	inc	<L844+i_1
	inc	<L844+i_1
;						} else {
	bra	L10509
L10507:
;							if ((ld_32(fs->win + i) & 0x0FFFFFFF) == 0) nfree++;	/* FAT32: Is this cluster free? */
	lda	<L844+i_1
	sta	<R0
	stz	<R0+2
	lda	#$34
	clc
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	<L844+fs_1
	clc
	adc	<R1
	sta	<R0
	lda	<L844+fs_1+2
	adc	<R1+2
	pha
	pei	<R0
	jsr	_~ld_32
	stx	<R2+2
	sta	<R3
	lda	<R2+2
	and	#^$fffffff
	sta	<R3+2
	lda	<R3
	ora	<R3+2
	bne	L10510
	inc	<L844+nfree_1
	bne	L10510
	inc	<L844+nfree_1+2
;							i += 4;	/* Next entry */
L10510:
	lda	#$4
	clc
	adc	<L844+i_1
	sta	<L844+i_1
;						}
L10509:
;						i %= SS(fs);
	lda	#$fe00
	trb	<L844+i_1
;					} while (--clst);
	lda	<L844+clst_1
	bne	L864
	dec	<L844+clst_1+2
L864:
	dec	<L844+clst_1
	lda	<L844+clst_1
	ora	<L844+clst_1+2
	beq	*+5
	brl	L10505
L10502:
;			if (res == FR_OK) {		/* Update parameters if succeeded */
	lda	<L844+res_1
	bne	L10492
;				}
;			}
;				*nclst = nfree;			/* Return the free clusters */
	lda	<L844+nfree_1
	sta	[<L843+nclst_0]
	lda	<L844+nfree_1+2
	ldy	#$2
	sta	[<L843+nclst_0],Y
;				fs->free_clst = nfree;	/* Now free cluster count is valid */
	lda	<L844+nfree_1
	ldy	#$10
	sta	[<L844+fs_1],Y
	lda	<L844+nfree_1+2
	iny
	iny
	sta	[<L844+fs_1],Y
;				fs->fsi_flag |= 1;		/* FAT32/exfAT : Allocation information is to be updated */
	lda	#$5
	clc
	adc	<L844+fs_1
	sta	<R0
	lda	#$0
	adc	<L844+fs_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$1
	sta	[<R0]
	rep	#$20
	longa	on
;			}
;		}
;	}
;
;	LEAVE_FF(fs, res);
L10492:
	pei	<L844+res_1
	pei	<L844+fs_1+2
	pei	<L844+fs_1
	jsr	_~unlock_volume
	lda	<L844+res_1
	tay
	lda	<L843+1
	sta	<L843+1+12
	pld
	tsc
	clc
	adc	#L843+12
	tcs
	tya
	rts
;}
L843	equ	58
L844	equ	17
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Truncate File                                                    */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_truncate (
;	FIL* fp		/* Pointer to the file object */
;)
;{
	code
	xdef	_~f_truncate
	func
_~f_truncate:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L868
	tcs
	phd
	tcd
fp_0	set	3
;	FRESULT res;
;	FATFS *fs;
;	DWORD ncl;
;
;
;	/* Check validity of the file object */
;	res = validate(&fp->obj, &fs);
res_1	set	0
fs_1	set	2
ncl_1	set	6
	pea	#0
	clc
	tdc
	adc	#<L869+fs_1
	pha
	pei	<L868+fp_0+2
	pei	<L868+fp_0
	jsr	_~validate
	sta	<L869+res_1
;	if (res != FR_OK || (res = (FRESULT)fp->err) != FR_OK) LEAVE_FF(fs, res);
	lda	<L869+res_1
	bne	L870
	ldy	#$13
	lda	[<L868+fp_0],Y
	and	#$ff
	sta	<L869+res_1
	lda	<L869+res_1
	beq	L10512
L870:
	pei	<L869+res_1
	pei	<L869+fs_1+2
	pei	<L869+fs_1
	jsr	_~unlock_volume
	lda	<L869+res_1
L873:
	tay
	lda	<L868+1
	sta	<L868+1+4
	pld
	tsc
	clc
	adc	#L868+4
	tcs
	tya
	rts
L10512:
;	if (!(fp->flag & FA_WRITE)) LEAVE_FF(fs, FR_DENIED);	/* Check access mode */
	sep	#$20
	longa	off
	ldy	#$12
	lda	[<L868+fp_0],Y
	and	#<$2
	rep	#$20
	longa	on
	bne	L10513
	pea	#<$7
	pei	<L869+fs_1+2
	pei	<L869+fs_1
	jsr	_~unlock_volume
	lda	#$7
	bra	L873
L10513:
;
;	if (fp->fptr < fp->obj.objsize) {	/* Process when fptr is not on the eof */
	ldy	#$14
	lda	[<L868+fp_0],Y
	ldy	#$c
	cmp	[<L868+fp_0],Y
	ldy	#$16
	lda	[<L868+fp_0],Y
	ldy	#$e
	sbc	[<L868+fp_0],Y
	bcs	L870
;		if (fp->fptr == 0) {	/* When set file size to zero, remove entire cluster chain */
	ldy	#$14
	lda	[<L868+fp_0],Y
	iny
	iny
	ora	[<L868+fp_0],Y
	bne	L10515
;			res = remove_chain(&fp->obj, fp->obj.sclust, 0);
	pea	#^$0
	pea	#<$0
	ldy	#$a
	lda	[<L868+fp_0],Y
	pha
	dey
	dey
	lda	[<L868+fp_0],Y
	pha
	pei	<L868+fp_0+2
	pei	<L868+fp_0
	jsr	_~remove_chain
	sta	<L869+res_1
;			fp->obj.sclust = 0;
	lda	#$0
	ldy	#$8
	sta	[<L868+fp_0],Y
	iny
	iny
	sta	[<L868+fp_0],Y
;		} else {				/* When truncate a part of the file, remove remaining clusters */
	bra	L10516
L10515:
;			ncl = get_fat(&fp->obj, fp->clust);
	ldy	#$1a
	lda	[<L868+fp_0],Y
	pha
	dey
	dey
	lda	[<L868+fp_0],Y
	pha
	pei	<L868+fp_0+2
	pei	<L868+fp_0
	jsr	_~get_fat
	sta	<L869+ncl_1
	stx	<L869+ncl_1+2
;			res = FR_OK;
	stz	<L869+res_1
;			if (ncl == 0xFFFFFFFF) res = FR_DISK_ERR;
	lda	<L869+ncl_1
	cmp	#<$ffffffff
	bne	L877
	lda	<L869+ncl_1+2
	cmp	#^$ffffffff
L877:
	bne	L10517
	lda	#$1
	sta	<L869+res_1
;			if (ncl == 1) res = FR_INT_ERR;
L10517:
	lda	<L869+ncl_1
	cmp	#<$1
	bne	L879
	lda	<L869+ncl_1+2
	cmp	#^$1
L879:
	bne	L10518
	lda	#$2
	sta	<L869+res_1
;			if (res == FR_OK && ncl < fs->n_fatent) {
L10518:
	lda	<L869+res_1
	bne	L10516
	lda	<L869+ncl_1
	ldy	#$18
	cmp	[<L869+fs_1],Y
	lda	<L869+ncl_1+2
	iny
	iny
	sbc	[<L869+fs_1],Y
	bcs	L10516
;				res = remove_chain(&fp->obj, ncl, fp->clust);
	lda	[<L868+fp_0],Y
	pha
	dey
	dey
	lda	[<L868+fp_0],Y
	pha
	pei	<L869+ncl_1+2
	pei	<L869+ncl_1
	pei	<L868+fp_0+2
	pei	<L868+fp_0
	jsr	_~remove_chain
	sta	<L869+res_1
;			}
;		}
L10516:
;		fp->obj.objsize = fp->fptr;	/* Set file size to current read/write point */
	ldy	#$14
	lda	[<L868+fp_0],Y
	ldy	#$c
	sta	[<L868+fp_0],Y
	ldy	#$16
	lda	[<L868+fp_0],Y
	ldy	#$e
	sta	[<L868+fp_0],Y
;		fp->flag |= FA_MODIFIED;
	lda	#$12
	clc
	adc	<L868+fp_0
	sta	<R0
	lda	#$0
	adc	<L868+fp_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$40
	sta	[<R0]
	rep	#$20
	longa	on
;#if !FF_FS_TINY
;		if (res == FR_OK && (fp->flag & FA_DIRTY)) {
	lda	<L869+res_1
	bne	L10520
	sep	#$20
	longa	off
	ldy	#$12
	lda	[<L868+fp_0],Y
	and	#<$80
	rep	#$20
	longa	on
	beq	L10520
;			if (disk_write(fs->pdrv, fp->buf, fp->sect, 1) != RES_OK) {
	pea	#<$1
	ldy	#$1e
	lda	[<L868+fp_0],Y
	pha
	dey
	dey
	lda	[<L868+fp_0],Y
	pha
	lda	#$2c
	clc
	adc	<L868+fp_0
	sta	<R0
	lda	#$0
	adc	<L868+fp_0+2
	pha
	pei	<R0
	ldy	#$1
	lda	[<L869+fs_1],Y
	pha
	jsr	_~disk_write
	tax
	beq	L10521
;				res = FR_DISK_ERR;
	lda	#$1
	sta	<L869+res_1
;			} else {
	bra	L10520
L10521:
;				fp->flag &= (BYTE)~FA_DIRTY;
	lda	#$12
	clc
	adc	<L868+fp_0
	sta	<R0
	lda	#$0
	adc	<L868+fp_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	and	#<$7f
	sta	[<R0]
	rep	#$20
	longa	on
;			}
;		}
;#endif
;		if (res != FR_OK) ABORT(fs, res);
L10520:
	lda	<L869+res_1
	bne	*+5
	brl	L870
	sep	#$20
	longa	off
	lda	<L869+res_1
	ldy	#$13
	sta	[<L868+fp_0],Y
	rep	#$20
	longa	on
	brl	L870
;	}
;
;	LEAVE_FF(fs, res);
;}
L868	equ	14
L869	equ	5
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Delete a File/Directory                                          */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_unlink (
;	const TCHAR* path		/* Pointer to the file or directory path */
;)
;{
	code
	xdef	_~f_unlink
	func
_~f_unlink:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L887
	tcs
	phd
	tcd
path_0	set	3
;	FRESULT res;
;	FATFS *fs;
;	DIR dj, sdj;
;	DWORD dclst = 0;
;#if FF_FS_EXFAT
;	FFOBJID obj;
;#endif
;	DEF_NAMEBUFF
;
;	/* Get logical drive and mount the volume if needed */
;	res = mount_volume(&path, &fs, FA_WRITE);
res_1	set	0
fs_1	set	2
dj_1	set	6
sdj_1	set	56
dclst_1	set	106
	stz	<L888+dclst_1
	stz	<L888+dclst_1+2
	pea	#<$2
	pea	#0
	clc
	tdc
	adc	#<L888+fs_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L887+path_0
	pha
	jsr	_~mount_volume
	sta	<L888+res_1
;	if (res == FR_OK) {
	lda	<L888+res_1
	beq	*+5
	brl	L10524
;		dj.obj.fs = fs;
	lda	<L888+fs_1
	sta	<L888+dj_1
	lda	<L888+fs_1+2
	sta	<L888+dj_1+2
;		INIT_NAMEBUFF(fs);
;		res = follow_path(&dj, path);	/* Follow the path to the object */
	pei	<L887+path_0+2
	pei	<L887+path_0
	pea	#0
	clc
	tdc
	adc	#<L888+dj_1
	pha
	jsr	_~follow_path
	sta	<L888+res_1
;		if (res == FR_OK) {
	lda	<L888+res_1
	bne	L10525
;			if (dj.fn[NSFLAG] & (NS_DOT | NS_NONAME)) {
	sep	#$20
	longa	off
	lda	<L888+dj_1+45
	and	#<$a0
	rep	#$20
	longa	on
	beq	L10526
;				res = FR_INVALID_NAME;	/* It must be a real object */
	lda	#$6
	bra	L20179
;			} else if (dj.obj.attr & AM_RDO) {
L10526:
	sep	#$20
	longa	off
	lda	<L888+dj_1+6
	and	#<$1
	rep	#$20
	longa	on
	beq	L10528
;				res = FR_DENIED;		/* The object must not be read-only */
	lda	#$7
	bra	L20179
;#if FF_FS_LOCK
;			} else {
L10528:
;				res = chk_share(&dj, 2);	/* Check if the object is in use */
	pea	#<$2
	pea	#0
	clc
	tdc
	adc	#<L888+dj_1
	pha
	jsr	_~chk_share
L20179:
	sta	<L888+res_1
;#endif
;			}
;		}
;		if (res == FR_OK) {		/* The object is accessible */
L10525:
	lda	<L888+res_1
	bne	L10530
;#if FF_FS_EXFAT
;			obj.fs = fs;
;			if (fs->fs_type == FS_EXFAT) {
;				init_alloc_info(&obj, 0);
;				dclst = obj.sclust;
;			} else
;#endif
;			{
;				dclst = ld_clust(fs, dj.dir);
	pei	<L888+dj_1+32
	pei	<L888+dj_1+30
	pei	<L888+fs_1+2
	pei	<L888+fs_1
	jsr	_~ld_clust
	sta	<L888+dclst_1
	stx	<L888+dclst_1+2
;			}
;			if (dj.obj.attr & AM_DIR) {		/* Is the object a sub-directory? */
	sep	#$20
	longa	off
	lda	<L888+dj_1+6
	and	#<$10
	rep	#$20
	longa	on
	beq	L10530
;#if FF_FS_RPATH
;				if (dclst == fs->cdir) {
	lda	<L888+dclst_1
	ldy	#$14
	cmp	[<L888+fs_1],Y
	bne	L895
	lda	<L888+dclst_1+2
	iny
	iny
	cmp	[<L888+fs_1],Y
L895:
	bne	L10532
;					res = FR_DENIED;		/* Current directory cannot be removed */
	lda	#$7
	sta	<L888+res_1
;				} else
	bra	L10530
L10532:
;#endif
;				{
;					sdj.obj.fs = fs;		/* Open the sub-directory */
	lda	<L888+fs_1
	sta	<L888+sdj_1
	lda	<L888+fs_1+2
	sta	<L888+sdj_1+2
;					sdj.obj.sclust = dclst;
	lda	<L888+dclst_1
	sta	<L888+sdj_1+8
	lda	<L888+dclst_1+2
	sta	<L888+sdj_1+10
;#if FF_FS_EXFAT
;					if (fs->fs_type == FS_EXFAT) {
;						sdj.obj.objsize = obj.objsize;
;						sdj.obj.stat = obj.stat;
;					}
;#endif
;					res = dir_sdi(&sdj, 0);
	pea	#^$0
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L888+sdj_1
	pha
	jsr	_~dir_sdi
	sta	<L888+res_1
;					if (res == FR_OK) {
	lda	<L888+res_1
	bne	L10530
;						res = DIR_READ_FILE(&sdj);			/* Check if the sub-directory is empty */
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L888+sdj_1
	pha
	jsr	_~dir_read
	sta	<L888+res_1
;						if (res == FR_OK) res = FR_DENIED;	/* Not empty? */
	lda	<L888+res_1
	bne	L10535
	lda	#$7
	sta	<L888+res_1
;						if (res == FR_NO_FILE) res = FR_OK;	/* Empty? */
L10535:
	lda	<L888+res_1
	cmp	#<$4
	bne	L10530
	stz	<L888+res_1
;					}
;				}
;			}
;		}
;		if (res == FR_OK) {		/* It is ready to remove the object */
L10530:
	lda	<L888+res_1
	bne	L10524
;			res = dir_remove(&dj);				/* Remove the directory entry */
	pea	#0
	clc
	tdc
	adc	#<L888+dj_1
	pha
	jsr	_~dir_remove
	sta	<L888+res_1
;			if (res == FR_OK && dclst != 0) {	/* Remove the cluster chain if exist */
	lda	<L888+res_1
	bne	L10538
	lda	<L888+dclst_1
	ora	<L888+dclst_1+2
	beq	L10538
;#if FF_FS_EXFAT
;				res = remove_chain(&obj, dclst, 0);
;#else
;				res = remove_chain(&dj.obj, dclst, 0);
	pea	#^$0
	pea	#<$0
	pei	<L888+dclst_1+2
	pei	<L888+dclst_1
	pea	#0
	clc
	tdc
	adc	#<L888+dj_1
	pha
	jsr	_~remove_chain
	sta	<L888+res_1
;#endif
;			}
;			if (res == FR_OK) res = sync_fs(fs);
L10538:
	lda	<L888+res_1
	bne	L10524
	pei	<L888+fs_1+2
	pei	<L888+fs_1
	jsr	_~sync_fs
	sta	<L888+res_1
;		}
;		FREE_NAMEBUFF();
;	}
;
;	LEAVE_FF(fs, res);
L10524:
	pei	<L888+res_1
	pei	<L888+fs_1+2
	pei	<L888+fs_1
	jsr	_~unlock_volume
	lda	<L888+res_1
	tay
	lda	<L887+1
	sta	<L887+1+4
	pld
	tsc
	clc
	adc	#L887+4
	tcs
	tya
	rts
;}
L887	equ	110
L888	equ	1
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Create a Directory                                               */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_mkdir (
;	const TCHAR* path		/* Pointer to the directory path */
;)
;{
	code
	xdef	_~f_mkdir
	func
_~f_mkdir:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L905
	tcs
	phd
	tcd
path_0	set	3
;	FRESULT res;
;	FATFS *fs;
;	DIR dj;
;	FFOBJID sobj;
;	DWORD dcl, pcl, tm;
;	DEF_NAMEBUFF
;
;
;	res = mount_volume(&path, &fs, FA_WRITE);	/* Get logical drive and mount the volume if needed */
res_1	set	0
fs_1	set	2
dj_1	set	6
sobj_1	set	56
dcl_1	set	74
pcl_1	set	78
tm_1	set	82
	pea	#<$2
	pea	#0
	clc
	tdc
	adc	#<L906+fs_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L905+path_0
	pha
	jsr	_~mount_volume
	sta	<L906+res_1
;	if (res == FR_OK) {
	lda	<L906+res_1
	beq	*+5
	brl	L10540
;		dj.obj.fs = fs;
	lda	<L906+fs_1
	sta	<L906+dj_1
	lda	<L906+fs_1+2
	sta	<L906+dj_1+2
;		INIT_NAMEBUFF(fs);
;		res = follow_path(&dj, path);			/* Follow the file path */
	pei	<L905+path_0+2
	pei	<L905+path_0
	pea	#0
	clc
	tdc
	adc	#<L906+dj_1
	pha
	jsr	_~follow_path
	sta	<L906+res_1
;		if (res == FR_OK) {						/* Invalid name or name collision */
	lda	<L906+res_1
	bne	L10541
;			res = (dj.fn[NSFLAG] & (NS_DOT | NS_NONAME)) ? FR_INVALID_NAME : FR_EXIST;
	sep	#$20
	longa	off
	lda	<L906+dj_1+45
	and	#<$a0
	rep	#$20
	longa	on
	beq	L909
	lda	#$6
	bra	L911
L909:
	lda	#$8
L911:
	sta	<L906+res_1
;		}
;		if (res == FR_NO_FILE) {				/* It is clear to create a new directory */
L10541:
	lda	<L906+res_1
	cmp	#<$4
	beq	*+5
	brl	L10540
;			sobj.fs = fs;						/* New object ID to create a new chain */
	lda	<L906+fs_1
	sta	<L906+sobj_1
	lda	<L906+fs_1+2
	sta	<L906+sobj_1+2
;			dcl = create_chain(&sobj, 0);		/* Allocate a cluster for the new directory */
	pea	#^$0
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L906+sobj_1
	pha
	jsr	_~create_chain
	sta	<L906+dcl_1
	stx	<L906+dcl_1+2
;			res = FR_OK;
	stz	<L906+res_1
;			if (dcl == 0) res = FR_DENIED;		/* No space to allocate a new cluster? */
	lda	<L906+dcl_1
	ora	<L906+dcl_1+2
	bne	L10543
	lda	#$7
	sta	<L906+res_1
;			if (dcl == 1) res = FR_INT_ERR;		/* Any insanity? */
L10543:
	lda	<L906+dcl_1
	cmp	#<$1
	bne	L914
	lda	<L906+dcl_1+2
	cmp	#^$1
L914:
	bne	L10544
	lda	#$2
	sta	<L906+res_1
;			if (dcl == 0xFFFFFFFF) res = FR_DISK_ERR;	/* Disk error? */
L10544:
	lda	<L906+dcl_1
	cmp	#<$ffffffff
	bne	L916
	lda	<L906+dcl_1+2
	cmp	#^$ffffffff
L916:
	bne	L10545
	lda	#$1
	sta	<L906+res_1
;			tm = GET_FATTIME();
L10545:
	lda	#$0
	sta	<L906+tm_1
	lda	#$5a21
	sta	<L906+tm_1+2
;			if (res == FR_OK) {
	lda	<L906+res_1
	beq	*+5
	brl	L10546
;				res = dir_clear(fs, dcl);		/* Clear the allocated cluster as new direcotry table */
	pei	<L906+dcl_1+2
	pei	<L906+dcl_1
	pei	<L906+fs_1+2
	pei	<L906+fs_1
	jsr	_~dir_clear
	sta	<L906+res_1
;				if (res == FR_OK) {
	lda	<L906+res_1
	beq	*+5
	brl	L10546
;					if (!FF_FS_EXFAT || fs->fs_type != FS_EXFAT) {	/* Create dot entries (FAT only) */
;						memset(fs->win + DIR_Name, ' ', 11);	/* Create "." entry */
	pea	#<$b
	pea	#<$20
	lda	#$34
	clc
	adc	<L906+fs_1
	sta	<R0
	lda	#$0
	adc	<L906+fs_1+2
	pha
	pei	<R0
	jsr	_~memset
;						fs->win[DIR_Name] = '.';
	sep	#$20
	longa	off
	lda	#$2e
	ldy	#$34
	sta	[<L906+fs_1],Y
;						fs->win[DIR_Attr] = AM_DIR;
	lda	#$10
	ldy	#$3f
	sta	[<L906+fs_1],Y
	rep	#$20
	longa	on
;						st_32(fs->win + DIR_ModTime, tm);
	pei	<L906+tm_1+2
	pei	<L906+tm_1
	lda	#$4a
	clc
	adc	<L906+fs_1
	sta	<R0
	lda	#$0
	adc	<L906+fs_1+2
	pha
	pei	<R0
	jsr	_~st_32
;						st_clust(fs, fs->win, dcl);
	pei	<L906+dcl_1+2
	pei	<L906+dcl_1
	lda	#$34
	clc
	adc	<L906+fs_1
	sta	<R0
	lda	#$0
	adc	<L906+fs_1+2
	pha
	pei	<R0
	pei	<L906+fs_1+2
	pei	<L906+fs_1
	jsr	_~st_clust
;						memcpy(fs->win + SZDIRE, fs->win, SZDIRE);	/* Create ".." entry */
	pea	#<$20
	lda	#$34
	clc
	adc	<L906+fs_1
	sta	<R0
	lda	#$0
	adc	<L906+fs_1+2
	pha
	pei	<R0
	lda	#$54
	clc
	adc	<L906+fs_1
	sta	<R1
	lda	#$0
	adc	<L906+fs_1+2
	pha
	pei	<R1
	jsr	_~memcpy
;						fs->win[SZDIRE + 1] = '.'; pcl = dj.obj.sclust;
	sep	#$20
	longa	off
	lda	#$2e
	ldy	#$55
	sta	[<L906+fs_1],Y
	rep	#$20
	longa	on
	lda	<L906+dj_1+8
	sta	<L906+pcl_1
	lda	<L906+dj_1+10
	sta	<L906+pcl_1+2
;						st_clust(fs, fs->win + SZDIRE, pcl);
	pha
	pei	<L906+pcl_1
	lda	#$54
	clc
	adc	<L906+fs_1
	sta	<R0
	lda	#$0
	adc	<L906+fs_1+2
	pha
	pei	<R0
	pei	<L906+fs_1+2
	pei	<L906+fs_1
	jsr	_~st_clust
;						fs->wflag = 1;
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$4
	sta	[<L906+fs_1],Y
	rep	#$20
	longa	on
;					}
;					res = dir_register(&dj);	/* Register the object to the parent directory */
	pea	#0
	clc
	tdc
	adc	#<L906+dj_1
	pha
	jsr	_~dir_register
	sta	<L906+res_1
;				}
;			}
;			if (res == FR_OK) {
L10546:
	lda	<L906+res_1
	bne	L10549
;#if FF_FS_EXFAT
;				if (fs->fs_type == FS_EXFAT) {	/* Initialize directory entry block */
;					st_32(fs->dirbuf + XDIR_CrtTime, tm);	/* Created time */
;					st_32(fs->dirbuf + XDIR_ModTime, tm);
;					st_32(fs->dirbuf + XDIR_FstClus, dcl);	/* Table start cluster */
;					st_32(fs->dirbuf + XDIR_FileSize, (DWORD)fs->csize * SS(fs));	/* Directory size needs to be valid */
;					st_32(fs->dirbuf + XDIR_ValidFileSize, (DWORD)fs->csize * SS(fs));
;					fs->dirbuf[XDIR_GenFlags] = 3;			/* Initialize the object flag */
;					fs->dirbuf[XDIR_Attr] = AM_DIR;			/* Attribute */
;					res = store_xdir(&dj);
;				} else
;#endif
;				{
;					st_32(dj.dir + DIR_CrtTime, tm);	/* Created time */
	pei	<L906+tm_1+2
	pei	<L906+tm_1
	lda	#$e
	clc
	adc	<L906+dj_1+30
	sta	<R0
	lda	#$0
	adc	<L906+dj_1+32
	pha
	pei	<R0
	jsr	_~st_32
;					st_32(dj.dir + DIR_ModTime, tm);
	pei	<L906+tm_1+2
	pei	<L906+tm_1
	lda	#$16
	clc
	adc	<L906+dj_1+30
	sta	<R0
	lda	#$0
	adc	<L906+dj_1+32
	pha
	pei	<R0
	jsr	_~st_32
;					st_clust(fs, dj.dir, dcl);			/* Table start cluster */
	pei	<L906+dcl_1+2
	pei	<L906+dcl_1
	pei	<L906+dj_1+32
	pei	<L906+dj_1+30
	pei	<L906+fs_1+2
	pei	<L906+fs_1
	jsr	_~st_clust
;					dj.dir[DIR_Attr] = AM_DIR;			/* Attribute */
	sep	#$20
	longa	off
	lda	#$10
	ldy	#$b
	sta	[<L906+dj_1+30],Y
;					fs->wflag = 1;
	lda	#$1
	ldy	#$4
	sta	[<L906+fs_1],Y
	rep	#$20
	longa	on
;				}
;				if (res == FR_OK) {
	lda	<L906+res_1
	bne	L10540
;					res = sync_fs(fs);
	pei	<L906+fs_1+2
	pei	<L906+fs_1
	jsr	_~sync_fs
	sta	<L906+res_1
;				}
;			} else {
	bra	L10540
L10549:
;				remove_chain(&sobj, dcl, 0);		/* Could not register, remove the allocated cluster */
	pea	#^$0
	pea	#<$0
	pei	<L906+dcl_1+2
	pei	<L906+dcl_1
	pea	#0
	clc
	tdc
	adc	#<L906+sobj_1
	pha
	jsr	_~remove_chain
;			}
;		}
;		FREE_NAMEBUFF();
;	}
;
;	LEAVE_FF(fs, res);
L10540:
	pei	<L906+res_1
	pei	<L906+fs_1+2
	pei	<L906+fs_1
	jsr	_~unlock_volume
	lda	<L906+res_1
	tay
	lda	<L905+1
	sta	<L905+1+4
	pld
	tsc
	clc
	adc	#L905+4
	tcs
	tya
	rts
;}
L905	equ	94
L906	equ	9
	ends
	efunc
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Rename a File/Directory                                          */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_rename (
;	const TCHAR* path_old,	/* Pointer to the object name to be renamed */
;	const TCHAR* path_new	/* Pointer to the new name */
;)
;{
	code
	xdef	_~f_rename
	func
_~f_rename:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L925
	tcs
	phd
	tcd
path_old_0	set	3
path_new_0	set	7
;	FRESULT res;
;	FATFS *fs;
;	DIR djo, djn;
;	BYTE buf[FF_FS_EXFAT ? SZDIRE * 2 : SZDIRE], *dir;
;	DEF_NAMEBUFF
;
;
;	get_ldnumber(&path_new);	/* Snip the drive number of new name off */
res_1	set	0
fs_1	set	2
djo_1	set	6
djn_1	set	56
buf_1	set	106
dir_1	set	138
	pea	#0
	clc
	tdc
	adc	#<L925+path_new_0
	pha
	jsr	_~get_ldnumber
;	res = mount_volume(&path_old, &fs, FA_WRITE);	/* Get logical drive of the old object */
	pea	#<$2
	pea	#0
	clc
	tdc
	adc	#<L926+fs_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L925+path_old_0
	pha
	jsr	_~mount_volume
	sta	<L926+res_1
;	if (res == FR_OK) {
	lda	<L926+res_1
	beq	*+5
	brl	L10552
;		djo.obj.fs = fs;
	lda	<L926+fs_1
	sta	<L926+djo_1
	lda	<L926+fs_1+2
	sta	<L926+djo_1+2
;		INIT_NAMEBUFF(fs);
;		res = follow_path(&djo, path_old);	/* Check old object */
	pei	<L925+path_old_0+2
	pei	<L925+path_old_0
	pea	#0
	clc
	tdc
	adc	#<L926+djo_1
	pha
	jsr	_~follow_path
	sta	<L926+res_1
;		if (res == FR_OK) {
	lda	<L926+res_1
	bne	L10553
;			if (djo.fn[NSFLAG] & (NS_DOT | NS_NONAME)) {
	sep	#$20
	longa	off
	lda	<L926+djo_1+45
	and	#<$a0
	rep	#$20
	longa	on
	beq	L10554
;				res = FR_INVALID_NAME;		/* Object must not be a dot name or blank name */
	lda	#$6
	bra	L20180
;#if FF_FS_LOCK
;			} else {
L10554:
;				res = chk_share(&djo, 2);	/* Check if the object is in use */
	pea	#<$2
	pea	#0
	clc
	tdc
	adc	#<L926+djo_1
	pha
	jsr	_~chk_share
L20180:
	sta	<L926+res_1
;#endif
;			}
;		}
;		if (res == FR_OK) {					/* It is ready to rename the object */
L10553:
	lda	<L926+res_1
	beq	*+5
	brl	L10552
;#if FF_FS_EXFAT
;			if (fs->fs_type == FS_EXFAT) {	/* At exFAT volume */
;#if FF_FS_RPATH
;				UINT i;
;				DWORD dscl = ld_32(fs->dirbuf + XDIR_FstClus);
;
;				for (i = 1; i <= fs->xcwds.depth && dscl != fs->xcwds.tbl[i].d_scl; i++) ;	/* Check if the object is a sub-dir in the current dir path */
;				if (i <= fs->xcwds.depth) {
;					res = FR_DENIED;	/* Reject to rename a sub-dir in the current dir path */
;				} else
;#endif
;				{
;					memcpy(buf, fs->dirbuf, SZDIRE * 2);	/* Save 85+C0 entry of old object */
;					memcpy(&djn, &djo, sizeof djn);
;					res = follow_path(&djn, path_new);		/* Check if new object name collides with an existing one */
;				}
;				if (res == FR_OK) {					/* Is new name already in use by another object? */
;					res = (djn.obj.sclust == djo.obj.sclust && djn.dptr == djo.dptr) ? FR_NO_FILE : FR_EXIST;
;				}
;				if (res == FR_NO_FILE) { 			/* It is a valid path and no name collision */
;					res = dir_register(&djn);		/* Register the new entry */
;					if (res == FR_OK) {
;						BYTE nf, nn;
;						WORD nh;
;
;						nf = fs->dirbuf[XDIR_NumSec]; nn = fs->dirbuf[XDIR_NumName];	/* Save name length and hash */
;						nh = ld_16(fs->dirbuf + XDIR_NameHash);
;						memcpy(fs->dirbuf, buf, SZDIRE * 2);	/* Restore 85+C0 entry */
;						fs->dirbuf[XDIR_NumSec] = nf; fs->dirbuf[XDIR_NumName] = nn;	/* Restore name length and hash */
;						st_16(fs->dirbuf + XDIR_NameHash, nh);
;						if (!(fs->dirbuf[XDIR_Attr] & AM_DIR)) fs->dirbuf[XDIR_Attr] |= AM_ARC;	/* Set archive attribute if it is a file */
;/* Start of critical section where an interruption can cause a cross-link */
;						res = store_xdir(&djn);
;					}
;				}
;			} else
;#endif
;			{	/* At FAT/FAT32 volume */
;				memcpy(buf, djo.dir, SZDIRE);			/* Save directory entry of the object */
	pea	#<$20
	pei	<L926+djo_1+32
	pei	<L926+djo_1+30
	pea	#0
	clc
	tdc
	adc	#<L926+buf_1
	pha
	jsr	_~memcpy
;				memcpy(&djn, &djo, sizeof djn);			/* Duplicate the directory object */
	pea	#<$32
	pea	#0
	clc
	tdc
	adc	#<L926+djo_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L926+djn_1
	pha
	jsr	_~memcpy
;				res = follow_path(&djn, path_new);		/* Make sure if new object name is not in use */
	pei	<L925+path_new_0+2
	pei	<L925+path_new_0
	pea	#0
	clc
	tdc
	adc	#<L926+djn_1
	pha
	jsr	_~follow_path
	sta	<L926+res_1
;				if (res == FR_OK) {						/* Is new name already in use by another object? */
	lda	<L926+res_1
	bne	L10557
;					res = (djn.obj.sclust == djo.obj.sclust && djn.dptr == djo.dptr) ? FR_NO_FILE : FR_EXIST;
	lda	<L926+djn_1+8
	cmp	<L926+djo_1+8
	bne	L933
	lda	<L926+djn_1+10
	cmp	<L926+djo_1+10
L933:
	bne	L932
	lda	<L926+djn_1+18
	cmp	<L926+djo_1+18
	bne	L935
	lda	<L926+djn_1+20
	cmp	<L926+djo_1+20
L935:
	bne	L932
	lda	#$4
	bra	L937
L932:
	lda	#$8
L937:
	sta	<L926+res_1
;				}
;				if (res == FR_NO_FILE) { 				/* It is a valid path and no name collision */
L10557:
	lda	<L926+res_1
	cmp	#<$4
	beq	*+5
	brl	L10558
;					res = dir_register(&djn);			/* Register the new entry */
	pea	#0
	clc
	tdc
	adc	#<L926+djn_1
	pha
	jsr	_~dir_register
	sta	<L926+res_1
;					if (res == FR_OK) {
	lda	<L926+res_1
	beq	*+5
	brl	L10558
;						dir = djn.dir;					/* Copy directory entry of the object except name */
	lda	<L926+djn_1+30
	sta	<L926+dir_1
	lda	<L926+djn_1+32
	sta	<L926+dir_1+2
;						memcpy(dir + 13, buf + 13, SZDIRE - 13);
	pea	#<$13
	pea	#0
	clc
	tdc
	adc	#<L926+buf_1+13
	pha
	lda	#$d
	clc
	adc	<L926+dir_1
	sta	<R0
	lda	#$0
	adc	<L926+dir_1+2
	pha
	pei	<R0
	jsr	_~memcpy
;						dir[DIR_Attr] = buf[DIR_Attr];
	sep	#$20
	longa	off
	lda	<L926+buf_1+11
	ldy	#$b
	sta	[<L926+dir_1],Y
;						if (!(dir[DIR_Attr] & AM_DIR)) dir[DIR_Attr] |= AM_ARC;	/* Set archive attribute if it is a file */
	and	#<$10
	rep	#$20
	longa	on
	bne	L10560
	tya
	clc
	adc	<L926+dir_1
	sta	<R0
	lda	#$0
	adc	<L926+dir_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$20
	sta	[<R0]
	rep	#$20
	longa	on
;						fs->wflag = 1;
L10560:
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$4
	sta	[<L926+fs_1],Y
;						if ((dir[DIR_Attr] & AM_DIR) && djo.obj.sclust != djn.obj.sclust) {	/* Update .. entry in the sub-directory being moved if needed */
	ldy	#$b
	lda	[<L926+dir_1],Y
	and	#<$10
	rep	#$20
	longa	on
	beq	L10558
	lda	<L926+djo_1+8
	cmp	<L926+djn_1+8
	bne	L942
	lda	<L926+djo_1+10
	cmp	<L926+djn_1+10
L942:
	beq	L10558
;							LBA_t sect = clst2sect(fs, ld_clust(fs, dir));
;
;							if (sect == 0) {
sect_2	set	142
	pei	<L926+dir_1+2
	pei	<L926+dir_1
	pei	<L926+fs_1+2
	pei	<L926+fs_1
	jsr	_~ld_clust
	sta	<R0
	stx	<R0+2
	phx
	pha
	pei	<L926+fs_1+2
	pei	<L926+fs_1
	jsr	_~clst2sect
	sta	<L926+sect_2
	stx	<L926+sect_2+2
	ora	<L926+sect_2+2
	bne	L10562
;								res = FR_INT_ERR;
	lda	#$2
	sta	<L926+res_1
;							} else {
	bra	L10558
L10562:
;/* Start of critical section where an interruption can cause a cross-link */
;								res = move_window(fs, sect);
	pei	<L926+sect_2+2
	pei	<L926+sect_2
	pei	<L926+fs_1+2
	pei	<L926+fs_1
	jsr	_~move_window
	sta	<L926+res_1
;								dir = fs->win + SZDIRE * 1;	/* Pointer to .. entry */
	lda	#$54
	clc
	adc	<L926+fs_1
	sta	<L926+dir_1
	lda	#$0
	adc	<L926+fs_1+2
	sta	<L926+dir_1+2
;								if (res == FR_OK && dir[1] == '.') {
	lda	<L926+res_1
	bne	L10558
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L926+dir_1],Y
	cmp	#<$2e
	rep	#$20
	longa	on
	bne	L10558
;									st_clust(fs, dir, djn.obj.sclust);
	pei	<L926+djn_1+10
	pei	<L926+djn_1+8
	pei	<L926+dir_1+2
	pei	<L926+dir_1
	pei	<L926+fs_1+2
	pei	<L926+fs_1
	jsr	_~st_clust
;									fs->wflag = 1;
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$4
	sta	[<L926+fs_1],Y
	rep	#$20
	longa	on
;								}
;							}
;						}
;					}
;				}
;			}
L10558:
;			if (res == FR_OK) {		/* New entry has been created */
	lda	<L926+res_1
	bne	L10552
;				res = dir_remove(&djo);	/* Remove old entry */
	pea	#0
	clc
	tdc
	adc	#<L926+djo_1
	pha
	jsr	_~dir_remove
	sta	<L926+res_1
;				if (res == FR_OK) {
	lda	<L926+res_1
	bne	L10552
;					res = sync_fs(fs);
	pei	<L926+fs_1+2
	pei	<L926+fs_1
	jsr	_~sync_fs
	sta	<L926+res_1
;				}
;			}
;/* End of the critical section */
;		}
;		FREE_NAMEBUFF();
;	}
;
;	LEAVE_FF(fs, res);
L10552:
	pei	<L926+res_1
	pei	<L926+fs_1+2
	pei	<L926+fs_1
	jsr	_~unlock_volume
	lda	<L926+res_1
	tay
	lda	<L925+1
	sta	<L925+1+8
	pld
	tsc
	clc
	adc	#L925+8
	tcs
	tya
	rts
;}
L925	equ	150
L926	equ	5
	ends
	efunc
;
;#endif /* !FF_FS_READONLY */
;#endif /* FF_FS_MINIMIZE == 0 */
;#endif /* FF_FS_MINIMIZE <= 1 */
;#endif /* FF_FS_MINIMIZE <= 2 */
;
;
;
;#if FF_USE_CHMOD && !FF_FS_READONLY
;/*-----------------------------------------------------------------------*/
;/* API: Change Attribute                                                 */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_chmod (
;	const TCHAR* path,	/* Pointer to the file path */
;	BYTE attr,			/* Attribute bits to set/clear */
;	BYTE mask			/* Attribute mask to change */
;)
;{
;	FRESULT res;
;	FATFS *fs;
;	DIR dj;
;	DEF_NAMEBUFF
;
;
;	/* Get logical drive and mount the volume if needed */
;	res = mount_volume(&path, &fs, FA_WRITE);
;
;	if (res == FR_OK) {
;		dj.obj.fs = fs;
;		INIT_NAMEBUFF(fs);
;		res = follow_path(&dj, path);	/* Follow the file path */
;		if (res == FR_OK && (dj.fn[NSFLAG] & (NS_DOT | NS_NONAME))) res = FR_INVALID_NAME;	/* Check object validity */
;		if (res == FR_OK) {
;			mask &= AM_RDO|AM_HID|AM_SYS|AM_ARC;	/* Valid attribute mask */
;#if FF_FS_EXFAT
;			if (fs->fs_type == FS_EXFAT) {
;				fs->dirbuf[XDIR_Attr] = (attr & mask) | (fs->dirbuf[XDIR_Attr] & (BYTE)~mask);	/* Apply attribute change */
;				res = store_xdir(&dj);
;			} else
;#endif
;			{
;				dj.dir[DIR_Attr] = (attr & mask) | (dj.dir[DIR_Attr] & (BYTE)~mask);	/* Apply attribute change */
;				fs->wflag = 1;
;			}
;			if (res == FR_OK) {
;				res = sync_fs(fs);
;			}
;		}
;		FREE_NAMEBUFF();
;	}
;
;	LEAVE_FF(fs, res);
;}
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Change Timestamp                                                 */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_utime (
;	const TCHAR* path,	/* Pointer to the file/directory name */
;	const FILINFO* fno	/* Timestamp to be set */
;)
;{
;	FRESULT res;
;	FATFS *fs;
;	DIR dj;
;	DEF_NAMEBUFF
;
;
;	/* Get logical drive and mount the volume if needed */
;	res = mount_volume(&path, &fs, FA_WRITE);
;
;	if (res == FR_OK) {
;		dj.obj.fs = fs;
;		INIT_NAMEBUFF(fs);
;		res = follow_path(&dj, path);	/* Follow the file path */
;		if (res == FR_OK && (dj.fn[NSFLAG] & (NS_DOT | NS_NONAME))) res = FR_INVALID_NAME;	/* Check object validity */
;		if (res == FR_OK) {
;#if FF_FS_EXFAT
;			if (fs->fs_type == FS_EXFAT) {	/* On the exFAT volume */
;				if (fno->fdate) {	/* Change last modified time if needed */
;					st_32(fs->dirbuf + XDIR_ModTime, (DWORD)fno->fdate << 16 | fno->ftime);
;					fs->dirbuf[XDIR_ModTime10] = 0;
;					fs->dirbuf[XDIR_ModTZ] = 0;
;				}
;#if FF_FS_CRTIME
;				if (fno->crdate) {	/* Change created time if needed */
;					st_32(fs->dirbuf + XDIR_CrtTime, (DWORD)fno->crdate << 16 | fno->crtime);
;					fs->dirbuf[XDIR_CrtTime10] = 0;
;					fs->dirbuf[XDIR_CrtTZ] = 0;
;				}
;#endif
;				res = store_xdir(&dj);
;			} else
;#endif
;			{	/* On the FAT volume */
;				if (fno->fdate) {	/* Change last modified time if needed */
;					st_32(dj.dir + DIR_ModTime, (DWORD)fno->fdate << 16 | fno->ftime);
;				}
;#if FF_FS_CRTIME
;				if (fno->crdate) {	/* Change created time if needed */
;					st_32(dj.dir + DIR_CrtTime, (DWORD)fno->crdate << 16 | fno->crtime);
;					dj.dir[DIR_CrtTime10] = 0;
;				}
;#endif
;				fs->wflag = 1;
;			}
;			if (res == FR_OK) {
;				res = sync_fs(fs);
;			}
;		}
;		FREE_NAMEBUFF();
;	}
;
;	LEAVE_FF(fs, res);
;}
;
;#endif	/* FF_USE_CHMOD && !FF_FS_READONLY */
;
;
;
;#if FF_USE_LABEL
;/*-----------------------------------------------------------------------*/
;/* API: Get Volume Label                                                 */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_getlabel (
;	const TCHAR* path,	/* Logical drive number */
;	TCHAR* label,		/* Buffer to store the volume label */
;	DWORD* vsn			/* Variable to store the volume serial number */
;)
;{
;	FRESULT res;
;	FATFS *fs;
;	DIR dj;
;	UINT si, di;
;	WCHAR wc;
;
;
;	res = mount_volume(&path, &fs, 0);	/* Get logical drive and mount the volume if needed */
;
;	/* Get volume label */
;	if (res == FR_OK && label) {
;		dj.obj.fs = fs; dj.obj.sclust = 0;	/* Open root directory */
;		res = dir_sdi(&dj, 0);
;		if (res == FR_OK) {
;		 	res = DIR_READ_LABEL(&dj);		/* Find a volume label entry */
;		 	if (res == FR_OK) {
;#if FF_FS_EXFAT
;				if (fs->fs_type == FS_EXFAT) {
;					WCHAR hs;
;					UINT nw;
;
;					for (si = di = hs = 0; si < dj.dir[XDIR_NumLabel]; si++) {	/* Extract volume label from 83 entry */
;						wc = ld_16(dj.dir + XDIR_Label + si * 2);
;						if (hs == 0 && IsSurrogate(wc)) {	/* Is the code a surrogate? */
;							hs = wc; continue;
;						}
;						nw = put_utf((DWORD)hs << 16 | wc, &label[di], 4);	/* Store it in API encoding */
;						if (nw == 0) {		/* Encode error? */
;							di = 0; break;
;						}
;						di += nw;
;						hs = 0;
;					}
;					if (hs != 0) di = 0;	/* Broken surrogate pair? */
;					label[di] = 0;
;				} else
;#endif
;				{
;					si = di = 0;		/* Extract volume label from AM_VOL entry */
;					while (si < 11) {
;						wc = dj.dir[si++];
;#if FF_USE_LFN && FF_LFN_UNICODE >= 1 	/* Unicode output */
;						if (dbc_1st((BYTE)wc) && si < 11) wc = wc << 8 | dj.dir[si++];	/* Is it a DBC? */
;						wc = ff_oem2uni(wc, CODEPAGE);		/* Convert it into Unicode */
;						if (wc == 0) {		/* Invalid char in current code page? */
;							di = 0; break;
;						}
;						di += put_utf(wc, &label[di], 4);	/* Store it in Unicode */
;#else									/* ANSI/OEM output */
;						label[di++] = (TCHAR)wc;
;#endif
;					}
;					do {				/* Truncate trailing spaces */
;						label[di] = 0;
;						if (di == 0) break;
;					} while (label[--di] == ' ');
;				}
;			}
;		}
;		if (res == FR_NO_FILE) {	/* No label entry and return nul string */
;			label[0] = 0;
;			res = FR_OK;
;		}
;	}
;
;	/* Get volume serial number */
;	if (res == FR_OK && vsn) {
;		res = move_window(fs, fs->volbase);	/* Load VBR */
;		if (res == FR_OK) {
;			switch (fs->fs_type) {
;			case FS_EXFAT:
;				di = BPB_VolIDEx;
;				break;
;
;			case FS_FAT32:
;				di = BS_VolID32;
;				break;
;
;			default:	/* FAT12/16 */
;				di = fs->win[BS_BootSig] == 0x29 ? BS_VolID : 0;
;			}
;			*vsn = di ? ld_32(fs->win + di) : 0;	/* Get VSN in the VBR */
;		}
;	}
;
;	LEAVE_FF(fs, res);
;}
;
;
;
;#if !FF_FS_READONLY
;/*-----------------------------------------------------------------------*/
;/* API: Set Volume Label                                                 */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_setlabel (
;	const TCHAR* label	/* Volume label to set with heading logical drive number */
;)
;{
;	FRESULT res;
;	FATFS *fs;
;	DIR dj;
;	BYTE dirvn[22];
;	UINT di;
;	WCHAR wc;
;	static const char badchr[18] = "+.,;=[]" "/*:<>|\\\"\?\x7F";	/* [0..16] for FAT, [7..16] for exFAT */
;#if FF_USE_LFN
;	DWORD dc;
;#endif
;
;	/* Get logical drive and mount the volume if needed */
;	res = mount_volume(&label, &fs, FA_WRITE);
;	if (res != FR_OK) LEAVE_FF(fs, res);
;#if FF_STR_VOLUME_ID == 2
;	for ( ; *label == '/'; label++) ;	/* Snip the separators off */
;#endif
;
;#if FF_FS_EXFAT
;	if (fs->fs_type == FS_EXFAT) {	/* On the exFAT volume */
;		memset(dirvn, 0, 22);
;		di = 0;
;		while ((UINT)*label >= ' ') {	/* Create volume label */
;			dc = tchar2uni(&label);	/* Get a Unicode character */
;			if (dc >= 0x10000) {
;				if (dc == 0xFFFFFFFF || di >= 10) {	/* Wrong surrogate or buffer overflow */
;					dc = 0;
;				} else {
;					st_16(dirvn + di * 2, (WCHAR)(dc >> 16)); di++;
;				}
;			}
;			if (dc == 0 || strchr(&badchr[7], (int)dc) || di >= 11) {	/* Check validity of the volume label */
;				LEAVE_FF(fs, FR_INVALID_NAME);
;			}
;			st_16(dirvn + di * 2, (WCHAR)dc); di++;
;		}
;	} else
;#endif
;	{	/* On the FAT/FAT32 volume */
;		memset(dirvn, ' ', 11);
;		di = 0;
;		while ((UINT)*label >= ' ') {	/* Create volume label */
;#if FF_USE_LFN
;			dc = tchar2uni(&label);
;			wc = (dc < 0x10000) ? ff_uni2oem(ff_wtoupper(dc), CODEPAGE) : 0;
;#else									/* ANSI/OEM input */
;			wc = (BYTE)*label++;
;			if (dbc_1st((BYTE)wc)) wc = dbc_2nd((BYTE)*label) ? wc << 8 | (BYTE)*label++ : 0;
;			if (IsLower(wc)) wc -= 0x20;		/* To upper ASCII characters */
;#if FF_CODE_PAGE == 0
;			if (ExCvt && wc >= 0x80) wc = ExCvt[wc - 0x80];	/* To upper extended characters (SBCS cfg) */
;#elif FF_CODE_PAGE < 900
;			if (wc >= 0x80) wc = ExCvt[wc - 0x80];	/* To upper extended characters (SBCS cfg) */
;#endif
;#endif
;			if (wc == 0 || strchr(&badchr[0], (int)wc) || di >= (UINT)((wc >= 0x100) ? 10 : 11)) {	/* Reject invalid characters for volume label */
;				LEAVE_FF(fs, FR_INVALID_NAME);
;			}
;			if (wc >= 0x100) dirvn[di++] = (BYTE)(wc >> 8);
;			dirvn[di++] = (BYTE)wc;
;		}
;		if (dirvn[0] == DDEM) LEAVE_FF(fs, FR_INVALID_NAME);	/* Reject illegal name (heading DDEM) */
;		while (di && dirvn[di - 1] == ' ') di--;				/* Snip trailing spaces */
;	}
;
;	/* Set volume label */
;	dj.obj.fs = fs; dj.obj.sclust = 0;	/* Open root directory */
;	res = dir_sdi(&dj, 0);
;	if (res == FR_OK) {
;		res = DIR_READ_LABEL(&dj);	/* Get volume label entry */
;		if (res == FR_OK) {
;			if (FF_FS_EXFAT && fs->fs_type == FS_EXFAT) {
;				dj.dir[XDIR_NumLabel] = (BYTE)di;	/* Change the volume label */
;				memcpy(dj.dir + XDIR_Label, dirvn, 22);
;			} else {
;				if (di != 0) {
;					memcpy(dj.dir, dirvn, 11);	/* Change the volume label */
;				} else {
;					dj.dir[DIR_Name] = DDEM;	/* Remove the volume label */
;				}
;			}
;			fs->wflag = 1;
;			res = sync_fs(fs);
;		} else {			/* No volume label entry or an error */
;			if (res == FR_NO_FILE) {
;				res = FR_OK;
;				if (di != 0) {	/* Create a volume label entry */
;					res = dir_alloc(&dj, 1);	/* Allocate an entry */
;					if (res == FR_OK) {
;						memset(dj.dir, 0, SZDIRE);	/* Clean the entry */
;						if (FF_FS_EXFAT && fs->fs_type == FS_EXFAT) {
;							dj.dir[XDIR_Type] = ET_VLABEL;	/* Create volume label entry */
;							dj.dir[XDIR_NumLabel] = (BYTE)di;
;							memcpy(dj.dir + XDIR_Label, dirvn, 22);
;						} else {
;							dj.dir[DIR_Attr] = AM_VOL;		/* Create volume label entry */
;							memcpy(dj.dir, dirvn, 11);
;						}
;						fs->wflag = 1;
;						res = sync_fs(fs);
;					}
;				}
;			}
;		}
;	}
;
;	LEAVE_FF(fs, res);
;}
;
;#endif /* !FF_FS_READONLY */
;#endif /* FF_USE_LABEL */
;
;
;
;#if FF_USE_EXPAND && !FF_FS_READONLY
;/*-----------------------------------------------------------------------*/
;/* API: Allocate a Contiguous Blocks to the File                         */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_expand (
;	FIL* fp,		/* Pointer to the file object */
;	FSIZE_t fsz,	/* File size to be expanded to */
;	BYTE opt		/* Operation mode 0:Find and prepare or 1:Find and allocate */
;)
;{
	code
	xdef	_~f_expand
	func
_~f_expand:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L950
	tcs
	phd
	tcd
fp_0	set	3
fsz_0	set	7
opt_0	set	11
;	FRESULT res;
;	FATFS *fs;
;	DWORD n, clst, stcl, scl, ncl, tcl, lclst;
;
;
;	res = validate(&fp->obj, &fs);		/* Check validity of the file object */
res_1	set	0
fs_1	set	2
n_1	set	6
clst_1	set	10
stcl_1	set	14
scl_1	set	18
ncl_1	set	22
tcl_1	set	26
lclst_1	set	30
	pea	#0
	clc
	tdc
	adc	#<L951+fs_1
	pha
	pei	<L950+fp_0+2
	pei	<L950+fp_0
	jsr	_~validate
	sta	<L951+res_1
;	if (res != FR_OK || (res = (FRESULT)fp->err) != FR_OK) LEAVE_FF(fs, res);
	lda	<L951+res_1
	bne	L952
	ldy	#$13
	lda	[<L950+fp_0],Y
	and	#$ff
	sta	<L951+res_1
	lda	<L951+res_1
	beq	L10567
L952:
	pei	<L951+res_1
	pei	<L951+fs_1+2
	pei	<L951+fs_1
	jsr	_~unlock_volume
	lda	<L951+res_1
L955:
	tay
	lda	<L950+1
	sta	<L950+1+10
	pld
	tsc
	clc
	adc	#L950+10
	tcs
	tya
	rts
L10567:
;	if (fsz == 0 || fp->obj.objsize != 0 || !(fp->flag & FA_WRITE)) LEAVE_FF(fs, FR_DENIED);
	lda	<L950+fsz_0
	ora	<L950+fsz_0+2
	beq	L956
	ldy	#$c
	lda	[<L950+fp_0],Y
	iny
	iny
	ora	[<L950+fp_0],Y
	bne	L956
	sep	#$20
	longa	off
	ldy	#$12
	lda	[<L950+fp_0],Y
	and	#<$2
	rep	#$20
	longa	on
	bne	L10568
L956:
	pea	#<$7
	pei	<L951+fs_1+2
	pei	<L951+fs_1
	jsr	_~unlock_volume
	lda	#$7
	bra	L955
L10568:
;#if FF_FS_EXFAT
;	if (fs->fs_type != FS_EXFAT && fsz >= 0x100000000) LEAVE_FF(fs, FR_DENIED);	/* Check if in size limit */
;#endif
;	n = (DWORD)fs->csize * SS(fs);	/* Cluster size */
	ldy	#$a
	lda	[<L951+fs_1],Y
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$9
	xref	_~~lasl
	jsr	_~~lasl
	sta	<L951+n_1
	stx	<L951+n_1+2
;	tcl = (DWORD)(fsz / n) + ((fsz & (n - 1)) ? 1 : 0);	/* Number of clusters required */
	lda	#$ffff
	clc
	adc	<L951+n_1
	sta	<R0
	lda	#$ffff
	adc	<L951+n_1+2
	sta	<R0+2
	lda	<L950+fsz_0
	and	<R0
	sta	<R1
	lda	<L950+fsz_0+2
	and	<R0+2
	sta	<R1+2
	lda	<R1
	ora	<R1+2
	beq	L960
	lda	#$1
	bra	L962
L960:
	lda	#$0
L962:
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L963
	dey
L963:
	sta	<R0
	sty	<R0+2
	pei	<L951+n_1+2
	pei	<L951+n_1
	pei	<L950+fsz_0+2
	pei	<L950+fsz_0
	xref	_~~ludv
	jsr	_~~ludv
	stx	<R1+2
	clc
	adc	<R0
	sta	<L951+tcl_1
	lda	<R1+2
	adc	<R0+2
	sta	<L951+tcl_1+2
;	stcl = fs->last_clst; lclst = 0;
	ldy	#$c
	lda	[<L951+fs_1],Y
	sta	<L951+stcl_1
	iny
	iny
	lda	[<L951+fs_1],Y
	sta	<L951+stcl_1+2
	stz	<L951+lclst_1
	stz	<L951+lclst_1+2
;	if (stcl < 2 || stcl >= fs->n_fatent) stcl = 2;
	lda	<L951+stcl_1
	cmp	#<$2
	lda	<L951+stcl_1+2
	sbc	#^$2
	bcc	L964
	lda	<L951+stcl_1
	ldy	#$18
	cmp	[<L951+fs_1],Y
	lda	<L951+stcl_1+2
	iny
	iny
	sbc	[<L951+fs_1],Y
	bcc	L10569
L964:
	lda	#$2
	sta	<L951+stcl_1
	dea
	dea
	sta	<L951+stcl_1+2
;
;#if FF_FS_EXFAT
;	if (fs->fs_type == FS_EXFAT) {
;		scl = find_bitmap(fs, stcl, tcl);			/* Find a contiguous cluster block */
;		if (scl == 0) res = FR_DENIED;				/* No contiguous cluster block was found */
;		if (scl == 0xFFFFFFFF) res = FR_DISK_ERR;
;		if (res == FR_OK) {	/* A contiguous free area is found */
;			if (opt) {		/* Allocate it now */
;				res = change_bitmap(fs, scl, tcl, 1);	/* Mark the cluster block 'in use' */
;				lclst = scl + tcl - 1;
;			} else {		/* Set it as suggested point for next allocation */
;				lclst = scl - 1;
;			}
;		}
;	} else
;#endif
;	{
L10569:
;		scl = clst = stcl; ncl = 0;
	lda	<L951+stcl_1
	sta	<L951+clst_1
	lda	<L951+stcl_1+2
	sta	<L951+clst_1+2
	lda	<L951+stcl_1
	sta	<L951+scl_1
	lda	<L951+stcl_1+2
	sta	<L951+scl_1+2
	stz	<L951+ncl_1
	stz	<L951+ncl_1+2
;		for (;;) {	/* Find a contiguous cluster block */
L10572:
;			n = get_fat(&fp->obj, clst);
	pei	<L951+clst_1+2
	pei	<L951+clst_1
	pei	<L950+fp_0+2
	pei	<L950+fp_0
	jsr	_~get_fat
	sta	<L951+n_1
	stx	<L951+n_1+2
;			if (++clst >= fs->n_fatent) clst = 2;
	inc	<L951+clst_1
	bne	L967
	inc	<L951+clst_1+2
L967:
	lda	<L951+clst_1
	ldy	#$18
	cmp	[<L951+fs_1],Y
	lda	<L951+clst_1+2
	iny
	iny
	sbc	[<L951+fs_1],Y
	bcc	L10573
	lda	#$2
	sta	<L951+clst_1
	dea
	dea
	sta	<L951+clst_1+2
;			if (n == 1) {
L10573:
	lda	<L951+n_1
	cmp	#<$1
	bne	L969
	lda	<L951+n_1+2
	cmp	#^$1
L969:
	bne	L10574
;				res = FR_INT_ERR; break;
	lda	#$2
	bra	L20190
L20183:
;				res = FR_DISK_ERR; break;
	lda	#$1
	bra	L20190
;			}
;			if (n == 0xFFFFFFFF) {
L10574:
	lda	<L951+n_1
	cmp	#<$ffffffff
	bne	L971
	lda	<L951+n_1+2
	cmp	#^$ffffffff
L971:
	beq	L20183
;			}
;			if (n == 0) {	/* Is it a free cluster? */
	lda	<L951+n_1
	ora	<L951+n_1+2
	bne	L10576
;				if (++ncl == tcl) break;	/* Break if a contiguous cluster block is found */
	inc	<L951+ncl_1
	bne	L974
	inc	<L951+ncl_1+2
L974:
	lda	<L951+ncl_1
	cmp	<L951+tcl_1
	bne	L975
	lda	<L951+ncl_1+2
	cmp	<L951+tcl_1+2
L975:
	bne	L10577
	bra	L10571
;			} else {
L10576:
;				scl = clst; ncl = 0;		/* Not a free cluster */
	lda	<L951+clst_1
	sta	<L951+scl_1
	lda	<L951+clst_1+2
	sta	<L951+scl_1+2
	stz	<L951+ncl_1
	stz	<L951+ncl_1+2
;			}
L10577:
;			if (clst == stcl) {		/* No contiguous cluster? */
	lda	<L951+clst_1
	cmp	<L951+stcl_1
	bne	L977
	lda	<L951+clst_1+2
	cmp	<L951+stcl_1+2
L977:
	beq	*+5
	brl	L10572
;				res = FR_DENIED; break;
	lda	#$7
L20190:
	sta	<L951+res_1
L10571:
;		if (res == FR_OK) {	/* A contiguous free area is found */
	lda	<L951+res_1
	beq	*+5
	brl	L10579
;			}
;		}
;			if (opt) {		/* Allocate it now */
	lda	<L950+opt_0
	and	#$ff
	beq	L10580
;				for (clst = scl, n = tcl; n; clst++, n--) {	/* Create a cluster chain on the FAT */
	lda	<L951+scl_1
	sta	<L951+clst_1
	lda	<L951+scl_1+2
	sta	<L951+clst_1+2
	lda	<L951+tcl_1
	sta	<L951+n_1
	lda	<L951+tcl_1+2
	sta	<L951+n_1+2
	bra	L10584
L981:
	lda	#$1
	clc
	adc	<L951+clst_1
	sta	<R0
	lda	#$0
	adc	<L951+clst_1+2
	sta	<R0+2
	ldx	<R0+2
	lda	<R0
	bra	L984
L20185:
;					lclst = clst;
	lda	<L951+clst_1
	sta	<L951+lclst_1
	lda	<L951+clst_1+2
	sta	<L951+lclst_1+2
;				}
	lda	<L951+n_1
	bne	L986
	dec	<L951+n_1+2
L986:
	dec	<L951+n_1
	inc	<L951+clst_1
	bne	L10584
	inc	<L951+clst_1+2
L10584:
	lda	<L951+n_1
	ora	<L951+n_1+2
	beq	L10579
;					res = put_fat(fs, clst, (n == 1) ? 0xFFFFFFFF : clst + 1);
	lda	<L951+n_1
	cmp	#<$1
	bne	L982
	lda	<L951+n_1+2
	cmp	#^$1
L982:
	bne	L981
	lda	#$ffff
	tax
L984:
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L951+clst_1+2
	pei	<L951+clst_1
	pei	<L951+fs_1+2
	pei	<L951+fs_1
	jsr	_~put_fat
	sta	<L951+res_1
;					if (res != FR_OK) break;
	lda	<L951+res_1
	bne	L10579
;			} else {		/* Set it as suggested point for next allocation */
	bra	L20185
L10580:
;				lclst = scl - 1;
	lda	#$ffff
	clc
	adc	<L951+scl_1
	sta	<L951+lclst_1
	lda	#$ffff
	adc	<L951+scl_1+2
	sta	<L951+lclst_1+2
;			}
;		}
;	}
L10579:
;
;	if (res == FR_OK) {
	lda	<L951+res_1
	beq	*+5
	brl	L952
;		fs->last_clst = lclst;		/* Set suggested start cluster to start next */
	lda	<L951+lclst_1
	ldy	#$c
	sta	[<L951+fs_1],Y
	lda	<L951+lclst_1+2
	iny
	iny
	sta	[<L951+fs_1],Y
;		if (opt) {	/* Is it allocated now? */
	lda	<L950+opt_0
	and	#$ff
	bne	*+5
	brl	L952
;			fp->obj.sclust = scl;		/* Update object allocation information */
	lda	<L951+scl_1
	ldy	#$8
	sta	[<L950+fp_0],Y
	lda	<L951+scl_1+2
	iny
	iny
	sta	[<L950+fp_0],Y
;			fp->obj.objsize = fsz;
	lda	<L950+fsz_0
	iny
	iny
	sta	[<L950+fp_0],Y
	lda	<L950+fsz_0+2
	iny
	iny
	sta	[<L950+fp_0],Y
;			if (FF_FS_EXFAT) fp->obj.stat = 2;	/* Set status 'contiguous chain' */
;			fp->flag |= FA_MODIFIED;
	lda	#$12
	clc
	adc	<L950+fp_0
	sta	<R0
	lda	#$0
	adc	<L950+fp_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$40
	sta	[<R0]
	rep	#$20
	longa	on
;			if (fs->free_clst <= fs->n_fatent - 2) {	/* Update FSINFO */
	clc
	lda	#$fffe
	ldy	#$18
	adc	[<L951+fs_1],Y
	sta	<R0
	lda	#$ffff
	iny
	iny
	adc	[<L951+fs_1],Y
	sta	<R0+2
	lda	<R0
	ldy	#$10
	cmp	[<L951+fs_1],Y
	lda	<R0+2
	iny
	iny
	sbc	[<L951+fs_1],Y
	bcs	*+5
	brl	L952
;				fs->free_clst -= tcl;
	lda	#$10
	clc
	adc	<L951+fs_1
	sta	<R0
	lda	#$0
	adc	<L951+fs_1+2
	sta	<R0+2
	sec
	lda	[<R0]
	sbc	<L951+tcl_1
	sta	[<R0]
	ldy	#$2
	lda	[<R0],Y
	sbc	<L951+tcl_1+2
	sta	[<R0],Y
;				fs->fsi_flag |= 1;
	lda	#$5
	clc
	adc	<L951+fs_1
	sta	<R0
	lda	#$0
	adc	<L951+fs_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$1
	sta	[<R0]
	rep	#$20
	longa	on
;			}
;		}
;	}
;
;	LEAVE_FF(fs, res);
	brl	L952
;}
L950	equ	42
L951	equ	9
	ends
	efunc
;
;#endif /* FF_USE_EXPAND && !FF_FS_READONLY */
;
;
;
;#if FF_USE_FORWARD
;/*-----------------------------------------------------------------------*/
;/* API: Forward Data to the Stream Directly                              */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_forward (
;	FIL* fp, 						/* Pointer to the file object */
;	UINT (*func)(const BYTE*,UINT),	/* Pointer to the streaming function */
;	UINT btf,						/* Number of bytes to forward */
;	UINT* bf						/* Pointer to number of bytes forwarded */
;)
;{
	code
	xdef	_~f_forward
	func
_~f_forward:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L992
	tcs
	phd
	tcd
fp_0	set	3
func_0	set	7
btf_0	set	9
bf_0	set	11
;	FRESULT res;
;	FATFS *fs;
;	DWORD clst;
;	LBA_t sect;
;	FSIZE_t remain;
;	UINT rcnt, csect;
;	BYTE *dbuf;
;
;
;	*bf = 0;	/* Clear transfer byte counter */
res_1	set	0
fs_1	set	2
clst_1	set	6
sect_1	set	10
remain_1	set	14
rcnt_1	set	18
csect_1	set	20
dbuf_1	set	22
	lda	#$0
	sta	[<L992+bf_0]
;	res = validate(&fp->obj, &fs);		/* Check validity of the file object */
	pea	#0
	clc
	tdc
	adc	#<L993+fs_1
	pha
	pei	<L992+fp_0+2
	pei	<L992+fp_0
	jsr	_~validate
	sta	<L993+res_1
;	if (res != FR_OK || (res = (FRESULT)fp->err) != FR_OK) LEAVE_FF(fs, res);
	lda	<L993+res_1
	bne	L994
	ldy	#$13
	lda	[<L992+fp_0],Y
	and	#$ff
	sta	<L993+res_1
	lda	<L993+res_1
	beq	L10590
L994:
	pei	<L993+res_1
	pei	<L993+fs_1+2
	pei	<L993+fs_1
	jsr	_~unlock_volume
	lda	<L993+res_1
L997:
	tay
	lda	<L992+1
	sta	<L992+1+12
	pld
	tsc
	clc
	adc	#L992+12
	tcs
	tya
	rts
L10590:
;	if (!(fp->flag & FA_READ)) LEAVE_FF(fs, FR_DENIED);	/* Check access mode */
	sep	#$20
	longa	off
	ldy	#$12
	lda	[<L992+fp_0],Y
	and	#<$1
	rep	#$20
	longa	on
	bne	L10591
	pea	#<$7
	pei	<L993+fs_1+2
	pei	<L993+fs_1
	jsr	_~unlock_volume
	lda	#$7
	bra	L997
L10591:
;
;	remain = fp->obj.objsize - fp->fptr;
	sec
	ldy	#$c
	lda	[<L992+fp_0],Y
	ldy	#$14
	sbc	[<L992+fp_0],Y
	sta	<L993+remain_1
	ldy	#$e
	lda	[<L992+fp_0],Y
	ldy	#$16
	sbc	[<L992+fp_0],Y
	sta	<L993+remain_1+2
;	if (btf > remain) btf = (UINT)remain;			/* Truncate btf by remaining bytes */
	lda	<L992+btf_0
	sta	<R0
	stz	<R0+2
	lda	<L993+remain_1
	cmp	<R0
	lda	<L993+remain_1+2
	sbc	<R0+2
	bcc	*+5
	brl	L10596
	lda	<L993+remain_1
	brl	L20193
;
;	for ( ; btf > 0 && (*func)(0, 0); fp->fptr += rcnt, *bf += rcnt, btf -= rcnt) {	/* Repeat until all data transferred or stream goes busy */
L10595:
;		csect = (UINT)(fp->fptr / SS(fs) & (fs->csize - 1));	/* Sector offset in the cluster */
	ldy	#$16
	lda	[<L992+fp_0],Y
	pha
	dey
	dey
	lda	[<L992+fp_0],Y
	pha
	lda	#$9
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R0
	stx	<R0+2
	clc
	lda	#$ffff
	ldy	#$a
	adc	[<L993+fs_1],Y
	sta	<R1
	stz	<R1+2
	lda	<R1
	and	<R0
	sta	<R2
	lda	<R1+2
	and	<R0+2
	sta	<R2+2
	lda	<R2
	sta	<L993+csect_1
;		if (fp->fptr % SS(fs) == 0) {				/* On the sector boundary? */
	ldy	#$14
	lda	[<L992+fp_0],Y
	and	#<$1ff
	beq	*+5
	brl	L10597
;			if (csect == 0) {						/* On the cluster boundary? */
	lda	<L993+csect_1
	beq	*+5
	brl	L10597
;				clst = (fp->fptr == 0) ?			/* On the top of the file? */
;					fp->obj.sclust : get_fat(&fp->obj, fp->clust);
	lda	[<L992+fp_0],Y
	iny
	iny
	ora	[<L992+fp_0],Y
	bne	L1002
	ldy	#$a
	lda	[<L992+fp_0],Y
	tax
	dey
	dey
	lda	[<L992+fp_0],Y
	bra	L1004
L1002:
	ldy	#$1a
	lda	[<L992+fp_0],Y
	pha
	dey
	dey
	lda	[<L992+fp_0],Y
	pha
	pei	<L992+fp_0+2
	pei	<L992+fp_0
	jsr	_~get_fat
	sta	<R0
	stx	<R0+2
	ldx	<R0+2
	lda	<R0
L1004:
	stx	<R0+2
	sta	<L993+clst_1
	lda	<R0+2
	sta	<L993+clst_1+2
;				if (clst <= 1) ABORT(fs, FR_INT_ERR);
	lda	#$1
	cmp	<L993+clst_1
	dea
	sbc	<L993+clst_1+2
	bcc	L10599
	sep	#$20
	longa	off
	lda	#$2
	ldy	#$13
	sta	[<L992+fp_0],Y
	rep	#$20
	longa	on
L20198:
	pea	#<$2
	pei	<L993+fs_1+2
	pei	<L993+fs_1
	jsr	_~unlock_volume
	lda	#$2
	brl	L997
L10599:
;				if (clst == 0xFFFFFFFF) ABORT(fs, FR_DISK_ERR);
	lda	<L993+clst_1
	cmp	#<$ffffffff
	bne	L1006
	lda	<L993+clst_1+2
	cmp	#^$ffffffff
L1006:
	bne	L10600
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L992+fp_0],Y
	rep	#$20
	longa	on
L20207:
	pea	#<$1
	pei	<L993+fs_1+2
	pei	<L993+fs_1
	jsr	_~unlock_volume
	lda	#$1
	brl	L997
L10600:
;				fp->clust = clst;					/* Update current cluster */
	lda	<L993+clst_1
	ldy	#$18
	sta	[<L992+fp_0],Y
	lda	<L993+clst_1+2
	iny
	iny
	sta	[<L992+fp_0],Y
;			}
;		}
;		sect = clst2sect(fs, fp->clust);			/* Get current data sector */
L10597:
	ldy	#$1a
	lda	[<L992+fp_0],Y
	pha
	dey
	dey
	lda	[<L992+fp_0],Y
	pha
	pei	<L993+fs_1+2
	pei	<L993+fs_1
	jsr	_~clst2sect
	sta	<L993+sect_1
	stx	<L993+sect_1+2
;		if (sect == 0) ABORT(fs, FR_INT_ERR);
	ora	<L993+sect_1+2
	bne	L10601
	sep	#$20
	longa	off
	lda	#$2
	ldy	#$13
	sta	[<L992+fp_0],Y
	rep	#$20
	longa	on
	bra	L20198
L10601:
;		sect += csect;
	lda	<L993+csect_1
	sta	<R0
	stz	<R0+2
	lda	<R0
	clc
	adc	<L993+sect_1
	sta	<L993+sect_1
	lda	<R0+2
	adc	<L993+sect_1+2
	sta	<L993+sect_1+2
;#if FF_FS_TINY
;		if (move_window(fs, sect) != FR_OK) ABORT(fs, FR_DISK_ERR);	/* Move sector window to the file data */
;		dbuf = fs->win;
;#else
;		if (fp->sect != sect) {		/* Fill sector cache with file data */
	ldy	#$1c
	lda	[<L992+fp_0],Y
	cmp	<L993+sect_1
	bne	L1009
	iny
	iny
	lda	[<L992+fp_0],Y
	cmp	<L993+sect_1+2
L1009:
	bne	*+5
	brl	L10602
;#if !FF_FS_READONLY
;			if (fp->flag & FA_DIRTY) {		/* Write-back dirty sector cache */
	sep	#$20
	longa	off
	ldy	#$12
	lda	[<L992+fp_0],Y
	and	#<$80
	rep	#$20
	longa	on
	beq	L10603
;				if (disk_write(fs->pdrv, fp->buf, fp->sect, 1) != RES_OK) ABORT(fs, FR_DISK_ERR);
	pea	#<$1
	ldy	#$1e
	lda	[<L992+fp_0],Y
	pha
	dey
	dey
	lda	[<L992+fp_0],Y
	pha
	lda	#$2c
	clc
	adc	<L992+fp_0
	sta	<R0
	lda	#$0
	adc	<L992+fp_0+2
	pha
	pei	<R0
	ldy	#$1
	lda	[<L993+fs_1],Y
	pha
	jsr	_~disk_write
	tax
	beq	L10604
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L992+fp_0],Y
	rep	#$20
	longa	on
	brl	L20207
L10604:
;				fp->flag &= (BYTE)~FA_DIRTY;
	lda	#$12
	clc
	adc	<L992+fp_0
	sta	<R0
	lda	#$0
	adc	<L992+fp_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	and	#<$7f
	sta	[<R0]
	rep	#$20
	longa	on
;			}
;#endif
;			if (disk_read(fs->pdrv, fp->buf, sect, 1) != RES_OK) ABORT(fs, FR_DISK_ERR);
L10603:
	pea	#<$1
	pei	<L993+sect_1+2
	pei	<L993+sect_1
	lda	#$2c
	clc
	adc	<L992+fp_0
	sta	<R0
	lda	#$0
	adc	<L992+fp_0+2
	pha
	pei	<R0
	ldy	#$1
	lda	[<L993+fs_1],Y
	pha
	jsr	_~disk_read
	tax
	beq	L10602
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$13
	sta	[<L992+fp_0],Y
	rep	#$20
	longa	on
	brl	L20207
;		}
;		dbuf = fp->buf;
L10602:
	lda	#$2c
	clc
	adc	<L992+fp_0
	sta	<L993+dbuf_1
	lda	#$0
	adc	<L992+fp_0+2
	sta	<L993+dbuf_1+2
;#endif
;		fp->sect = sect;
	lda	<L993+sect_1
	ldy	#$1c
	sta	[<L992+fp_0],Y
	lda	<L993+sect_1+2
	iny
	iny
	sta	[<L992+fp_0],Y
;		rcnt = SS(fs) - (UINT)fp->fptr % SS(fs);	/* Number of bytes remains in the sector */
	ldy	#$14
	lda	[<L992+fp_0],Y
	and	#<$1ff
	sta	<R0
	sec
	lda	#$200
	sbc	<R0
	sta	<L993+rcnt_1
;		if (rcnt > btf) rcnt = btf;					/* Clip it by btr if needed */
	lda	<L992+btf_0
	cmp	<L993+rcnt_1
	bcs	L10606
	lda	<L992+btf_0
	sta	<L993+rcnt_1
;		rcnt = (*func)(dbuf + ((UINT)fp->fptr % SS(fs)), rcnt);	/* Forward the file data */
L10606:
	pei	<L993+rcnt_1
	ldy	#$14
	lda	[<L992+fp_0],Y
	and	#<$1ff
	sta	<R0
	stz	<R0+2
	lda	<L993+dbuf_1
	clc
	adc	<R0
	sta	<R1
	lda	<L993+dbuf_1+2
	adc	<R0+2
	pha
	pei	<R1
	lda	<L992+func_0
	xref	_~~cal
	jsr	_~~cal
	sta	<L993+rcnt_1
;		if (rcnt == 0) ABORT(fs, FR_INT_ERR);
	lda	<L993+rcnt_1
	bne	L10593
	sep	#$20
	longa	off
	lda	#$2
	ldy	#$13
	sta	[<L992+fp_0],Y
	rep	#$20
	longa	on
	brl	L20198
;	}
L10593:
	lda	#$14
	clc
	adc	<L992+fp_0
	sta	<R0
	lda	#$0
	adc	<L992+fp_0+2
	sta	<R0+2
	lda	<L993+rcnt_1
	sta	<R1
	stz	<R1+2
	lda	<R1
	clc
	adc	[<R0]
	sta	[<R0]
	lda	<R1+2
	ldy	#$2
	adc	[<R0],Y
	sta	[<R0],Y
	lda	[<L992+bf_0]
	clc
	adc	<L993+rcnt_1
	sta	[<L992+bf_0]
	sec
	lda	<L992+btf_0
	sbc	<L993+rcnt_1
L20193:
	sta	<L992+btf_0
L10596:
	lda	#$0
	cmp	<L992+btf_0
	bcs	L10594
	pea	#<$0
	pea	#^$0
	pea	#<$0
	lda	<L992+func_0
	xref	_~~cal
	jsr	_~~cal
	tax
	beq	*+5
	brl	L10595
L10594:
;
;	LEAVE_FF(fs, FR_OK);
	pea	#<$0
	pei	<L993+fs_1+2
	pei	<L993+fs_1
	jsr	_~unlock_volume
	lda	#$0
	brl	L997
;}
L992	equ	38
L993	equ	13
	ends
	efunc
;#endif /* FF_USE_FORWARD */
;
;
;
;#if !FF_FS_READONLY && FF_USE_MKFS
;/*-----------------------------------------------------------------------*/
;/* API: Create FAT/exFAT volume (with a sub-function)                    */
;/*-----------------------------------------------------------------------*/
;
;#define N_SEC_TRACK 63			/* Sectors per track for determination of drive CHS */
;#define	GPT_ALIGN	0x100000	/* Alignment of partitions in GPT [byte] (>=128KB) */
;#define GPT_ITEMS	128			/* Number of GPT table items (>=128, sector aligned) */
;
;
;/* Create partitions on the physical drive in format of MBR or GPT */
;
;static FRESULT create_partition (
;	BYTE drv,			/* Physical drive number */
;	const LBA_t plst[],	/* Partition list */
;	BYTE sys,			/* System ID for each partition (for only MBR) */
;	BYTE *buf			/* Working buffer for a sector */
;)
;{
	code
	func
_~create_partition:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1019
	tcs
	phd
	tcd
drv_0	set	3
plst_0	set	5
sys_0	set	9
buf_0	set	11
;	UINT i, cy;
;	LBA_t sz_drv;
;	DWORD sz_drv32, nxt_alloc32, sz_part32;
;	BYTE *pte;
;	BYTE hd, n_hd, sc, n_sc;
;
;	/* Get physical drive size */
;	if (disk_ioctl(drv, GET_SECTOR_COUNT, &sz_drv) != RES_OK) return FR_DISK_ERR;
i_1	set	0
cy_1	set	2
sz_drv_1	set	4
sz_drv32_1	set	8
nxt_alloc32_1	set	12
sz_part32_1	set	16
pte_1	set	20
hd_1	set	24
n_hd_1	set	25
sc_1	set	26
n_sc_1	set	27
	pea	#0
	clc
	tdc
	adc	#<L1020+sz_drv_1
	pha
	pea	#<$1
	pei	<L1019+drv_0
	jsr	_~disk_ioctl
	tax
	beq	L10608
L20212:
	lda	#$1
L1022:
	tay
	lda	<L1019+1
	sta	<L1019+1+12
	pld
	tsc
	clc
	adc	#L1019+12
	tcs
	tya
	rts
;
;#if FF_LBA64
;	if (sz_drv >= FF_MIN_GPT) {	/* Create partitions in GPT format */
;		WORD ss;
;		UINT sz_ptbl, pi, si, ofs;
;		DWORD bcc, rnd, align;
;		QWORD nxt_alloc, sz_part, sz_pool, top_bpt;
;		static const BYTE gpt_mbr[16] = {0x00, 0x00, 0x02, 0x00, 0xEE, 0xFE, 0xFF, 0x00, 0x01, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF};
;
;#if FF_MAX_SS != FF_MIN_SS
;		if (disk_ioctl(drv, GET_SECTOR_SIZE, &ss) != RES_OK) return FR_DISK_ERR;	/* Get sector size */
;		if (ss > FF_MAX_SS || ss < FF_MIN_SS || (ss & (ss - 1))) return FR_DISK_ERR;
;#else
;		ss = FF_MAX_SS;
;#endif
;		rnd = (DWORD)sz_drv + GET_FATTIME();	/* Random seed */
;		align = GPT_ALIGN / ss;				/* Partition alignment for GPT [sector] */
;		sz_ptbl = GPT_ITEMS * SZ_GPTE / ss;	/* Size of partition table [sector] */
;		top_bpt = sz_drv - sz_ptbl - 1;		/* Backup partition table start LBA */
;		nxt_alloc = 2 + sz_ptbl;			/* First allocatable LBA */
;		sz_pool = top_bpt - nxt_alloc;		/* Size of allocatable area [sector] */
;		bcc = 0xFFFFFFFF; sz_part = 1;
;		pi = si = 0;	/* partition table index, map index */
;		do {
;			if (pi * SZ_GPTE % ss == 0) memset(buf, 0, ss);	/* Clean the buffer if needed */
;			if (sz_part != 0) {				/* Is the size table not termintated? */
;				nxt_alloc = (nxt_alloc + align - 1) & ((QWORD)0 - align);	/* Align partition start LBA */
;				sz_part = plst[si++];		/* Get a partition size */
;				if (sz_part <= 100) {		/* Is the size in percentage? */
;					sz_part = sz_pool * sz_part / 100;	/* Sectors in percentage */
;					sz_part = (sz_part + align - 1) & ((QWORD)0 - align);	/* Align partition end LBA (only if in percentage) */
;				}
;				if (nxt_alloc + sz_part > top_bpt) {	/* Clip the size at end of the pool */
;					sz_part = (nxt_alloc < top_bpt) ? top_bpt - nxt_alloc : 0;
;				}
;			}
;			if (sz_part != 0) {				/* Add a partition? */
;				ofs = pi * SZ_GPTE % ss;
;				memcpy(buf + ofs + GPTE_PtGuid, GUID_MS_Basic, 16);	/* Set partition GUID (Microsoft Basic Data) */
;				rnd = make_rand(rnd, buf + ofs + GPTE_UpGuid, 16);	/* Set unique partition GUID */
;				st_64(buf + ofs + GPTE_FstLba, nxt_alloc);			/* Set partition start LBA */
;				st_64(buf + ofs + GPTE_LstLba, nxt_alloc + sz_part - 1);	/* Set partition end LBA */
;				nxt_alloc += sz_part;								/* Next allocatable LBA */
;			}
;			if ((pi + 1) * SZ_GPTE % ss == 0) {		/* Write the sector buffer if it is filled up */
;				for (i = 0; i < ss; bcc = crc32(bcc, buf[i++])) ;	/* Calculate table check sum */
;				if (disk_write(drv, buf, 2 + pi * SZ_GPTE / ss, 1) != RES_OK) return FR_DISK_ERR;		/* Write to primary table */
;				if (disk_write(drv, buf, top_bpt + pi * SZ_GPTE / ss, 1) != RES_OK) return FR_DISK_ERR;	/* Write to secondary table */
;			}
;		} while (++pi < GPT_ITEMS);
;
;		/* Create primary GPT header */
;		memset(buf, 0, ss);
;		memcpy(buf + GPTH_Sign, "EFI PART" "\0\0\1\0" "\x5C\0\0", 16);	/* Signature, version (1.0) and size (92) */
;		st_32(buf + GPTH_PtBcc, ~bcc);			/* Table check sum */
;		st_64(buf + GPTH_CurLba, 1);			/* LBA of this header */
;		st_64(buf + GPTH_BakLba, sz_drv - 1);	/* LBA of secondary header */
;		st_64(buf + GPTH_FstLba, 2 + sz_ptbl);	/* LBA of first allocatable sector */
;		st_64(buf + GPTH_LstLba, top_bpt - 1);	/* LBA of last allocatable sector */
;		st_32(buf + GPTH_PteSize, SZ_GPTE);		/* Size of a table entry */
;		st_32(buf + GPTH_PtNum, GPT_ITEMS);		/* Number of table entries */
;		st_32(buf + GPTH_PtOfs, 2);				/* LBA of this table */
;		rnd = make_rand(rnd, buf + GPTH_DskGuid, 16);	/* Disk GUID */
;		for (i = 0, bcc= 0xFFFFFFFF; i < 92; bcc = crc32(bcc, buf[i++])) ;	/* Calculate header check sum */
;		st_32(buf + GPTH_Bcc, ~bcc);			/* Header check sum */
;		if (disk_write(drv, buf, 1, 1) != RES_OK) return FR_DISK_ERR;
;
;		/* Create secondary GPT header */
;		st_64(buf + GPTH_CurLba, sz_drv - 1);	/* LBA of this header */
;		st_64(buf + GPTH_BakLba, 1);		 	/* LBA of primary header */
;		st_64(buf + GPTH_PtOfs, top_bpt);		/* LBA of this table */
;		st_32(buf + GPTH_Bcc, 0);
;		for (i = 0, bcc= 0xFFFFFFFF; i < 92; bcc = crc32(bcc, buf[i++])) ;	/* Calculate header check sum */
;		st_32(buf + GPTH_Bcc, ~bcc);			/* Header check sum */
;		if (disk_write(drv, buf, sz_drv - 1, 1) != RES_OK) return FR_DISK_ERR;
;
;		/* Create protective MBR */
;		memset(buf, 0, ss);
;		memcpy(buf + MBR_Table, gpt_mbr, 16);	/* Create a GPT partition */
;		st_16(buf + BS_55AA, 0xAA55);
;		if (disk_write(drv, buf, 0, 1) != RES_OK) return FR_DISK_ERR;
;
;	} else
;#endif
;	{	/* Create partitions in MBR format */
L10608:
;		sz_drv32 = (DWORD)sz_drv;
	lda	<L1020+sz_drv_1
	sta	<L1020+sz_drv32_1
	lda	<L1020+sz_drv_1+2
	sta	<L1020+sz_drv32_1+2
;		n_sc = N_SEC_TRACK;				/* Determine drive CHS without any consideration of the drive geometry */
	sep	#$20
	longa	off
	lda	#$3f
	sta	<L1020+n_sc_1
;		for (n_hd = 8; n_hd != 0 && sz_drv32 / n_hd / n_sc > 1024; n_hd *= 2) ;
	lda	#$8
	sta	<L1020+n_hd_1
	rep	#$20
	longa	on
	bra	L10612
L10609:
	sep	#$20
	longa	off
	asl	<L1020+n_hd_1
	rep	#$20
	longa	on
L10612:
	lda	<L1020+n_hd_1
	and	#$ff
	beq	L10610
	lda	<L1020+n_sc_1
	and	#$ff
	sta	<R0
	stz	<R0+2
	lda	<L1020+n_hd_1
	and	#$ff
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<L1020+sz_drv32_1+2
	pei	<L1020+sz_drv32_1
	xref	_~~ludv
	jsr	_~~ludv
	sta	<R1
	stx	<R1+2
	pei	<R0+2
	pei	<R0
	pei	<R1+2
	pei	<R1
	xref	_~~ludv
	jsr	_~~ludv
	sta	<R0
	stx	<R0+2
	lda	#$400
	cmp	<R0
	lda	#$0
	sbc	<R0+2
	bcc	L10609
L10610:
;		if (n_hd == 0) n_hd = 255;		/* Number of heads needs to be <256 */
	lda	<L1020+n_hd_1
	and	#$ff
	bne	L10613
	sep	#$20
	longa	off
	lda	#$ff
	sta	<L1020+n_hd_1
	rep	#$20
	longa	on
;
;		memset(buf, 0, FF_MAX_SS);		/* Clear MBR */
L10613:
	pea	#<$200
	pea	#<$0
	pei	<L1019+buf_0+2
	pei	<L1019+buf_0
	jsr	_~memset
;		pte = buf + MBR_Table;	/* Partition table in the MBR */
	lda	#$1be
	clc
	adc	<L1019+buf_0
	sta	<L1020+pte_1
	lda	#$0
	adc	<L1019+buf_0+2
	sta	<L1020+pte_1+2
;		for (i = 0, nxt_alloc32 = n_sc; i < 4 && nxt_alloc32 != 0 && nxt_alloc32 < sz_drv32; i++, nxt_alloc32 += sz_part32) {
	stz	<L1020+i_1
	lda	<L1020+n_sc_1
	and	#$ff
	sta	<L1020+nxt_alloc32_1
	stz	<L1020+nxt_alloc32_1+2
	brl	L10617
L10616:
;			sz_part32 = (DWORD)plst[i];	/* Get partition size */
	lda	<L1020+i_1
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L1019+plst_0
	clc
	adc	<R0
	sta	<R2
	lda	<L1019+plst_0+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	sta	<L1020+sz_part32_1
	ldy	#$2
	lda	[<R2],Y
	sta	<L1020+sz_part32_1+2
;			if (sz_part32 <= 100) sz_part32 = (sz_part32 == 100) ? sz_drv32 : sz_drv32 / 100 * sz_part32;	/* Size in percentage? */
	lda	#$64
	cmp	<L1020+sz_part32_1
	lda	#$0
	sbc	<L1020+sz_part32_1+2
	bcc	L10618
	lda	<L1020+sz_part32_1
	cmp	#<$64
	bne	L1029
	lda	<L1020+sz_part32_1+2
	cmp	#^$64
L1029:
	bne	L1028
	ldx	<L1020+sz_drv32_1+2
	lda	<L1020+sz_drv32_1
	bra	L1031
L1028:
	pea	#^$64
	pea	#<$64
	pei	<L1020+sz_drv32_1+2
	pei	<L1020+sz_drv32_1
	xref	_~~ludv
	jsr	_~~ludv
	sta	<R0
	stx	<R0+2
	pei	<L1020+sz_part32_1+2
	pei	<L1020+sz_part32_1
	pei	<R0+2
	pei	<R0
	xref	_~~lmul
	jsr	_~~lmul
	sta	<R0
	stx	<R0+2
	ldx	<R0+2
	lda	<R0
L1031:
	stx	<R0+2
	sta	<L1020+sz_part32_1
	lda	<R0+2
	sta	<L1020+sz_part32_1+2
;			if (nxt_alloc32 + sz_part32 > sz_drv32 || nxt_alloc32 + sz_part32 < nxt_alloc32) sz_part32 = sz_drv32 - nxt_alloc32;	/* Clip at drive size */
L10618:
	lda	<L1020+nxt_alloc32_1
	clc
	adc	<L1020+sz_part32_1
	sta	<R0
	lda	<L1020+nxt_alloc32_1+2
	adc	<L1020+sz_part32_1+2
	sta	<R0+2
	lda	<L1020+sz_drv32_1
	cmp	<R0
	lda	<L1020+sz_drv32_1+2
	sbc	<R0+2
	bcc	L1032
	lda	<L1020+nxt_alloc32_1
	clc
	adc	<L1020+sz_part32_1
	sta	<R0
	lda	<L1020+nxt_alloc32_1+2
	adc	<L1020+sz_part32_1+2
	sta	<R0+2
	lda	<R0
	cmp	<L1020+nxt_alloc32_1
	lda	<R0+2
	sbc	<L1020+nxt_alloc32_1+2
	bcs	L10619
L1032:
	sec
	lda	<L1020+sz_drv32_1
	sbc	<L1020+nxt_alloc32_1
	sta	<L1020+sz_part32_1
	lda	<L1020+sz_drv32_1+2
	sbc	<L1020+nxt_alloc32_1+2
	sta	<L1020+sz_part32_1+2
;			if (sz_part32 == 0) break;	/* End of table or no sector to allocate? */
L10619:
	lda	<L1020+sz_part32_1
	ora	<L1020+sz_part32_1+2
	bne	*+5
	brl	L10615
;
;			st_32(pte + PTE_StLba, nxt_alloc32);	/* Partition start LBA sector */
	pei	<L1020+nxt_alloc32_1+2
	pei	<L1020+nxt_alloc32_1
	lda	#$8
	clc
	adc	<L1020+pte_1
	sta	<R0
	lda	#$0
	adc	<L1020+pte_1+2
	pha
	pei	<R0
	jsr	_~st_32
;			st_32(pte + PTE_SizLba, sz_part32);		/* Size of partition [sector] */
	pei	<L1020+sz_part32_1+2
	pei	<L1020+sz_part32_1
	lda	#$c
	clc
	adc	<L1020+pte_1
	sta	<R0
	lda	#$0
	adc	<L1020+pte_1+2
	sta	<R0+2
	pha
	pei	<R0
	jsr	_~st_32
;			pte[PTE_System] = sys;					/* System type */
	sep	#$20
	longa	off
	lda	<L1019+sys_0
	ldy	#$4
	sta	[<L1020+pte_1],Y
	rep	#$20
	longa	on
;
;			cy = (UINT)(nxt_alloc32 / n_sc / n_hd);	/* Partitio start CHS cylinder */
	lda	<L1020+n_hd_1
	and	#$ff
	sta	<R0
	stz	<R0+2
	lda	<L1020+n_sc_1
	and	#$ff
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<L1020+nxt_alloc32_1+2
	pei	<L1020+nxt_alloc32_1
	xref	_~~ludv
	jsr	_~~ludv
	sta	<R1
	stx	<R1+2
	pei	<R0+2
	pei	<R0
	pei	<R1+2
	pei	<R1
	xref	_~~ludv
	jsr	_~~ludv
	stx	<R0+2
	sta	<L1020+cy_1
;			hd = (BYTE)(nxt_alloc32 / n_sc % n_hd);	/* Partition start CHS head */
	lda	<L1020+n_hd_1
	and	#$ff
	sta	<R0
	stz	<R0+2
	lda	<L1020+n_sc_1
	and	#$ff
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<L1020+nxt_alloc32_1+2
	pei	<L1020+nxt_alloc32_1
	xref	_~~ludv
	jsr	_~~ludv
	sta	<R1
	stx	<R1+2
	pei	<R0+2
	pei	<R0
	pei	<R1+2
	pei	<R1
	xref	_~~lumd
	jsr	_~~lumd
	sta	<R0
	stx	<R0+2
	sep	#$20
	longa	off
	lda	<R0
	sta	<L1020+hd_1
	rep	#$20
	longa	on
;			sc = (BYTE)(nxt_alloc32 % n_sc + 1);	/* Partition start CHS sector */
	lda	<L1020+n_sc_1
	and	#$ff
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L1020+nxt_alloc32_1+2
	pei	<L1020+nxt_alloc32_1
	xref	_~~lumd
	jsr	_~~lumd
	sta	<R0
	stx	<R0+2
	lda	#$1
	clc
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	<R1
	sta	<L1020+sc_1
;			pte[PTE_StHead] = hd;
	lda	<L1020+hd_1
	ldy	#$1
	sta	[<L1020+pte_1],Y
	rep	#$20
	longa	on
;			pte[PTE_StSec] = (BYTE)((cy >> 2 & 0xC0) | sc);
	lda	<L1020+cy_1
	lsr	A
	lsr	A
	and	#<$c0
	sta	<R0
	lda	<L1020+sc_1
	and	#$ff
	ora	<R0
	sep	#$20
	longa	off
	iny
	sta	[<L1020+pte_1],Y
;			pte[PTE_StCyl] = (BYTE)cy;
	lda	<L1020+cy_1
	iny
	sta	[<L1020+pte_1],Y
	rep	#$20
	longa	on
;
;			cy = (UINT)((nxt_alloc32 + sz_part32 - 1) / n_sc / n_hd);	/* Partition end CHS cylinder */
	lda	<L1020+n_hd_1
	and	#$ff
	sta	<R0
	stz	<R0+2
	lda	<L1020+n_sc_1
	and	#$ff
	sta	<R1
	stz	<R1+2
	lda	<L1020+nxt_alloc32_1
	clc
	adc	<L1020+sz_part32_1
	sta	<R2
	lda	<L1020+nxt_alloc32_1+2
	adc	<L1020+sz_part32_1+2
	sta	<R2+2
	lda	#$ffff
	clc
	adc	<R2
	sta	<R3
	lda	#$ffff
	adc	<R2+2
	sta	<R3+2
	pei	<R1+2
	pei	<R1
	pei	<R3+2
	pei	<R3
	xref	_~~ludv
	jsr	_~~ludv
	sta	<R1
	stx	<R1+2
	pei	<R0+2
	pei	<R0
	pei	<R1+2
	pei	<R1
	xref	_~~ludv
	jsr	_~~ludv
	stx	<R0+2
	sta	<L1020+cy_1
;			hd = (BYTE)((nxt_alloc32 + sz_part32 - 1) / n_sc % n_hd);	/* Partition end CHS head */
	lda	<L1020+n_hd_1
	and	#$ff
	sta	<R0
	stz	<R0+2
	lda	<L1020+n_sc_1
	and	#$ff
	sta	<R1
	stz	<R1+2
	lda	<L1020+nxt_alloc32_1
	clc
	adc	<L1020+sz_part32_1
	sta	<R2
	lda	<L1020+nxt_alloc32_1+2
	adc	<L1020+sz_part32_1+2
	sta	<R2+2
	lda	#$ffff
	clc
	adc	<R2
	sta	<R3
	lda	#$ffff
	adc	<R2+2
	sta	<R3+2
	pei	<R1+2
	pei	<R1
	pei	<R3+2
	pei	<R3
	xref	_~~ludv
	jsr	_~~ludv
	sta	<R1
	stx	<R1+2
	pei	<R0+2
	pei	<R0
	pei	<R1+2
	pei	<R1
	xref	_~~lumd
	jsr	_~~lumd
	sta	<R0
	stx	<R0+2
	sep	#$20
	longa	off
	lda	<R0
	sta	<L1020+hd_1
	rep	#$20
	longa	on
;			sc = (BYTE)((nxt_alloc32 + sz_part32 - 1) % n_sc + 1);		/* Partition end CHS sector */
	lda	<L1020+n_sc_1
	and	#$ff
	sta	<R0
	stz	<R0+2
	lda	<L1020+nxt_alloc32_1
	clc
	adc	<L1020+sz_part32_1
	sta	<R1
	lda	<L1020+nxt_alloc32_1+2
	adc	<L1020+sz_part32_1+2
	sta	<R1+2
	lda	#$ffff
	clc
	adc	<R1
	sta	<R2
	lda	#$ffff
	adc	<R1+2
	sta	<R2+2
	pei	<R0+2
	pei	<R0
	pei	<R2+2
	pei	<R2
	xref	_~~lumd
	jsr	_~~lumd
	sta	<R0
	stx	<R0+2
	lda	#$1
	clc
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	<R1
	sta	<L1020+sc_1
;			pte[PTE_EdHead] = hd;
	lda	<L1020+hd_1
	ldy	#$5
	sta	[<L1020+pte_1],Y
	rep	#$20
	longa	on
;			pte[PTE_EdSec] = (BYTE)((cy >> 2 & 0xC0) | sc);
	lda	<L1020+cy_1
	lsr	A
	lsr	A
	and	#<$c0
	sta	<R0
	lda	<L1020+sc_1
	and	#$ff
	ora	<R0
	sep	#$20
	longa	off
	iny
	sta	[<L1020+pte_1],Y
;			pte[PTE_EdCyl] = (BYTE)cy;
	lda	<L1020+cy_1
	iny
	sta	[<L1020+pte_1],Y
	rep	#$20
	longa	on
;
;			pte += SZ_PTE;		/* Next entry */
	lda	#$10
	clc
	adc	<L1020+pte_1
	sta	<L1020+pte_1
	bcc	L10614
	inc	<L1020+pte_1+2
;		}
L10614:
	lda	<L1020+nxt_alloc32_1
	clc
	adc	<L1020+sz_part32_1
	sta	<L1020+nxt_alloc32_1
	lda	<L1020+nxt_alloc32_1+2
	adc	<L1020+sz_part32_1+2
	sta	<L1020+nxt_alloc32_1+2
	inc	<L1020+i_1
L10617:
	lda	<L1020+i_1
	cmp	#<$4
	bcs	L10615
	lda	<L1020+nxt_alloc32_1
	ora	<L1020+nxt_alloc32_1+2
	beq	L10615
	lda	<L1020+nxt_alloc32_1
	cmp	<L1020+sz_drv32_1
	lda	<L1020+nxt_alloc32_1+2
	sbc	<L1020+sz_drv32_1+2
	bcs	*+5
	brl	L10616
L10615:
;
;		st_16(buf + BS_55AA, 0xAA55);		/* MBR signature */
	pea	#<$aa55
	lda	#$1fe
	clc
	adc	<L1019+buf_0
	sta	<R0
	lda	#$0
	adc	<L1019+buf_0+2
	pha
	pei	<R0
	jsr	_~st_16
;		if (disk_write(drv, buf, 0, 1) != RES_OK) return FR_DISK_ERR;	/* Write it to the MBR */
	pea	#<$1
	pea	#^$0
	pea	#<$0
	pei	<L1019+buf_0+2
	pei	<L1019+buf_0
	pei	<L1019+drv_0
	jsr	_~disk_write
	tax
	beq	*+5
	brl	L20212
;	}
;
;	return FR_OK;
	lda	#$0
	brl	L1022
;}
L1019	equ	44
L1020	equ	17
	ends
	efunc
;
;
;
;FRESULT f_mkfs (
;	const TCHAR* path,		/* Logical drive number */
;	const MKFS_PARM* opt,	/* Format options */
;	void* work,				/* Pointer to working buffer (null: use len bytes of heap memory) */
;	UINT len				/* Size of working buffer [byte] */
;)
;{
	code
	xdef	_~f_mkfs
	func
_~f_mkfs:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1042
	tcs
	phd
	tcd
path_0	set	3
opt_0	set	7
work_0	set	11
len_0	set	15
;	static const WORD cst[] = {1, 4, 16, 64, 256, 512, 0};	/* Cluster size boundary for FAT volume (4K sector unit) */
;	static const WORD cst32[] = {1, 2, 4, 8, 16, 32, 0};	/* Cluster size boundary for FAT32 volume (128K sector unit) */
;	static const MKFS_PARM defopt = {FM_ANY, 0, 0, 0, 0};	/* Default parameter */
;	BYTE fsopt, fsty, sys, pdrv, ipart;
;	BYTE *buf;
;	BYTE *pte;
;	WORD ss;	/* Sector size */
;	DWORD sz_buf, sz_blk, n_clst, pau, nsect, n, vsn;
;	LBA_t sz_vol, b_vol, b_fat, b_data;		/* Volume size, base LBA of volume, base LBA of FAT and base LBA of data */
;	LBA_t sect, lba[2];
;	DWORD sz_rsv, sz_fat, sz_dir, sz_au;	/* Size of reserved area, FAT area, directry area, data area and cluster */
;	UINT n_fat, n_root, i;					/* Number of FATs, number of roor directory entries and some index */
;	int vol;
;	DSTATUS ds;
;	FRESULT res;
;
;
;	/* Check mounted drive and clear work area */
;	vol = get_ldnumber(&path);					/* Get logical drive number to be formatted */
fsopt_1	set	0
fsty_1	set	1
sys_1	set	2
pdrv_1	set	3
ipart_1	set	4
buf_1	set	5
pte_1	set	9
ss_1	set	13
sz_buf_1	set	15
sz_blk_1	set	19
n_clst_1	set	23
pau_1	set	27
nsect_1	set	31
n_1	set	35
vsn_1	set	39
sz_vol_1	set	43
b_vol_1	set	47
b_fat_1	set	51
b_data_1	set	55
sect_1	set	59
lba_1	set	63
sz_rsv_1	set	71
sz_fat_1	set	75
sz_dir_1	set	79
sz_au_1	set	83
n_fat_1	set	87
n_root_1	set	89
i_1	set	91
vol_1	set	93
ds_1	set	95
res_1	set	96
	pea	#0
	clc
	tdc
	adc	#<L1042+path_0
	pha
	jsr	_~get_ldnumber
	sta	<L1043+vol_1
;	if (vol < 0) return FR_INVALID_DRIVE;
	lda	<L1043+vol_1
	bpl	L10621
	lda	#$b
L1048:
	tay
	lda	<L1042+1
	sta	<L1042+1+14
	pld
	tsc
	clc
	adc	#L1042+14
	tcs
	tya
	rts
;	if (FatFs[vol]) FatFs[vol]->fs_type = 0;	/* Clear the fs object if mounted */
L10621:
	lda	<L1043+vol_1
	asl	A
	asl	A
	clc
	adc	#<_~FatFs
	sta	<R1
	lda	(<R1)
	ldy	#$2
	ora	(<R1),Y
	beq	L10622
	lda	<L1043+vol_1
	asl	A
	asl	A
	clc
	adc	#<_~FatFs
	sta	<R1
	lda	(<R1)
	sta	<R0
	lda	(<R1),Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$0
	sta	[<R0]
	rep	#$20
	longa	on
;	pdrv = LD2PD(vol);		/* Hosting physical drive */
L10622:
	sep	#$20
	longa	off
	lda	<L1043+vol_1
	sta	<L1043+pdrv_1
;	ipart = LD2PT(vol);		/* Hosting partition (0:create as new, 1..:existing partition) */
	stz	<L1043+ipart_1
	rep	#$20
	longa	on
;
;	/* Initialize the hosting physical drive */
;	ds = disk_initialize(pdrv);
	pei	<L1043+pdrv_1
	jsr	_~disk_initialize
	sep	#$20
	longa	off
	sta	<L1043+ds_1
;	if (ds & STA_NOINIT) return FR_NOT_READY;
	and	#<$1
	rep	#$20
	longa	on
	beq	L10623
	lda	#$3
	bra	L1048
;	if (ds & STA_PROTECT) return FR_WRITE_PROTECTED;
L10623:
	sep	#$20
	longa	off
	lda	<L1043+ds_1
	and	#<$4
	rep	#$20
	longa	on
	beq	L10624
	lda	#$a
	bra	L1048
;
;	/* Get physical drive parameters (sz_drv, sz_blk and ss) */
;	if (!opt) opt = &defopt;	/* Use default parameter if it is not given */
L10624:
	lda	<L1042+opt_0
	ora	<L1042+opt_0+2
	bne	L10625
	lda	#<L1046
	sta	<L1042+opt_0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L1042+opt_0+2
;	sz_blk = opt->align;
L10625:
	ldy	#$2
	lda	[<L1042+opt_0],Y
	sta	<L1043+sz_blk_1
	stz	<L1043+sz_blk_1+2
;	if (sz_blk == 0) disk_ioctl(pdrv, GET_BLOCK_SIZE, &sz_blk);					/* Block size from the parameter or lower layer */
	lda	<L1043+sz_blk_1
	ora	<L1043+sz_blk_1+2
	bne	L10626
	pea	#0
	clc
	tdc
	adc	#<L1043+sz_blk_1
	pha
	pea	#<$3
	pei	<L1043+pdrv_1
	jsr	_~disk_ioctl
; 	if (sz_blk == 0 || sz_blk > 0x8000 || (sz_blk & (sz_blk - 1))) sz_blk = 1;	/* Use default if the block size is invalid */
L10626:
	lda	<L1043+sz_blk_1
	ora	<L1043+sz_blk_1+2
	beq	L1054
	lda	#$8000
	cmp	<L1043+sz_blk_1
	lda	#$0
	sbc	<L1043+sz_blk_1+2
	bcc	L1054
	lda	#$ffff
	clc
	adc	<L1043+sz_blk_1
	sta	<R0
	lda	#$ffff
	adc	<L1043+sz_blk_1+2
	sta	<R0+2
	lda	<L1043+sz_blk_1
	and	<R0
	sta	<R1
	lda	<L1043+sz_blk_1+2
	and	<R0+2
	sta	<R1+2
	lda	<R1
	ora	<R1+2
	beq	L10627
L1054:
	lda	#$1
	sta	<L1043+sz_blk_1
	dea
	sta	<L1043+sz_blk_1+2
;#if FF_MAX_SS != FF_MIN_SS
;	if (disk_ioctl(pdrv, GET_SECTOR_SIZE, &ss) != RES_OK) return FR_DISK_ERR;
;	if (ss > FF_MAX_SS || ss < FF_MIN_SS || (ss & (ss - 1))) return FR_DISK_ERR;
;#else
;	ss = FF_MAX_SS;
L10627:
	lda	#$200
	sta	<L1043+ss_1
;#endif
;
;	/* Options for FAT sub-type and FAT parameters */
;	fsopt = opt->fmt & (FM_ANY | FM_SFD);
	sep	#$20
	longa	off
	lda	[<L1042+opt_0]
	and	#<$f
	sta	<L1043+fsopt_1
;	n_fat = (opt->n_fat >= 1 && opt->n_fat <= 2) ? opt->n_fat : 1;
	ldy	#$1
	lda	[<L1042+opt_0],Y
	cmp	#<$1
	rep	#$20
	longa	on
	bcc	L1058
	sep	#$20
	longa	off
	lda	#$2
	cmp	[<L1042+opt_0],Y
	rep	#$20
	longa	on
	bcc	L1058
	lda	[<L1042+opt_0],Y
	and	#$ff
	bra	L1061
L1058:
	lda	#$1
L1061:
	sta	<L1043+n_fat_1
;	n_root = (opt->n_root >= 1 && opt->n_root <= 32768 && (opt->n_root % (ss / SZDIRE)) == 0) ? opt->n_root : 512;
	ldy	#$4
	lda	[<L1042+opt_0],Y
	cmp	#<$1
	bcc	L1062
	lda	[<L1042+opt_0],Y
	sta	<R0
	stz	<R0+2
	sec
	lda	#$8000
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L1064
	eor	#$8000
L1064:
	bpl	L1062
	lda	<L1043+ss_1
	lsr	A
	lsr	A
	lsr	A
	lsr	A
	lsr	A
	sta	<R0
	ldy	#$4
	lda	[<L1042+opt_0],Y
	ldx	<R0
	xref	_~~umd
	jsr	_~~umd
	tax
	bne	L1062
	ldy	#$4
	lda	[<L1042+opt_0],Y
	bra	L1067
L1062:
	lda	#$200
L1067:
	sta	<L1043+n_root_1
;	sz_au = (opt->au_size <= 0x1000000 && (opt->au_size & (opt->au_size - 1)) == 0) ? opt->au_size : 0;
	lda	#$0
	ldy	#$6
	cmp	[<L1042+opt_0],Y
	lda	#$100
	iny
	iny
	sbc	[<L1042+opt_0],Y
	bcc	L1068
	clc
	lda	#$ffff
	dey
	dey
	adc	[<L1042+opt_0],Y
	sta	<R0
	lda	#$ffff
	iny
	iny
	adc	[<L1042+opt_0],Y
	sta	<R0+2
	dey
	dey
	lda	[<L1042+opt_0],Y
	and	<R0
	sta	<R1
	iny
	iny
	lda	[<L1042+opt_0],Y
	and	<R0+2
	sta	<R1+2
	lda	<R1
	ora	<R1+2
	bne	L1068
	lda	[<L1042+opt_0],Y
	tax
	dey
	dey
	lda	[<L1042+opt_0],Y
	bra	L1071
L1068:
	lda	#$0
	tax
L1071:
	stx	<R0+2
	sta	<L1043+sz_au_1
	lda	<R0+2
	sta	<L1043+sz_au_1+2
;	sz_au /= ss;	/* Byte --> Sector */
	lda	<L1043+ss_1
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L1043+sz_au_1+2
	pei	<L1043+sz_au_1
	xref	_~~ludv
	jsr	_~~ludv
	sta	<L1043+sz_au_1
	stx	<L1043+sz_au_1+2
;
;	/* Get working buffer */
;	sz_buf = len / ss;		/* Size of working buffer [sector] */
	lda	<L1042+len_0
	ldx	<L1043+ss_1
	xref	_~~udv
	jsr	_~~udv
	sta	<L1043+sz_buf_1
	stz	<L1043+sz_buf_1+2
;	if (sz_buf == 0) return FR_NOT_ENOUGH_CORE;
	lda	<L1043+sz_buf_1
	ora	<L1043+sz_buf_1+2
	bne	L10628
L20230:
	lda	#$11
	brl	L1048
;	buf = (BYTE*)work;		/* Working buffer */
L10628:
	lda	<L1042+work_0
	sta	<L1043+buf_1
	lda	<L1042+work_0+2
	sta	<L1043+buf_1+2
;#if FF_USE_LFN == 3
;	if (!buf) buf = ff_memalloc(sz_buf * ss);	/* Use heap memory for working buffer */
;#endif
;	if (!buf) return FR_NOT_ENOUGH_CORE;
	lda	<L1043+buf_1
	ora	<L1043+buf_1+2
	beq	L20230
;
;	/* Determine where the volume to be located (b_vol, sz_vol) */
;	b_vol = sz_vol = 0;
	stz	<L1043+sz_vol_1
	stz	<L1043+sz_vol_1+2
	stz	<L1043+b_vol_1
	stz	<L1043+b_vol_1+2
;	if (FF_MULTI_PARTITION && ipart != 0) {	/* Is the volume associated with any specific partition? */
;		/* Get partition location from the existing partition table */
;		if (disk_read(pdrv, buf, 0, 1) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);	/* Load MBR */
;		if (ld_16(buf + BS_55AA) != 0xAA55) LEAVE_MKFS(FR_MKFS_ABORTED);	/* Check if MBR is valid */
;#if FF_LBA64
;		if (buf[MBR_Table + PTE_System] == 0xEE) {	/* GPT protective MBR? */
;			DWORD n_ent, ofs;
;			QWORD pt_lba;
;
;			/* Get the partition location from GPT */
;			if (disk_read(pdrv, buf, 1, 1) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);	/* Load GPT header sector (next to MBR) */
;			if (!test_gpt_header(buf)) LEAVE_MKFS(FR_MKFS_ABORTED);	/* Check if GPT header is valid */
;			n_ent = ld_32(buf + GPTH_PtNum);	/* Number of entries */
;			pt_lba = ld_64(buf + GPTH_PtOfs);	/* Table start sector */
;			ofs = i = 0;
;			while (n_ent) {		/* Find MS Basic partition with order of ipart */
;				if (ofs == 0 && disk_read(pdrv, buf, pt_lba++, 1) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);	/* Get PT sector */
;				if (!memcmp(buf + ofs + GPTE_PtGuid, GUID_MS_Basic, 16) && ++i == ipart) {	/* MS basic data partition? */
;					b_vol = ld_64(buf + ofs + GPTE_FstLba);
;					sz_vol = ld_64(buf + ofs + GPTE_LstLba) - b_vol + 1;
;					break;
;				}
;				n_ent--; ofs = (ofs + SZ_GPTE) % ss;	/* Next entry */
;			}
;			if (n_ent == 0) LEAVE_MKFS(FR_MKFS_ABORTED);	/* Partition not found */
;			fsopt |= 0x80;	/* Partitioning is in GPT */
;		} else
;#endif
;		{	/* Get the partition location from MBR partition table */
;			pte = buf + (MBR_Table + (ipart - 1) * SZ_PTE);
;			if (ipart > 4 || pte[PTE_System] == 0) LEAVE_MKFS(FR_MKFS_ABORTED);	/* No partition? */
;			b_vol = ld_32(pte + PTE_StLba);		/* Get volume start sector */
;			sz_vol = ld_32(pte + PTE_SizLba);	/* Get volume size */
;		}
;	} else {	/* The volume is associated with a physical drive */
;		if (disk_ioctl(pdrv, GET_SECTOR_COUNT, &sz_vol) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);
	pea	#0
	clc
	tdc
	adc	#<L1043+sz_vol_1
	pha
	pea	#<$1
	pei	<L1043+pdrv_1
	jsr	_~disk_ioctl
	tax
	beq	L10635
L20231:
	lda	#$1
	brl	L1048
;		if (!(fsopt & FM_SFD)) {	/* To be partitioned? */
L10635:
	sep	#$20
	longa	off
	lda	<L1043+fsopt_1
	and	#<$8
	rep	#$20
	longa	on
	bne	L10634
;			/* Create a single-partition on the drive in this function */
;#if FF_LBA64
;			if (sz_vol >= FF_MIN_GPT) {	/* Which partition type to create, MBR or GPT? */
;				fsopt |= 0x80;		/* Partitioning is in GPT */
;				b_vol = GPT_ALIGN / ss; sz_vol -= b_vol + GPT_ITEMS * SZ_GPTE / ss + 1;	/* Estimated partition offset and size */
;			} else
;#endif
;			{	/* Partitioning is in MBR */
;				if (sz_vol > N_SEC_TRACK) {
	lda	#$3f
	cmp	<L1043+sz_vol_1
	lda	#$0
	sbc	<L1043+sz_vol_1+2
	bcs	L10634
;					b_vol = N_SEC_TRACK; sz_vol -= b_vol;	/* Estimated partition offset and size */
	lda	#$3f
	sta	<L1043+b_vol_1
	lda	#$0
	sta	<L1043+b_vol_1+2
	sec
	lda	<L1043+sz_vol_1
	sbc	<L1043+b_vol_1
	sta	<L1043+sz_vol_1
	lda	<L1043+sz_vol_1+2
	sbc	<L1043+b_vol_1+2
	sta	<L1043+sz_vol_1+2
;				}
;			}
;		}
;	}
L10634:
;	if (sz_vol < 128) LEAVE_MKFS(FR_MKFS_ABORTED);	/* Check if volume size is >=128 sectors */
	lda	<L1043+sz_vol_1
	cmp	#<$80
	lda	<L1043+sz_vol_1+2
	sbc	#^$80
	bcs	L10641
L20232:
	lda	#$e
	brl	L1048
;
;	/* Now start to create an FAT volume at b_vol and sz_vol */
;
;	do {	/* Pre-determine the FAT type */
L10641:
;		if (FF_FS_EXFAT && (fsopt & FM_EXFAT)) {	/* exFAT possible? */
;			if ((fsopt & FM_ANY) == FM_EXFAT || sz_vol >= 0x4000000 || sz_au > 128) {	/* exFAT only, vol >= 64M sectors or sz_au > 128 sectors? */
;				fsty = FS_EXFAT; break;
;			}
;		}
;#if FF_LBA64
;		if (sz_vol >= 0x100000000) LEAVE_MKFS(FR_MKFS_ABORTED);	/* Too large volume for FAT/FAT32 */
;#endif
;		if (sz_au > 128) sz_au = 128;	/* Invalid AU for FAT/FAT32? */
	lda	#$80
	cmp	<L1043+sz_au_1
	lda	#$0
	sbc	<L1043+sz_au_1+2
	bcs	L10644
	lda	#$80
	sta	<L1043+sz_au_1
	lda	#$0
	sta	<L1043+sz_au_1+2
;		if (fsopt & FM_FAT32) {	/* FAT32 possible? */
L10644:
	sep	#$20
	longa	off
	lda	<L1043+fsopt_1
	and	#<$2
	rep	#$20
	longa	on
	beq	L10645
;			if (!(fsopt & FM_FAT)) {	/* no-FAT? */
	sep	#$20
	longa	off
	lda	<L1043+fsopt_1
	and	#<$1
	rep	#$20
	longa	on
	bne	L10645
;				fsty = FS_FAT32; break;
	sep	#$20
	longa	off
	lda	#$3
	sta	<L1043+fsty_1
	rep	#$20
	longa	on
	bra	L10640
;			}
;		}
;		if (!(fsopt & FM_FAT)) LEAVE_MKFS(FR_INVALID_PARAMETER);	/* no-FAT? */
L10645:
	sep	#$20
	longa	off
	lda	<L1043+fsopt_1
	and	#<$1
	rep	#$20
	longa	on
	bne	L10647
	lda	#$13
	brl	L1048
;		fsty = FS_FAT16;
L10647:
	sep	#$20
	longa	off
	lda	#$2
	sta	<L1043+fsty_1
	rep	#$20
	longa	on
;	} while (0);
L10640:
;
;	vsn = (DWORD)sz_vol + GET_FATTIME();	/* VSN generated from current time and partition size */
	lda	#$0
	clc
	adc	<L1043+sz_vol_1
	sta	<L1043+vsn_1
	lda	#$5a21
	adc	<L1043+sz_vol_1+2
	sta	<L1043+vsn_1+2
;
;#if FF_FS_EXFAT
;	if (fsty == FS_EXFAT) {	/* Create an exFAT volume */
;		DWORD szb_bit, szb_case, sum, nbit, clu, clen[3];
;		WCHAR ch, si;
;		UINT j, st;
;
;		if (sz_vol < 0x1000) LEAVE_MKFS(FR_MKFS_ABORTED);	/* Too small volume for exFAT? */
;#if FF_USE_TRIM
;		lba[0] = b_vol; lba[1] = b_vol + sz_vol - 1;	/* Inform storage device that the volume area may be erased */
;		disk_ioctl(pdrv, CTRL_TRIM, lba);
;#endif
;		/* Determine FAT location, data location and number of clusters */
;		if (sz_au == 0) {	/* AU auto-selection */
;			sz_au = 8;
;			if (sz_vol >= 0x80000) sz_au = 64;		/* >= 512Ks */
;			if (sz_vol >= 0x4000000) sz_au = 256;	/* >= 64Ms */
;		}
;		b_fat = b_vol + 32;										/* FAT start at offset 32 */
;		sz_fat = (DWORD)((sz_vol / sz_au + 2) * 4 + ss - 1) / ss;	/* Number of FAT sectors */
;		b_data = (b_fat + sz_fat + sz_blk - 1) & ~((LBA_t)sz_blk - 1);	/* Align data area to the erase block boundary */
;		if (b_data - b_vol >= sz_vol / 2) LEAVE_MKFS(FR_MKFS_ABORTED);	/* Too small volume? */
;		n_clst = (DWORD)((sz_vol - (b_data - b_vol)) / sz_au);	/* Number of clusters */
;		if (n_clst <16) LEAVE_MKFS(FR_MKFS_ABORTED);			/* Too few clusters? */
;		if (n_clst > MAX_EXFAT) LEAVE_MKFS(FR_MKFS_ABORTED);	/* Too many clusters? */
;
;		szb_bit = (n_clst + 7) / 8;								/* Size of allocation bitmap */
;		clen[0] = (szb_bit + sz_au * ss - 1) / (sz_au * ss);	/* Number of allocation bitmap clusters */
;
;		/* Create a compressed up-case table */
;		sect = b_data + sz_au * clen[0];	/* Table start sector */
;		sum = 0;							/* Table checksum to be stored in the 82 entry */
;		st = 0; si = 0; i = 0; j = 0; szb_case = 0;
;		do {
;			switch (st) {
;			case 0:
;				ch = (WCHAR)ff_wtoupper(si);	/* Get an up-case char */
;				if (ch != si) {
;					si++; break;		/* Store the up-case char if exist */
;				}
;				for (j = 1; (WCHAR)(si + j) && (WCHAR)(si + j) == ff_wtoupper((WCHAR)(si + j)); j++) ;	/* Get run length of no-case block */
;				if (j >= 128) {
;					ch = 0xFFFF; st = 2; break;	/* Compress the no-case block if run is >= 128 chars */
;				}
;				st = 1;			/* Do not compress short run */
;				/* FALLTHROUGH */
;			case 1:
;				ch = si++;		/* Fill the short run */
;				if (--j == 0) st = 0;
;				break;
;
;			default:
;				ch = (WCHAR)j; si += (WCHAR)j;	/* Number of chars to skip */
;				st = 0;
;			}
;			sum = xsum32(buf[i + 0] = (BYTE)ch, sum);	/* Put it into the write buffer */
;			sum = xsum32(buf[i + 1] = (BYTE)(ch >> 8), sum);
;			i += 2; szb_case += 2;
;			if (si == 0 || i == sz_buf * ss) {		/* Write buffered data when buffer full or end of process */
;				n = (i + ss - 1) / ss;
;				if (disk_write(pdrv, buf, sect, n) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);
;				sect += n; i = 0;
;			}
;		} while (si);
;		clen[1] = (szb_case + sz_au * ss - 1) / (sz_au * ss);	/* Number of up-case table clusters */
;		clen[2] = 1;	/* Number of root directory clusters */
;
;		/* Initialize the allocation bitmap */
;		sect = b_data; nsect = (szb_bit + ss - 1) / ss;	/* Start of bitmap and number of bitmap sectors */
;		nbit = clen[0] + clen[1] + clen[2];				/* Number of clusters in-use by system (bitmap, up-case and root-dir) */
;		do {
;			memset(buf, 0, sz_buf * ss);				/* Initialize bitmap buffer */
;			for (i = 0; nbit != 0 && i / 8 < sz_buf * ss; buf[i / 8] |= 1 << (i % 8), i++, nbit--) ;	/* Mark used clusters */
;			n = (nsect > sz_buf) ? sz_buf : nsect;		/* Write the buffered data */
;			if (disk_write(pdrv, buf, sect, n) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);
;			sect += n; nsect -= n;
;		} while (nsect);
;
;		/* Initialize the FAT */
;		sect = b_fat; nsect = sz_fat;	/* Start of FAT and number of FAT sectors */
;		j = nbit = clu = 0;
;		do {
;			memset(buf, 0, sz_buf * ss); i = 0;	/* Clear work area and reset write offset */
;			if (clu == 0) {	/* Initialize FAT [0] and FAT[1] */
;				st_32(buf + i, 0xFFFFFFF8); i += 4; clu++;
;				st_32(buf + i, 0xFFFFFFFF); i += 4; clu++;
;			}
;
;			do {			/* Create chains of bitmap, up-case and root directory */
;				while (nbit != 0 && i < sz_buf * ss) {	/* Create a chain */
;					st_32(buf + i, (nbit > 1) ? clu + 1 : 0xFFFFFFFF);
;					i += 4; clu++; nbit--;
;				}
;				if (nbit == 0 && j < 3) nbit = clen[j++];	/* Get next chain length */
;			} while (nbit != 0 && i < sz_buf * ss);
;			n = (nsect > sz_buf) ? sz_buf : nsect;	/* Write the buffered data */
;			if (disk_write(pdrv, buf, sect, n) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);
;			sect += n; nsect -= n;
;		} while (nsect);
;
;		/* Initialize the root directory */
;		memset(buf, 0, sz_buf * ss);
;		buf[SZDIRE * 0 + 0] = ET_VLABEL;			/* Volume label entry (no label) */
;		buf[SZDIRE * 1 + 0] = ET_BITMAP;			/* Bitmap entry */
;		st_32(buf + SZDIRE * 1 + 20, 2);			/*  cluster */
;		st_32(buf + SZDIRE * 1 + 24, szb_bit);		/*  size */
;		buf[SZDIRE * 2 + 0] = ET_UPCASE;			/* Up-case table entry */
;		st_32(buf + SZDIRE * 2 + 4, sum);			/*  sum */
;		st_32(buf + SZDIRE * 2 + 20, 2 + clen[0]);	/*  cluster */
;		st_32(buf + SZDIRE * 2 + 24, szb_case);		/*  size */
;		sect = b_data + sz_au * (clen[0] + clen[1]); nsect = sz_au;	/* Start of the root directory and number of sectors */
;		do {	/* Fill root directory sectors */
;			n = (nsect > sz_buf) ? sz_buf : nsect;
;			if (disk_write(pdrv, buf, sect, n) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);
;			memset(buf, 0, ss);	/* Rest of entries are filled with zero */
;			sect += n; nsect -= n;
;		} while (nsect);
;
;		/* Create two set of the exFAT VBR blocks */
;		sect = b_vol;
;		for (n = 0; n < 2; n++) {
;			/* Main record (+0) */
;			memset(buf, 0, ss);
;			memcpy(buf + BS_JmpBoot, "\xEB\x76\x90" "EXFAT   ", 11);	/* Boot jump code (x86), OEM name */
;			st_64(buf + BPB_VolOfsEx, b_vol);						/* Volume offset in the physical drive [sector] */
;			st_64(buf + BPB_TotSecEx, sz_vol);						/* Volume size [sector] */
;			st_32(buf + BPB_FatOfsEx, (DWORD)(b_fat - b_vol));		/* FAT offset [sector] */
;			st_32(buf + BPB_FatSzEx, sz_fat);						/* FAT size [sector] */
;			st_32(buf + BPB_DataOfsEx, (DWORD)(b_data - b_vol));	/* Data offset [sector] */
;			st_32(buf + BPB_NumClusEx, n_clst);						/* Number of clusters */
;			st_32(buf + BPB_RootClusEx, 2 + clen[0] + clen[1]);		/* Root directory cluster number */
;			st_32(buf + BPB_VolIDEx, vsn);							/* VSN */
;			st_16(buf + BPB_FSVerEx, 0x100);						/* Filesystem version (1.00) */
;			for (buf[BPB_BytsPerSecEx] = 0, i = ss; i >>= 1; buf[BPB_BytsPerSecEx]++) ;		/* Log2 of sector size [byte] */
;			for (buf[BPB_SecPerClusEx] = 0, i = sz_au; i >>= 1; buf[BPB_SecPerClusEx]++) ;	/* Log2 of cluster size [sector] */
;			buf[BPB_NumFATsEx] = 1;					/* Number of FATs */
;			buf[BPB_DrvNumEx] = 0x80;				/* Drive number (for int13) */
;			st_16(buf + BS_BootCodeEx, 0xFEEB);	/* Boot code (x86) */
;			st_16(buf + BS_55AA, 0xAA55);			/* Signature (placed here regardless of sector size) */
;			for (i = sum = 0; i < ss; i++) {		/* VBR checksum */
;				if (i != BPB_VolFlagEx && i != BPB_VolFlagEx + 1 && i != BPB_PercInUseEx) sum = xsum32(buf[i], sum);
;			}
;			if (disk_write(pdrv, buf, sect++, 1) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);
;			/* Extended bootstrap record (+1..+8) */
;			memset(buf, 0, ss);
;			st_16(buf + ss - 2, 0xAA55);	/* Signature (placed at end of sector) */
;			for (j = 1; j < 9; j++) {
;				for (i = 0; i < ss; sum = xsum32(buf[i++], sum)) ;	/* VBR checksum */
;				if (disk_write(pdrv, buf, sect++, 1) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);
;			}
;			/* OEM/Reserved record (+9..+10) */
;			memset(buf, 0, ss);
;			for ( ; j < 11; j++) {
;				for (i = 0; i < ss; sum = xsum32(buf[i++], sum)) ;	/* VBR checksum */
;				if (disk_write(pdrv, buf, sect++, 1) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);
;			}
;			/* Sum record (+11) */
;			for (i = 0; i < ss; i += 4) st_32(buf + i, sum);	/* Fill with checksum value */
;			if (disk_write(pdrv, buf, sect++, 1) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);
;		}
;
;	} else
;#endif	/* FF_FS_EXFAT */
;	{	/* Create an FAT/FAT32 volume */
;		do {
L10650:
;			pau = sz_au;
	lda	<L1043+sz_au_1
	sta	<L1043+pau_1
	lda	<L1043+sz_au_1+2
	sta	<L1043+pau_1+2
;			/* Pre-determine number of clusters and FAT sub-type */
;			if (fsty == FS_FAT32) {	/* FAT32 volume */
	sep	#$20
	longa	off
	lda	<L1043+fsty_1
	cmp	#<$3
	rep	#$20
	longa	on
	beq	*+5
	brl	L10651
;				if (pau == 0) {	/* AU auto-selection */
	lda	<L1043+pau_1
	ora	<L1043+pau_1+2
	bne	L10652
;					n = (DWORD)sz_vol / 0x20000;	/* Volume size in unit of 128KS */
	pei	<L1043+sz_vol_1+2
	pei	<L1043+sz_vol_1
	lda	#$11
	xref	_~~llsr
	jsr	_~~llsr
	sta	<L1043+n_1
	stx	<L1043+n_1+2
;					for (i = 0, pau = 1; cst32[i] && cst32[i] <= n; i++, pau <<= 1) ;	/* Get from table */
	stz	<L1043+i_1
	lda	#$1
	sta	<L1043+pau_1
	dea
	sta	<L1043+pau_1+2
	bra	L10656
L10653:
	asl	<L1043+pau_1
	rol	<L1043+pau_1+2
	inc	<L1043+i_1
L10656:
	lda	<L1043+i_1
	asl	A
	tax
	lda	|L1045,X ;cst32
	beq	L10652
	lda	<L1043+i_1
	asl	A
	tax
	lda	|L1045,X ;cst32
	sta	<R2
	stz	<R2+2
	lda	<L1043+n_1
	cmp	<R2
	lda	<L1043+n_1+2
	sbc	<R2+2
	bcs	L10653
;				}
;				n_clst = (DWORD)sz_vol / pau;	/* Number of clusters */
L10652:
	pei	<L1043+pau_1+2
	pei	<L1043+pau_1
	pei	<L1043+sz_vol_1+2
	pei	<L1043+sz_vol_1
	xref	_~~ludv
	jsr	_~~ludv
	sta	<L1043+n_clst_1
	stx	<L1043+n_clst_1+2
;				sz_fat = (n_clst * 4 + 8 + ss - 1) / ss;	/* FAT size [sector] */
	lda	<L1043+ss_1
	sta	<R0
	stz	<R0+2
	lda	<L1043+ss_1
	sta	<R1
	stz	<R1+2
	lda	<L1043+n_clst_1
	sta	<R2
	lda	<L1043+n_clst_1+2
	sta	<R2+2
	asl	<R2
	rol	<R2+2
	asl	<R2
	rol	<R2+2
	lda	<R2
	clc
	adc	<R1
	sta	<R3
	lda	<R2+2
	adc	<R1+2
	sta	<R3+2
	lda	#$7
	clc
	adc	<R3
	sta	<R1
	lda	#$0
	adc	<R3+2
	sta	<R1+2
	pei	<R0+2
	pei	<R0
	pei	<R1+2
	pei	<R1
	xref	_~~ludv
	jsr	_~~ludv
	sta	<L1043+sz_fat_1
	stx	<L1043+sz_fat_1+2
;				sz_rsv = 32;	/* Number of reserved sectors */
	lda	#$20
	sta	<L1043+sz_rsv_1
	lda	#$0
	sta	<L1043+sz_rsv_1+2
;				sz_dir = 0;		/* No static directory */
	stz	<L1043+sz_dir_1
	stz	<L1043+sz_dir_1+2
;				if (n_clst <= MAX_FAT16 || n_clst > MAX_FAT32) LEAVE_MKFS(FR_MKFS_ABORTED);
	lda	#$fff5
	cmp	<L1043+n_clst_1
	lda	#$0
	sbc	<L1043+n_clst_1+2
	bcc	*+5
	brl	L20232
	lda	#$fff5
	cmp	<L1043+n_clst_1
	lda	#$fff
	sbc	<L1043+n_clst_1+2
	bcc	*+5
	brl	L10658
	brl	L20232
;			} else {				/* FAT volume */
L10651:
;				if (pau == 0) {	/* au auto-selection */
	lda	<L1043+pau_1
	ora	<L1043+pau_1+2
	bne	L10659
;					n = (DWORD)sz_vol / 0x1000;	/* Volume size in unit of 4KS */
	pei	<L1043+sz_vol_1+2
	pei	<L1043+sz_vol_1
	lda	#$c
	xref	_~~llsr
	jsr	_~~llsr
	sta	<L1043+n_1
	stx	<L1043+n_1+2
;					for (i = 0, pau = 1; cst[i] && cst[i] <= n; i++, pau <<= 1) ;	/* Get from table */
	stz	<L1043+i_1
	lda	#$1
	sta	<L1043+pau_1
	dea
	sta	<L1043+pau_1+2
	bra	L10663
L10660:
	asl	<L1043+pau_1
	rol	<L1043+pau_1+2
	inc	<L1043+i_1
L10663:
	lda	<L1043+i_1
	asl	A
	tax
	lda	|L1044,X ;cst
	beq	L10659
	lda	<L1043+i_1
	asl	A
	tax
	lda	|L1044,X ;cst
	sta	<R2
	stz	<R2+2
	lda	<L1043+n_1
	cmp	<R2
	lda	<L1043+n_1+2
	sbc	<R2+2
	bcs	L10660
;				}
;				n_clst = (DWORD)sz_vol / pau;
L10659:
	pei	<L1043+pau_1+2
	pei	<L1043+pau_1
	pei	<L1043+sz_vol_1+2
	pei	<L1043+sz_vol_1
	xref	_~~ludv
	jsr	_~~ludv
	sta	<L1043+n_clst_1
	stx	<L1043+n_clst_1+2
;				if (n_clst > MAX_FAT12) {
	lda	#$ff5
	cmp	<L1043+n_clst_1
	lda	#$0
	sbc	<L1043+n_clst_1+2
	bcs	L10664
;					n = n_clst * 2 + 4;		/* FAT size [byte] */
	lda	<L1043+n_clst_1
	sta	<R0
	lda	<L1043+n_clst_1+2
	sta	<R0+2
	asl	<R0
	rol	<R0+2
	clc
	lda	#$4
	bra	L20225
;				} else {
L10664:
;					fsty = FS_FAT12;
	sep	#$20
	longa	off
	lda	#$1
	sta	<L1043+fsty_1
	rep	#$20
	longa	on
;					n = (n_clst * 3 + 1) / 2 + 3;	/* FAT size [byte] */
	pea	#^$3
	pea	#<$3
	pei	<L1043+n_clst_1+2
	pei	<L1043+n_clst_1
	xref	_~~lmul
	jsr	_~~lmul
	sta	<R1
	stx	<R1+2
	lda	#$1
	clc
	adc	<R1
	sta	<R2
	lda	#$0
	adc	<R1+2
	pha
	pei	<R2
	lda	#$1
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R0
	stx	<R0+2
	clc
	lda	#$3
L20225:
	adc	<R0
	sta	<L1043+n_1
	lda	#$0
	adc	<R0+2
	sta	<L1043+n_1+2
;				}
;				sz_fat = (n + ss - 1) / ss;		/* FAT size [sector] */
	lda	<L1043+ss_1
	sta	<R0
	stz	<R0+2
	lda	<L1043+ss_1
	sta	<R1
	stz	<R1+2
	lda	<R1
	clc
	adc	<L1043+n_1
	sta	<R2
	lda	<R1+2
	adc	<L1043+n_1+2
	sta	<R2+2
	lda	#$ffff
	clc
	adc	<R2
	sta	<R1
	lda	#$ffff
	adc	<R2+2
	sta	<R1+2
	pei	<R0+2
	pei	<R0
	pei	<R1+2
	pei	<R1
	xref	_~~ludv
	jsr	_~~ludv
	sta	<L1043+sz_fat_1
	stx	<L1043+sz_fat_1+2
;				sz_rsv = 1;						/* Number of reserved sectors */
	lda	#$1
	sta	<L1043+sz_rsv_1
	dea
	sta	<L1043+sz_rsv_1+2
;				sz_dir = (DWORD)n_root * SZDIRE / ss;	/* Root directory size [sector] */
	lda	<L1043+ss_1
	sta	<R0
	stz	<R0+2
	lda	<L1043+n_root_1
	sta	<R2
	stz	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$5
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R1
	stx	<R1+2
	pei	<R0+2
	pei	<R0
	pei	<R1+2
	pei	<R1
	xref	_~~ludv
	jsr	_~~ludv
	sta	<L1043+sz_dir_1
	stx	<L1043+sz_dir_1+2
;			}
L10658:
;			b_fat = b_vol + sz_rsv;						/* FAT base */
	lda	<L1043+b_vol_1
	clc
	adc	<L1043+sz_rsv_1
	sta	<L1043+b_fat_1
	lda	<L1043+b_vol_1+2
	adc	<L1043+sz_rsv_1+2
	sta	<L1043+b_fat_1+2
;			b_data = b_fat + sz_fat * n_fat + sz_dir;	/* Data base */
	lda	<L1043+n_fat_1
	sta	<R0
	stz	<R0+2
	pei	<L1043+sz_fat_1+2
	pei	<L1043+sz_fat_1
	pei	<R0+2
	pei	<R0
	xref	_~~lmul
	jsr	_~~lmul
	stx	<R0+2
	clc
	adc	<L1043+b_fat_1
	sta	<R1
	lda	<R0+2
	adc	<L1043+b_fat_1+2
	sta	<R1+2
	lda	<R1
	clc
	adc	<L1043+sz_dir_1
	sta	<L1043+b_data_1
	lda	<R1+2
	adc	<L1043+sz_dir_1+2
	sta	<L1043+b_data_1+2
;
;			/* Align data area to erase block boundary (for flash memory media) */
;			n = (DWORD)(((b_data + sz_blk - 1) & ~(sz_blk - 1)) - b_data);	/* Sectors to next nearest from current data base */
	lda	<L1043+b_data_1
	clc
	adc	<L1043+sz_blk_1
	sta	<R0
	lda	<L1043+b_data_1+2
	adc	<L1043+sz_blk_1+2
	sta	<R0+2
	lda	#$ffff
	clc
	adc	<R0
	sta	<R1
	lda	#$ffff
	adc	<R0+2
	sta	<R1+2
	lda	#$ffff
	clc
	adc	<L1043+sz_blk_1
	sta	<R0
	lda	#$ffff
	adc	<L1043+sz_blk_1+2
	sta	<R0+2
	lda	<R0
	eor	#<$ffffffff
	sta	<R2
	lda	<R0+2
	eor	#^$ffffffff
	sta	<R2+2
	lda	<R2
	and	<R1
	sta	<R0
	lda	<R2+2
	and	<R1+2
	sta	<R0+2
	sec
	lda	<R0
	sbc	<L1043+b_data_1
	sta	<L1043+n_1
	lda	<R0+2
	sbc	<L1043+b_data_1+2
	sta	<L1043+n_1+2
;			if (fsty == FS_FAT32) {		/* FAT32: Move FAT */
	sep	#$20
	longa	off
	lda	<L1043+fsty_1
	cmp	#<$3
	rep	#$20
	longa	on
	bne	L10666
;				sz_rsv += n; b_fat += n;
	lda	<L1043+sz_rsv_1
	clc
	adc	<L1043+n_1
	sta	<L1043+sz_rsv_1
	lda	<L1043+sz_rsv_1+2
	adc	<L1043+n_1+2
	sta	<L1043+sz_rsv_1+2
	lda	<L1043+b_fat_1
	clc
	adc	<L1043+n_1
	sta	<L1043+b_fat_1
	lda	<L1043+b_fat_1+2
	adc	<L1043+n_1+2
	sta	<L1043+b_fat_1+2
;			} else {					/* FAT: Expand FAT */
	bra	L10667
L10666:
;				if (n % n_fat) {	/* Adjust fractional error if needed */
	lda	<L1043+n_fat_1
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L1043+n_1+2
	pei	<L1043+n_1
	xref	_~~lumd
	jsr	_~~lumd
	stx	<R0+2
	ora	<R0+2
	beq	L10668
;					n--; sz_rsv++; b_fat++;
	lda	<L1043+n_1
	bne	L1109
	dec	<L1043+n_1+2
L1109:
	dec	<L1043+n_1
	inc	<L1043+sz_rsv_1
	bne	L1110
	inc	<L1043+sz_rsv_1+2
L1110:
	inc	<L1043+b_fat_1
	bne	L10668
	inc	<L1043+b_fat_1+2
;				}
;				sz_fat += n / n_fat;
L10668:
	lda	<L1043+n_fat_1
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L1043+n_1+2
	pei	<L1043+n_1
	xref	_~~ludv
	jsr	_~~ludv
	stx	<R0+2
	clc
	adc	<L1043+sz_fat_1
	sta	<L1043+sz_fat_1
	lda	<R0+2
	adc	<L1043+sz_fat_1+2
	sta	<L1043+sz_fat_1+2
;			}
L10667:
;
;			/* Determine number of clusters and final check of validity of the FAT sub-type */
;			if (sz_vol < b_data + pau * 16 - b_vol) LEAVE_MKFS(FR_MKFS_ABORTED);	/* Too small volume? */
	lda	<L1043+pau_1
	sta	<R0
	lda	<L1043+pau_1+2
	sta	<R0+2
	asl	<R0
	rol	<R0+2
	asl	<R0
	rol	<R0+2
	asl	<R0
	rol	<R0+2
	asl	<R0
	rol	<R0+2
	lda	<R0
	clc
	adc	<L1043+b_data_1
	sta	<R1
	lda	<R0+2
	adc	<L1043+b_data_1+2
	sta	<R1+2
	sec
	lda	<R1
	sbc	<L1043+b_vol_1
	sta	<R0
	lda	<R1+2
	sbc	<L1043+b_vol_1+2
	sta	<R0+2
	lda	<L1043+sz_vol_1
	cmp	<R0
	lda	<L1043+sz_vol_1+2
	sbc	<R0+2
	bcs	*+5
	brl	L20232
;			n_clst = ((DWORD)sz_vol - sz_rsv - sz_fat * n_fat - sz_dir) / pau;
	lda	<L1043+n_fat_1
	sta	<R0
	stz	<R0+2
	pei	<L1043+sz_fat_1+2
	pei	<L1043+sz_fat_1
	pei	<R0+2
	pei	<R0
	xref	_~~lmul
	jsr	_~~lmul
	sta	<R0
	stx	<R0+2
	sec
	lda	<L1043+sz_vol_1
	sbc	<L1043+sz_rsv_1
	sta	<R1
	lda	<L1043+sz_vol_1+2
	sbc	<L1043+sz_rsv_1+2
	sta	<R1+2
	sec
	lda	<R1
	sbc	<R0
	sta	<R2
	lda	<R1+2
	sbc	<R0+2
	sta	<R2+2
	sec
	lda	<R2
	sbc	<L1043+sz_dir_1
	sta	<R0
	lda	<R2+2
	sbc	<L1043+sz_dir_1+2
	sta	<R0+2
	pei	<L1043+pau_1+2
	pei	<L1043+pau_1
	pei	<R0+2
	pei	<R0
	xref	_~~ludv
	jsr	_~~ludv
	sta	<L1043+n_clst_1
	stx	<L1043+n_clst_1+2
;			if (fsty == FS_FAT32) {
	sep	#$20
	longa	off
	lda	<L1043+fsty_1
	cmp	#<$3
	rep	#$20
	longa	on
	bne	L10670
;				if (n_clst <= MAX_FAT16) {	/* Too few clusters for FAT32? */
	lda	#$fff5
	cmp	<L1043+n_clst_1
	lda	#$0
	sbc	<L1043+n_clst_1+2
	bcc	L10670
;					if (sz_au == 0 && (sz_au = pau / 2) != 0) continue;	/* Adjust cluster size and retry */
	lda	<L1043+sz_au_1
	ora	<L1043+sz_au_1+2
	beq	*+5
	brl	L20232
	lda	<L1043+pau_1
	sta	<L1043+sz_au_1
	lda	<L1043+pau_1+2
	sta	<L1043+sz_au_1+2
	lsr	<L1043+sz_au_1+2
	ror	<L1043+sz_au_1
	lda	<L1043+sz_au_1
	ora	<L1043+sz_au_1+2
	beq	*+5
	brl	L10650
;					LEAVE_MKFS(FR_MKFS_ABORTED);
	brl	L20232
;				}
;			}
;			if (fsty == FS_FAT16) {
L10670:
	sep	#$20
	longa	off
	lda	<L1043+fsty_1
	cmp	#<$2
	rep	#$20
	longa	on
	beq	*+5
	brl	L10672
;				if (n_clst > MAX_FAT16) {	/* Too many clusters for FAT16 */
	lda	#$fff5
	cmp	<L1043+n_clst_1
	lda	#$0
	sbc	<L1043+n_clst_1+2
	bcs	L10673
;					if (sz_au == 0 && (pau * 2) <= 64) {
	lda	<L1043+sz_au_1
	ora	<L1043+sz_au_1+2
	bne	L10674
	lda	<L1043+pau_1
	sta	<R0
	lda	<L1043+pau_1+2
	sta	<R0+2
	asl	<R0
	rol	<R0+2
	lda	#$40
	cmp	<R0
	lda	#$0
	sbc	<R0+2
	bcc	L10674
;						sz_au = pau * 2; continue;	/* Adjust cluster size and retry */
	lda	<L1043+pau_1
	sta	<L1043+sz_au_1
	lda	<L1043+pau_1+2
	sta	<L1043+sz_au_1+2
	asl	<L1043+sz_au_1
	rol	<L1043+sz_au_1+2
	brl	L10650
;					}
;					if ((fsopt & FM_FAT32)) {
L10674:
	sep	#$20
	longa	off
	lda	<L1043+fsopt_1
	and	#<$2
	rep	#$20
	longa	on
	beq	L10675
;						fsty = FS_FAT32; continue;	/* Switch type to FAT32 and retry */
	sep	#$20
	longa	off
	lda	#$3
	sta	<L1043+fsty_1
	rep	#$20
	longa	on
	brl	L10650
;					}
;					if (sz_au == 0 && (sz_au = pau * 2) <= 128) continue;	/* Adjust cluster size and retry */
L10675:
	lda	<L1043+sz_au_1
	ora	<L1043+sz_au_1+2
	beq	*+5
	brl	L20232
	lda	<L1043+pau_1
	sta	<L1043+sz_au_1
	lda	<L1043+pau_1+2
	sta	<L1043+sz_au_1+2
	asl	<L1043+sz_au_1
	rol	<L1043+sz_au_1+2
	lda	#$80
	cmp	<L1043+sz_au_1
	lda	#$0
	sbc	<L1043+sz_au_1+2
	bcc	*+5
	brl	L10650
;					LEAVE_MKFS(FR_MKFS_ABORTED);
	brl	L20232
;				}
;				if  (n_clst <= MAX_FAT12) {	/* Too few clusters for FAT16 */
L10673:
	lda	#$ff5
	cmp	<L1043+n_clst_1
	lda	#$0
	sbc	<L1043+n_clst_1+2
	bcs	L10675
;					if (sz_au == 0 && (sz_au = pau * 2) <= 128) continue;	/* Adjust cluster size and retry */
;					LEAVE_MKFS(FR_MKFS_ABORTED);
;				}
;			}
;			if (fsty == FS_FAT12 && n_clst > MAX_FAT12) LEAVE_MKFS(FR_MKFS_ABORTED);	/* Too many clusters for FAT12 */
L10672:
	sep	#$20
	longa	off
	lda	<L1043+fsty_1
	cmp	#<$1
	rep	#$20
	longa	on
	bne	L10677
	lda	#$ff5
	cmp	<L1043+n_clst_1
	lda	#$0
	sbc	<L1043+n_clst_1+2
	bcs	*+5
	brl	L20232
;
;			/* Ok, it is the valid cluster configuration */
;			break;
L10677:
;
;#if FF_USE_TRIM
;		lba[0] = b_vol; lba[1] = b_vol + sz_vol - 1;	/* Inform storage device that the volume area may be erased */
;		disk_ioctl(pdrv, CTRL_TRIM, lba);
;#endif
;		/* Create FAT VBR */
;		memset(buf, 0, ss);
	pei	<L1043+ss_1
	pea	#<$0
	pei	<L1043+buf_1+2
	pei	<L1043+buf_1
	jsr	_~memset
;		memcpy(buf + BS_JmpBoot, "\xEB\xFE\x90" "MSDOS5.0", 11);	/* Boot jump code (x86), OEM name */
	pea	#<$b
	pea	#^L482
	pea	#<L482
	pei	<L1043+buf_1+2
	pei	<L1043+buf_1
	jsr	_~memcpy
;		st_16(buf + BPB_BytsPerSec, ss);				/* Sector size [byte] */
	pei	<L1043+ss_1
	lda	#$b
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_16
;		buf[BPB_SecPerClus] = (BYTE)pau;				/* Cluster size [sector] */
	sep	#$20
	longa	off
	lda	<L1043+pau_1
	ldy	#$d
	sta	[<L1043+buf_1],Y
	rep	#$20
	longa	on
;		st_16(buf + BPB_RsvdSecCnt, (WORD)sz_rsv);		/* Size of reserved area */
	pei	<L1043+sz_rsv_1
	lda	#$e
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_16
;		buf[BPB_NumFATs] = (BYTE)n_fat;					/* Number of FATs */
	sep	#$20
	longa	off
	lda	<L1043+n_fat_1
	ldy	#$10
	sta	[<L1043+buf_1],Y
;		st_16(buf + BPB_RootEntCnt, (WORD)((fsty == FS_FAT32) ? 0 : n_root));	/* Number of root directory entries */
	lda	<L1043+fsty_1
	cmp	#<$3
	rep	#$20
	longa	on
	bne	*+5
	brl	L1133
	lda	<L1043+n_root_1
	brl	L1134
L20234:
;			st_32(buf + BPB_TotSec32, (DWORD)sz_vol);	/* Volume size in 32-bit LBA */
	pei	<L1043+sz_vol_1+2
	pei	<L1043+sz_vol_1
	lda	#$20
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_32
;		}
L10679:
;		buf[BPB_Media] = 0xF8;							/* Media descriptor byte */
	sep	#$20
	longa	off
	lda	#$f8
	ldy	#$15
	sta	[<L1043+buf_1],Y
	rep	#$20
	longa	on
;		st_16(buf + BPB_SecPerTrk, 63);					/* Number of sectors per track (for int13) */
	pea	#<$3f
	lda	#$18
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_16
;		st_16(buf + BPB_NumHeads, 255);					/* Number of heads (for int13) */
	pea	#<$ff
	lda	#$1a
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_16
;		st_32(buf + BPB_HiddSec, (DWORD)b_vol);			/* Volume offset in the physical drive [sector] */
	pei	<L1043+b_vol_1+2
	pei	<L1043+b_vol_1
	lda	#$1c
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_32
;		if (fsty == FS_FAT32) {
	sep	#$20
	longa	off
	lda	<L1043+fsty_1
	cmp	#<$3
	rep	#$20
	longa	on
	bne	*+5
	brl	L1136
;			st_32(buf + BS_VolID, vsn);					/* VSN */
	pei	<L1043+vsn_1+2
	pei	<L1043+vsn_1
	lda	#$27
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_32
;			st_16(buf + BPB_FATSz16, (WORD)sz_fat);		/* FAT size [sector] */
	pei	<L1043+sz_fat_1
	lda	#$16
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_16
;			buf[BS_DrvNum] = 0x80;						/* Drive number (for int13) */
	sep	#$20
	longa	off
	lda	#$80
	ldy	#$24
	sta	[<L1043+buf_1],Y
;			buf[BS_BootSig] = 0x29;						/* Extended boot signature */
	lda	#$29
	iny
	iny
	sta	[<L1043+buf_1],Y
	rep	#$20
	longa	on
;			memcpy(buf + BS_VolLab, "NO NAME    " "FAT     ", 19);	/* Volume label, FAT signature */
	pea	#<$13
	pea	#^L482+32
	pea	#<L482+32
	clc
	lda	#$2b
L20229:
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~memcpy
;		}
;		st_16(buf + BS_55AA, 0xAA55);					/* Signature (offset is fixed here regardless of sector size) */
	pea	#<$aa55
	lda	#$1fe
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_16
;		if (disk_write(pdrv, buf, b_vol, 1) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);	/* Write it to the VBR sector */
	pea	#<$1
	pei	<L1043+b_vol_1+2
	pei	<L1043+b_vol_1
	pei	<L1043+buf_1+2
	pei	<L1043+buf_1
	pei	<L1043+pdrv_1
	jsr	_~disk_write
	tax
	beq	*+5
	brl	L20231
	sep	#$20
	longa	off
	lda	<L1043+fsty_1
	cmp	#<$3
	rep	#$20
	longa	on
	bne	*+5
	brl	L1138
	brl	L10683
;		} while (1);
L1133:
	lda	#$0
L1134:
	pha
	lda	#$11
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_16
;		if (sz_vol < 0x10000) {
	lda	<L1043+sz_vol_1
	cmp	#<$10000
	lda	<L1043+sz_vol_1+2
	sbc	#^$10000
	bcc	*+5
	brl	L20234
;			st_16(buf + BPB_TotSec16, (WORD)sz_vol);	/* Volume size in 16-bit LBA */
	pei	<L1043+sz_vol_1
	lda	#$13
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_16
;		} else {
	brl	L10679
L1136:
;			st_32(buf + BS_VolID32, vsn);				/* VSN */
	pei	<L1043+vsn_1+2
	pei	<L1043+vsn_1
	lda	#$43
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_32
;			st_32(buf + BPB_FATSz32, sz_fat);			/* FAT size [sector] */
	pei	<L1043+sz_fat_1+2
	pei	<L1043+sz_fat_1
	lda	#$24
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_32
;			st_32(buf + BPB_RootClus32, 2);				/* Root directory cluster # (2) */
	pea	#^$2
	pea	#<$2
	lda	#$2c
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_32
;			st_16(buf + BPB_FSInfo32, 1);				/* Offset of FSINFO sector (VBR + 1) */
	pea	#<$1
	lda	#$30
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_16
;			st_16(buf + BPB_BkBootSec32, 6);			/* Offset of backup VBR (VBR + 6) */
	pea	#<$6
	lda	#$32
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_16
;			buf[BS_DrvNum32] = 0x80;					/* Drive number (for int13) */
	sep	#$20
	longa	off
	lda	#$80
	ldy	#$40
	sta	[<L1043+buf_1],Y
;			buf[BS_BootSig32] = 0x29;					/* Extended boot signature */
	lda	#$29
	iny
	iny
	sta	[<L1043+buf_1],Y
	rep	#$20
	longa	on
;			memcpy(buf + BS_VolLab32, "NO NAME    " "FAT32   ", 19);	/* Volume label, FAT signature */
	pea	#<$13
	pea	#^L482+12
	pea	#<L482+12
	clc
	lda	#$47
	brl	L20229
;		} else {
;
;		/* Create FSINFO record if needed */
;		if (fsty == FS_FAT32) {
L1138:
;			disk_write(pdrv, buf, b_vol + 6, 1);		/* Write backup VBR (VBR + 6) */
	pea	#<$1
	lda	#$6
	clc
	adc	<L1043+b_vol_1
	sta	<R0
	lda	#$0
	adc	<L1043+b_vol_1+2
	pha
	pei	<R0
	pei	<L1043+buf_1+2
	pei	<L1043+buf_1
	pei	<L1043+pdrv_1
	jsr	_~disk_write
;			memset(buf, 0, ss);
	pei	<L1043+ss_1
	pea	#<$0
	pei	<L1043+buf_1+2
	pei	<L1043+buf_1
	jsr	_~memset
;			st_32(buf + FSI_LeadSig, 0x41615252);
	pea	#^$41615252
	pea	#<$41615252
	pei	<L1043+buf_1+2
	pei	<L1043+buf_1
	jsr	_~st_32
;			st_32(buf + FSI_StrucSig, 0x61417272);
	pea	#^$61417272
	pea	#<$61417272
	lda	#$1e4
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_32
;			st_32(buf + FSI_Free_Count, n_clst - 1);	/* Number of free clusters */
	lda	#$ffff
	clc
	adc	<L1043+n_clst_1
	sta	<R0
	lda	#$ffff
	adc	<L1043+n_clst_1+2
	pha
	pei	<R0
	lda	#$1e8
	clc
	adc	<L1043+buf_1
	sta	<R1
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R1
	jsr	_~st_32
;			st_32(buf + FSI_Nxt_Free, 2);				/* Last allocated cluster# */
	pea	#^$2
	pea	#<$2
	lda	#$1ec
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_32
;			st_16(buf + BS_55AA, 0xAA55);
	pea	#<$aa55
	lda	#$1fe
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_16
;			disk_write(pdrv, buf, b_vol + 7, 1);		/* Write backup FSINFO (VBR + 7) */
	pea	#<$1
	lda	#$7
	clc
	adc	<L1043+b_vol_1
	sta	<R0
	lda	#$0
	adc	<L1043+b_vol_1+2
	pha
	pei	<R0
	pei	<L1043+buf_1+2
	pei	<L1043+buf_1
	pei	<L1043+pdrv_1
	jsr	_~disk_write
;			disk_write(pdrv, buf, b_vol + 1, 1);		/* Write original FSINFO (VBR + 1) */
	pea	#<$1
	lda	#$1
	clc
	adc	<L1043+b_vol_1
	sta	<R0
	lda	#$0
	adc	<L1043+b_vol_1+2
	pha
	pei	<R0
	pei	<L1043+buf_1+2
	pei	<L1043+buf_1
	pei	<L1043+pdrv_1
	jsr	_~disk_write
;		}
;
;		/* Initialize FAT area */
;		memset(buf, 0, sz_buf * ss);
L10683:
	lda	<L1043+ss_1
	sta	<R0
	stz	<R0+2
	pei	<L1043+sz_buf_1+2
	pei	<L1043+sz_buf_1
	pei	<R0+2
	pei	<R0
	xref	_~~lmul
	jsr	_~~lmul
	sta	<R0
	stx	<R0+2
	pei	<R0
	pea	#<$0
	pei	<L1043+buf_1+2
	pei	<L1043+buf_1
	jsr	_~memset
;		sect = b_fat;		/* FAT start sector */
	lda	<L1043+b_fat_1
	sta	<L1043+sect_1
	lda	<L1043+b_fat_1+2
	sta	<L1043+sect_1+2
;		for (i = 0; i < n_fat; i++) {			/* Initialize FATs each */
	stz	<L1043+i_1
	brl	L10687
L10686:
;			if (fsty == FS_FAT32) {
	sep	#$20
	longa	off
	lda	<L1043+fsty_1
	cmp	#<$3
	rep	#$20
	longa	on
	bne	L10688
;				st_32(buf + 0, 0xFFFFFFF8);	/* FAT[0] */
	pea	#^$fffffff8
	pea	#<$fffffff8
	pei	<L1043+buf_1+2
	pei	<L1043+buf_1
	jsr	_~st_32
;				st_32(buf + 4, 0xFFFFFFFF);	/* FAT[1] */
	pea	#^$ffffffff
	pea	#<$ffffffff
	lda	#$4
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	jsr	_~st_32
;				st_32(buf + 8, 0x0FFFFFFF);	/* FAT[2] (root directory at cluster# 2) */
	pea	#^$fffffff
	pea	#<$fffffff
	lda	#$8
	clc
	adc	<L1043+buf_1
	sta	<R0
	lda	#$0
	adc	<L1043+buf_1+2
	pha
	pei	<R0
	bra	L20215
;			} else {
L10688:
;				st_32(buf + 0, (fsty == FS_FAT12) ? 0xFFFFF8 : 0xFFFFFFF8);	/* FAT[0] and FAT[1] */
	sep	#$20
	longa	off
	lda	<L1043+fsty_1
	cmp	#<$1
	rep	#$20
	longa	on
	bne	L1140
	lda	#$ff
	bra	L20220
L1140:
	lda	#$ffff
L20220:
	tax
	lda	#$fff8
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L1043+buf_1+2
	pei	<L1043+buf_1
L20215:
	jsr	_~st_32
;			}
;			nsect = sz_fat;		/* Number of FAT sectors */
	lda	<L1043+sz_fat_1
	sta	<L1043+nsect_1
	lda	<L1043+sz_fat_1+2
	sta	<L1043+nsect_1+2
;			do {	/* Fill FAT sectors */
L10692:
;				n = (nsect > sz_buf) ? sz_buf : nsect;
	lda	<L1043+sz_buf_1
	cmp	<L1043+nsect_1
	lda	<L1043+sz_buf_1+2
	sbc	<L1043+nsect_1+2
	bcs	L1143
	ldx	<L1043+sz_buf_1+2
	lda	<L1043+sz_buf_1
	bra	L1145
L1143:
	ldx	<L1043+nsect_1+2
	lda	<L1043+nsect_1
L1145:
	stx	<R0+2
	sta	<L1043+n_1
	lda	<R0+2
	sta	<L1043+n_1+2
;				if (disk_write(pdrv, buf, sect, (UINT)n) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);
	pei	<L1043+n_1
	pei	<L1043+sect_1+2
	pei	<L1043+sect_1
	pei	<L1043+buf_1+2
	pei	<L1043+buf_1
	pei	<L1043+pdrv_1
	jsr	_~disk_write
	tax
	beq	*+5
	brl	L20231
;				memset(buf, 0, ss);	/* Rest of FAT area is initially zero */
	pei	<L1043+ss_1
	pea	#<$0
	pei	<L1043+buf_1+2
	pei	<L1043+buf_1
	jsr	_~memset
;				sect += n; nsect -= n;
	lda	<L1043+sect_1
	clc
	adc	<L1043+n_1
	sta	<L1043+sect_1
	lda	<L1043+sect_1+2
	adc	<L1043+n_1+2
	sta	<L1043+sect_1+2
	sec
	lda	<L1043+nsect_1
	sbc	<L1043+n_1
	sta	<L1043+nsect_1
	lda	<L1043+nsect_1+2
	sbc	<L1043+n_1+2
	sta	<L1043+nsect_1+2
;			} while (nsect);
	lda	<L1043+nsect_1
	ora	<L1043+nsect_1+2
	bne	L10692
;		}
	inc	<L1043+i_1
L10687:
	lda	<L1043+i_1
	cmp	<L1043+n_fat_1
	bcs	*+5
	brl	L10686
;
;		/* Initialize root directory (fill with zero) */
;		nsect = (fsty == FS_FAT32) ? pau : sz_dir;	/* Number of root directory sectors */
	sep	#$20
	longa	off
	lda	<L1043+fsty_1
	cmp	#<$3
	rep	#$20
	longa	on
	bne	L1149
	ldx	<L1043+pau_1+2
	lda	<L1043+pau_1
	bra	L1151
L1149:
	ldx	<L1043+sz_dir_1+2
	lda	<L1043+sz_dir_1
L1151:
	stx	<R0+2
	sta	<L1043+nsect_1
	lda	<R0+2
	sta	<L1043+nsect_1+2
;		do {
L10696:
;			n = (nsect > sz_buf) ? sz_buf : nsect;
	lda	<L1043+sz_buf_1
	cmp	<L1043+nsect_1
	lda	<L1043+sz_buf_1+2
	sbc	<L1043+nsect_1+2
	bcs	L1152
	ldx	<L1043+sz_buf_1+2
	lda	<L1043+sz_buf_1
	bra	L1154
L1152:
	ldx	<L1043+nsect_1+2
	lda	<L1043+nsect_1
L1154:
	stx	<R0+2
	sta	<L1043+n_1
	lda	<R0+2
	sta	<L1043+n_1+2
;			if (disk_write(pdrv, buf, sect, (UINT)n) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);
	pei	<L1043+n_1
	pei	<L1043+sect_1+2
	pei	<L1043+sect_1
	pei	<L1043+buf_1+2
	pei	<L1043+buf_1
	pei	<L1043+pdrv_1
	jsr	_~disk_write
	tax
	beq	*+5
	brl	L20231
;			sect += n; nsect -= n;
	lda	<L1043+sect_1
	clc
	adc	<L1043+n_1
	sta	<L1043+sect_1
	lda	<L1043+sect_1+2
	adc	<L1043+n_1+2
	sta	<L1043+sect_1+2
	sec
	lda	<L1043+nsect_1
	sbc	<L1043+n_1
	sta	<L1043+nsect_1
	lda	<L1043+nsect_1+2
	sbc	<L1043+n_1+2
	sta	<L1043+nsect_1+2
;		} while (nsect);
	lda	<L1043+nsect_1
	ora	<L1043+nsect_1+2
	bne	L10696
;	}
;
;	/* A FAT volume has been created here */
;
;	/* Determine system ID in the MBR partition table */
;	if (FF_FS_EXFAT && fsty == FS_EXFAT) {
;		sys = 0x07;		/* exFAT */
;	} else if (fsty == FS_FAT32) {
	sep	#$20
	longa	off
	lda	<L1043+fsty_1
	cmp	#<$3
	rep	#$20
	longa	on
	bne	L10700
;		sys = 0x0C;		/* FAT32X */
	sep	#$20
	longa	off
	lda	#$c
	sta	<L1043+sys_1
	rep	#$20
	longa	on
;	} else if (sz_vol >= 0x10000) {
	bra	L10706
L10710:
;
;	if (disk_ioctl(pdrv, CTRL_SYNC, 0) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pei	<L1043+pdrv_1
	jsr	_~disk_ioctl
	tax
	beq	*+5
	brl	L20231
	lda	#$0
	brl	L1048
L10700:
	lda	<L1043+sz_vol_1
	cmp	#<$10000
	lda	<L1043+sz_vol_1+2
	sbc	#^$10000
	bcc	L10702
;		sys = 0x06;		/* FAT12/16 (large) */
	sep	#$20
	longa	off
	lda	#$6
	sta	<L1043+sys_1
	rep	#$20
	longa	on
;	} else if (fsty == FS_FAT16) {
	bra	L10706
L10702:
	sep	#$20
	longa	off
	lda	<L1043+fsty_1
	cmp	#<$2
	rep	#$20
	longa	on
	bne	L10704
;		sys = 0x04;		/* FAT16 */
	sep	#$20
	longa	off
	lda	#$4
	sta	<L1043+sys_1
	rep	#$20
	longa	on
;	} else {
	bra	L10706
L10704:
;		sys = 0x01;		/* FAT12 */
	sep	#$20
	longa	off
	lda	#$1
	sta	<L1043+sys_1
	rep	#$20
	longa	on
;	}
;
;	/* Update partition information */
;	if (FF_MULTI_PARTITION && ipart != 0) {	/* Volume is in the existing partition */
L10706:
;		if (!(fsopt & FM_SFD)) {			/* Create partition table if not in SFD format */
	sep	#$20
	longa	off
	lda	<L1043+fsopt_1
	and	#<$8
	rep	#$20
	longa	on
	bne	L10710
;		if (!FF_LBA64 || !(fsopt & 0x80)) {	/* Is the partition in MBR? */
;			/* Update system ID in the partition table */
;			if (disk_read(pdrv, buf, 0, 1) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);	/* Read the MBR */
;			buf[MBR_Table + (ipart - 1) * SZ_PTE + PTE_System] = sys;			/* Set system ID */
;			if (disk_write(pdrv, buf, 0, 1) != RES_OK) LEAVE_MKFS(FR_DISK_ERR);	/* Write it back to the MBR */
;		}
;	} else {								/* Volume as a new single partition */
;			lba[0] = sz_vol; lba[1] = 0;
	lda	<L1043+sz_vol_1
	sta	<L1043+lba_1
	lda	<L1043+sz_vol_1+2
	sta	<L1043+lba_1+2
	stz	<L1043+lba_1+4
	stz	<L1043+lba_1+6
;			res = create_partition(pdrv, lba, sys, buf);
	pei	<L1043+buf_1+2
	pei	<L1043+buf_1
	pei	<L1043+sys_1
	pea	#0
	clc
	tdc
	adc	#<L1043+lba_1
	pha
	pei	<L1043+pdrv_1
	jsr	_~create_partition
	sta	<L1043+res_1
;			if (res != FR_OK) LEAVE_MKFS(res);
	lda	<L1043+res_1
	bne	*+5
	brl	L10710
	lda	<L1043+res_1
	brl	L1048
;		}
;	}
;
;	LEAVE_MKFS(FR_OK);
;}
L1042	equ	114
L1043	equ	17
	ends
	efunc
	data
L1044:
	dw	$1,$4,$10,$40,$100,$200,$0
	ends
	data
L1045:
	dw	$1,$2,$4,$8,$10,$20,$0
	ends
	data
L1046:
	db	$7,$0
	dw	$0,$0
	dl	$0
	ends
	data
L482:
	db	$EB,$FFFFFFFE,$FFFFFF90,$4D,$53,$44,$4F,$53,$35,$2E,$30,$00,$4E,$4F,$20
	db	$4E,$41,$4D,$45,$20,$20,$20,$20,$46,$41,$54,$33,$32,$20,$20
	db	$20,$00,$4E,$4F,$20,$4E,$41,$4D,$45,$20,$20,$20,$20,$46,$41
	db	$54,$20,$20,$20,$20,$20,$00
	ends
;
;
;
;
;#if FF_MULTI_PARTITION
;/*-----------------------------------------------------------------------*/
;/* API: Create Partition Table on the Physical Drive                     */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_fdisk (
;	BYTE pdrv,			/* Physical drive number */
;	const LBA_t ptbl[],	/* Pointer to the size table for each partitions */
;	void* work			/* Pointer to the working buffer (null: use heap memory) */
;)
;{
;	BYTE *buf = (BYTE*)work;
;	DSTATUS stat;
;	FRESULT res;
;
;
;	/* Initialize the physical drive */
;	stat = disk_initialize(pdrv);
;	if (stat & STA_NOINIT) return FR_NOT_READY;
;	if (stat & STA_PROTECT) return FR_WRITE_PROTECTED;
;
;#if FF_USE_LFN == 3
;	if (!buf) buf = ff_memalloc(FF_MAX_SS);	/* Use heap memory for working buffer */
;#endif
;	if (!buf) return FR_NOT_ENOUGH_CORE;
;
;	res = create_partition(pdrv, ptbl, 0x07, buf);	/* Create partitions (system ID is temporary setting and determined by f_mkfs) */
;
;	LEAVE_MKFS(res);
;}
;
;#endif /* FF_MULTI_PARTITION */
;#endif /* !FF_FS_READONLY && FF_USE_MKFS */
;
;
;
;
;#if FF_USE_STRFUNC
;#if FF_USE_LFN && FF_LFN_UNICODE && (FF_STRF_ENCODE < 0 || FF_STRF_ENCODE > 3)
;#error Wrong FF_STRF_ENCODE setting
;#endif
;/*-----------------------------------------------------------------------*/
;/* API: Get a String from the File                                       */
;/*-----------------------------------------------------------------------*/
;
;TCHAR* f_gets (
;	TCHAR* buff,	/* Pointer to the buffer to store read string */
;	int len,		/* Size of string buffer (items) */
;	FIL* fp			/* Pointer to the file object */
;)
;{
;	int nc = 0;
;	TCHAR *p = buff;
;	BYTE s[4];
;	UINT rc;
;	DWORD dc;
;#if FF_USE_LFN && FF_LFN_UNICODE && FF_STRF_ENCODE <= 2
;	WCHAR wc;
;#endif
;#if FF_USE_LFN && FF_LFN_UNICODE && FF_STRF_ENCODE == 3
;	UINT ct;
;#endif
;
;#if FF_USE_LFN && FF_LFN_UNICODE			/* With code conversion (Unicode API) */
;	/* Make a room for the character and terminator  */
;	if (FF_LFN_UNICODE == 1) len -= (FF_STRF_ENCODE == 0) ? 1 : 2;
;	if (FF_LFN_UNICODE == 2) len -= (FF_STRF_ENCODE == 0) ? 3 : 4;
;	if (FF_LFN_UNICODE == 3) len -= 1;
;	while (nc < len) {
;#if FF_STRF_ENCODE == 0				/* Read a character in ANSI/OEM */
;		f_read(fp, s, 1, &rc);		/* Get a code unit */
;		if (rc != 1) break;			/* EOF? */
;		wc = s[0];
;		if (dbc_1st((BYTE)wc)) {	/* DBC 1st byte? */
;			f_read(fp, s, 1, &rc);	/* Get 2nd byte */
;			if (rc != 1 || !dbc_2nd(s[0])) continue;	/* Wrong code? */
;			wc = wc << 8 | s[0];
;		}
;		dc = ff_oem2uni(wc, CODEPAGE);	/* Convert ANSI/OEM into Unicode */
;		if (dc == 0) continue;		/* Conversion error? */
;#elif FF_STRF_ENCODE == 1 || FF_STRF_ENCODE == 2 	/* Read a character in UTF-16LE/BE */
;		f_read(fp, s, 2, &rc);		/* Get a code unit */
;		if (rc != 2) break;			/* EOF? */
;		dc = (FF_STRF_ENCODE == 1) ? ld_16(s) : s[0] << 8 | s[1];
;		if (IsSurrogateL(dc)) continue;	/* Broken surrogate pair? */
;		if (IsSurrogateH(dc)) {		/* High surrogate? */
;			f_read(fp, s, 2, &rc);	/* Get low surrogate */
;			if (rc != 2) break;		/* EOF? */
;			wc = (FF_STRF_ENCODE == 1) ? ld_16(s) : s[0] << 8 | s[1];
;			if (!IsSurrogateL(wc)) continue;	/* Broken surrogate pair? */
;			dc = ((dc & 0x3FF) + 0x40) << 10 | (wc & 0x3FF);	/* Merge surrogate pair */
;		}
;#else	/* Read a character in UTF-8 */
;		f_read(fp, s, 1, &rc);		/* Get a code unit */
;		if (rc != 1) break;			/* EOF? */
;		dc = s[0];
;		if (dc >= 0x80) {			/* Multi-byte sequence? */
;			ct = 0;
;			if ((dc & 0xE0) == 0xC0) {	/* 2-byte sequence? */
;				dc &= 0x1F; ct = 1;
;			}
;			if ((dc & 0xF0) == 0xE0) {	/* 3-byte sequence? */
;				dc &= 0x0F; ct = 2;
;			}
;			if ((dc & 0xF8) == 0xF0) {	/* 4-byte sequence? */
;				dc &= 0x07; ct = 3;
;			}
;			if (ct == 0) continue;
;			f_read(fp, s, ct, &rc);	/* Get trailing bytes */
;			if (rc != ct) break;
;			rc = 0;
;			do {	/* Merge the byte sequence */
;				if ((s[rc] & 0xC0) != 0x80) break;
;				dc = dc << 6 | (s[rc] & 0x3F);
;			} while (++rc < ct);
;			if (rc != ct || dc < 0x80 || IsSurrogate(dc) || dc >= 0x110000) continue;	/* Wrong encoding? */
;		}
;#endif
;		/* A code point is available in dc to be output */
;
;		if (FF_USE_STRFUNC == 2 && dc == '\r') continue;	/* Strip \r off if needed */
;#if FF_LFN_UNICODE == 1	|| FF_LFN_UNICODE == 3	/* Output it in UTF-16/32 encoding */
;		if (FF_LFN_UNICODE == 1 && dc >= 0x10000) {	/* Out of BMP at UTF-16? */
;			*p++ = (TCHAR)(0xD800 | ((dc >> 10) - 0x40)); nc++;	/* Make and output high surrogate */
;			dc = 0xDC00 | (dc & 0x3FF);		/* Make low surrogate */
;		}
;		*p++ = (TCHAR)dc; nc++;
;		if (dc == '\n') break;	/* End of line? */
;#elif FF_LFN_UNICODE == 2		/* Output it in UTF-8 encoding */
;		if (dc < 0x80) {	/* Single byte? */
;			*p++ = (TCHAR)dc;
;			nc++;
;			if (dc == '\n') break;	/* End of line? */
;		} else if (dc < 0x800) {	/* 2-byte sequence? */
;			*p++ = (TCHAR)(0xC0 | (dc >> 6 & 0x1F));
;			*p++ = (TCHAR)(0x80 | (dc >> 0 & 0x3F));
;			nc += 2;
;		} else if (dc < 0x10000) {	/* 3-byte sequence? */
;			*p++ = (TCHAR)(0xE0 | (dc >> 12 & 0x0F));
;			*p++ = (TCHAR)(0x80 | (dc >> 6 & 0x3F));
;			*p++ = (TCHAR)(0x80 | (dc >> 0 & 0x3F));
;			nc += 3;
;		} else {					/* 4-byte sequence */
;			*p++ = (TCHAR)(0xF0 | (dc >> 18 & 0x07));
;			*p++ = (TCHAR)(0x80 | (dc >> 12 & 0x3F));
;			*p++ = (TCHAR)(0x80 | (dc >> 6 & 0x3F));
;			*p++ = (TCHAR)(0x80 | (dc >> 0 & 0x3F));
;			nc += 4;
;		}
;#endif
;	}
;
;#else			/* Byte-by-byte read without any conversion (ANSI/OEM API) */
;	len -= 1;	/* Make a room for the terminator */
;	while (nc < len) {
;		f_read(fp, s, 1, &rc);	/* Get a byte */
;		if (rc != 1) break;		/* EOF? */
;		dc = s[0];
;		if (FF_USE_STRFUNC == 2 && dc == '\r') continue;
;		*p++ = (TCHAR)dc; nc++;
;		if (dc == '\n') break;
;	}
;#endif
;
;	*p = 0;		/* Terminate the string */
;	return nc ? buff : 0;	/* When no data read due to EOF or error, return with error. */
;}
;
;
;
;
;#if !FF_FS_READONLY
;#include <stdarg.h>
;#define SZ_PUTC_BUF	64
;#define SZ_NUM_BUF	32
;
;/*-----------------------------------------------------------------------*/
;/* API: Put a Character to the File (with sub-functions)                 */
;/*-----------------------------------------------------------------------*/
;
;/* Output buffer and work area */
;
;typedef struct {
;	FIL *fp;		/* Pointer to the writing file */
;	int idx, nchr;	/* Write index of buf[] (-1:error), number of written encoding units */
;#if FF_USE_LFN && FF_LFN_UNICODE == 1
;	WCHAR hs;
;#elif FF_USE_LFN && FF_LFN_UNICODE == 2
;	BYTE bs[4];
;	UINT wi, ct;
;#endif
;	BYTE buf[SZ_PUTC_BUF];	/* Write buffer */
;} putbuff;
;
;
;/* Buffered file write with code conversion */
;
;static void putc_bfd (putbuff* pb, TCHAR c)
;{
;	UINT n;
;	int i, nc;
;#if FF_USE_LFN && FF_LFN_UNICODE
;	WCHAR hs, wc;
;#if FF_LFN_UNICODE == 2
;	DWORD dc;
;	const TCHAR* tp;
;#endif
;#endif
;
;	if (FF_USE_STRFUNC == 2 && c == '\n') {	 /* LF -> CRLF conversion */
;		putc_bfd(pb, '\r');
;	}
;
;	i = pb->idx;			/* Write index of pb->buf[] */
;	if (i < 0) return;		/* In write error? */
;	nc = pb->nchr;			/* Write unit counter */
;
;#if FF_USE_LFN && FF_LFN_UNICODE
;#if FF_LFN_UNICODE == 1		/* UTF-16 input */
;	if (IsSurrogateH(c)) {	/* Is this a high-surrogate? */
;		pb->hs = c; return;	/* Save it for next */
;	}
;	hs = pb->hs; pb->hs = 0;
;	if (hs != 0) {			/* Is there a leading high-surrogate? */
;		if (!IsSurrogateL(c)) hs = 0;	/* Discard high-surrogate if a stray high-surrogate */
;	} else {
;		if (IsSurrogateL(c)) return;	/* Discard stray low-surrogate */
;	}
;	wc = c;
;#elif FF_LFN_UNICODE == 2	/* UTF-8 input */
;	for (;;) {
;		if (pb->ct == 0) {	/* Not in the multi-byte sequence? */
;			pb->bs[pb->wi = 0] = (BYTE)c;	/* Save 1st byte */
;			if ((BYTE)c < 0x80) break;					/* Single byte code? */
;			if (((BYTE)c & 0xE0) == 0xC0) pb->ct = 1;	/* 2-byte sequence? */
;			if (((BYTE)c & 0xF0) == 0xE0) pb->ct = 2;	/* 3-byte sequence? */
;			if (((BYTE)c & 0xF8) == 0xF0) pb->ct = 3;	/* 4-byte sequence? */
;			return;										/* Invalid leading byte (discard it) */
;		} else {				/* In the multi-byte sequence */
;			if (((BYTE)c & 0xC0) != 0x80) {	/* Broken sequence? */
;				pb->ct = 0; continue;		/* Discard the sequence */
;			}
;			pb->bs[++pb->wi] = (BYTE)c;	/* Save the trailing byte */
;			if (--pb->ct == 0) break;	/* End of the sequence? */
;			return;
;		}
;	}
;	tp = (const TCHAR*)pb->bs;
;	dc = tchar2uni(&tp);			/* UTF-8 ==> UTF-16 */
;	if (dc == 0xFFFFFFFF) return;	/* Wrong code? */
;	hs = (WCHAR)(dc >> 16);
;	wc = (WCHAR)dc;
;#elif FF_LFN_UNICODE == 3	/* UTF-32 input */
;	if (IsSurrogate(c) || c >= 0x110000) return;	/* Discard invalid code */
;	if (c >= 0x10000) {		/* Out of BMP? */
;		hs = (WCHAR)(0xD800 | ((c >> 10) - 0x40)); 	/* Make high surrogate */
;		wc = 0xDC00 | (c & 0x3FF);					/* Make low surrogate */
;	} else {
;		hs = 0;
;		wc = (WCHAR)c;
;	}
;#endif
;	/* A code point in UTF-16 is available in hs and wc */
;
;#if FF_STRF_ENCODE == 1		/* Write a code point in UTF-16LE */
;	if (hs != 0) {	/* Surrogate pair? */
;		st_16(&pb->buf[i], hs);
;		i += 2;
;		nc++;
;	}
;	st_16(&pb->buf[i], wc);
;	i += 2;
;#elif FF_STRF_ENCODE == 2	/* Write a code point in UTF-16BE */
;	if (hs != 0) {	/* Surrogate pair? */
;		pb->buf[i++] = (BYTE)(hs >> 8);
;		pb->buf[i++] = (BYTE)hs;
;		nc++;
;	}
;	pb->buf[i++] = (BYTE)(wc >> 8);
;	pb->buf[i++] = (BYTE)wc;
;#elif FF_STRF_ENCODE == 3	/* Write a code point in UTF-8 */
;	if (hs != 0) {	/* 4-byte sequence? */
;		nc += 3;
;		hs = (hs & 0x3FF) + 0x40;
;		pb->buf[i++] = (BYTE)(0xF0 | hs >> 8);
;		pb->buf[i++] = (BYTE)(0x80 | (hs >> 2 & 0x3F));
;		pb->buf[i++] = (BYTE)(0x80 | (hs & 3) << 4 | (wc >> 6 & 0x0F));
;		pb->buf[i++] = (BYTE)(0x80 | (wc & 0x3F));
;	} else {
;		if (wc < 0x80) {	/* Single byte? */
;			pb->buf[i++] = (BYTE)wc;
;		} else {
;			if (wc < 0x800) {	/* 2-byte sequence? */
;				nc += 1;
;				pb->buf[i++] = (BYTE)(0xC0 | wc >> 6);
;			} else {			/* 3-byte sequence */
;				nc += 2;
;				pb->buf[i++] = (BYTE)(0xE0 | wc >> 12);
;				pb->buf[i++] = (BYTE)(0x80 | (wc >> 6 & 0x3F));
;			}
;			pb->buf[i++] = (BYTE)(0x80 | (wc & 0x3F));
;		}
;	}
;#else						/* Write a code point in ANSI/OEM */
;	if (hs != 0) return;
;	wc = ff_uni2oem(wc, CODEPAGE);	/* UTF-16 ==> ANSI/OEM */
;	if (wc == 0) return;
;	if (wc >= 0x100) {
;		pb->buf[i++] = (BYTE)(wc >> 8); nc++;
;	}
;	pb->buf[i++] = (BYTE)wc;
;#endif
;
;#else							/* ANSI/OEM input (without re-encoding) */
;	pb->buf[i++] = (BYTE)c;
;#endif
;
;	if (i >= (int)(sizeof pb->buf) - 4) {	/* Write buffered characters to the file */
;		f_write(pb->fp, pb->buf, (UINT)i, &n);
;		i = (n == (UINT)i) ? 0 : -1;
;	}
;	pb->idx = i;
;	pb->nchr = nc + 1;
;}
;
;
;/* Flush characters left in the buffer and return number of characters written */
;
;static int putc_flush (putbuff* pb)
;{
;	UINT nw;
;
;	if (   pb->idx >= 0	/* Flush buffered characters to the file */
;		&& f_write(pb->fp, pb->buf, (UINT)pb->idx, &nw) == FR_OK
;		&& (UINT)pb->idx == nw) {
;		return pb->nchr;
;	}
;	return -1;
;}
;
;
;/* Initialize write buffer */
;
;static void putc_init (putbuff* pb, FIL* fp)
;{
;	memset(pb, 0, sizeof (putbuff));
;	pb->fp = fp;
;}
;
;
;
;int f_putc (
;	TCHAR c,	/* A character to be output */
;	FIL* fp		/* Pointer to the file object */
;)
;{
;	putbuff pb;
;
;
;	putc_init(&pb, fp);
;	putc_bfd(&pb, c);	/* Put the character */
;	return putc_flush(&pb);
;}
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Put a String to the File                                         */
;/*-----------------------------------------------------------------------*/
;
;int f_puts (
;	const TCHAR* str,	/* Pointer to the string to be output */
;	FIL* fp				/* Pointer to the file object */
;)
;{
;	putbuff pb;
;
;
;	putc_init(&pb, fp);
;	while (*str) putc_bfd(&pb, *str++);		/* Put the string */
;	return putc_flush(&pb);
;}
;
;
;
;
;/*-----------------------------------------------------------------------*/
;/* API: Put a Formatted String to the File (with sub-functions)          */
;/*-----------------------------------------------------------------------*/
;#if FF_PRINT_FLOAT && FF_INTDEF == 2
;#include <math.h>
;
;static int ilog10 (double n)	/* Calculate log10(n) in integer output */
;{
;	int rv = 0;
;
;	while (n >= 10) {	/* Decimate digit in right shift */
;		if (n >= 100000) {
;			n /= 100000; rv += 5;
;		} else {
;			n /= 10; rv++;
;		}
;	}
;	while (n < 1) {		/* Decimate digit in left shift */
;		if (n < 0.00001) {
;			n *= 100000; rv -= 5;
;		} else {
;			n *= 10; rv--;
;		}
;	}
;	return rv;
;}
;
;
;static double i10x (int n)	/* Calculate 10^n in integer input */
;{
;	double rv = 1;
;
;	while (n > 0) {		/* Left shift */
;		if (n >= 5) {
;			rv *= 100000; n -= 5;
;		} else {
;			rv *= 10; n--;
;		}
;	}
;	while (n < 0) {		/* Right shift */
;		if (n <= -5) {
;			rv /= 100000; n += 5;
;		} else {
;			rv /= 10; n++;
;		}
;	}
;	return rv;
;}
;
;
;static void ftoa (
;	char* buf,	/* Buffer to output the floating point string */
;	double val,	/* Value to output */
;	int prec,	/* Number of fractional digits */
;	TCHAR fmt	/* Notation */
;)
;{
;	int digit;
;	int exp = 0, mag = 0;
;	char sign = 0;
;	double w;
;	const char *er = 0;
;	const char ds = FF_PRINT_FLOAT == 2 ? ',' : '.';
;
;
;	if (isnan(val)) {			/* Not a number? */
;		er = "NaN";
;	} else {
;		if (prec < 0) prec = 6;	/* Default precision? (6 fractional digits) */
;		if (val < 0) {			/* Negative? */
;			val = 0 - val; sign = '-';
;		} else {
;			sign = '+';
;		}
;		if (isinf(val)) {		/* Infinite? */
;			er = "INF";
;		} else {
;			if (fmt == 'f') {	/* Decimal notation? */
;				val += i10x(0 - prec) / 2;	/* Round (nearest) */
;				mag = ilog10(val);
;				if (mag < 0) mag = 0;
;				if (mag + prec + 3 >= SZ_NUM_BUF) er = "OV";	/* Buffer overflow? */
;			} else {			/* E notation */
;				if (val != 0) {		/* Not a true zero? */
;					val += i10x(ilog10(val) - prec) / 2;	/* Round (nearest) */
;					exp = ilog10(val);
;					if (exp > 99 || prec + 7 >= SZ_NUM_BUF) {	/* Buffer overflow or E > +99? */
;						er = "OV";
;					} else {
;						if (exp < -99) exp = -99;
;						val /= i10x(exp);	/* Normalize */
;					}
;				}
;			}
;		}
;		if (!er) {	/* Not error condition */
;			if (sign == '-') *buf++ = sign;	/* Add a - if negative value */
;			do {				/* Put decimal number */
;				if (mag == -1) *buf++ = ds;	/* Insert a decimal separator when get into fractional part */
;				w = i10x(mag);				/* Snip the highest digit d */
;				digit = (int)(val / w); val -= digit * w;
;				*buf++ = (char)('0' + digit);	/* Put the digit */
;			} while (--mag >= -prec);		/* Output all digits specified by prec */
;			if (fmt != 'f') {	/* Put exponent if needed */
;				*buf++ = (char)fmt;
;				if (exp < 0) {
;					exp = 0 - exp; *buf++ = '-';
;				} else {
;					*buf++ = '+';
;				}
;				*buf++ = (char)('0' + exp / 10);
;				*buf++ = (char)('0' + exp % 10);
;			}
;		}
;	}
;	if (er) {	/* Error condition */
;		if (sign) *buf++ = sign;		/* Add sign if needed */
;		do {		/* Put error symbol */
;			*buf++ = *er++;
;		} while (*er);
;	}
;	*buf = 0;	/* Term */
;}
;#endif	/* FF_PRINT_FLOAT && FF_INTDEF == 2 */
;
;
;
;int f_printf (
;	FIL* fp,			/* Pointer to the file object */
;	const TCHAR* fmt,	/* Pointer to the format string */
;	...					/* Optional arguments... */
;)
;{
;	va_list arp;
;	putbuff pb;
;	UINT i, j, width, flag, radix;
;	int prec;
;#if FF_PRINT_LLI && FF_INTDEF == 2
;	QWORD val;
;#else
;	DWORD val;
;#endif
;	TCHAR *tp;
;	TCHAR chr, pad;
;	TCHAR nul = 0;
;	char digit, str[SZ_NUM_BUF];
;
;
;	putc_init(&pb, fp);
;
;	va_start(arp, fmt);
;
;	for (;;) {
;		chr = *fmt++;
;		if (chr == 0) break;		/* End of format string */
;		if (chr != '%') {			/* Not an escape character (pass-through) */
;			putc_bfd(&pb, chr);
;			continue;
;		}
;		flag = width = 0; pad = ' '; prec = -1;	/* Initialize the parameters */
;		chr = *fmt++;
;		if (chr == '0') {			/* Flag: '0' padded */
;			pad = '0'; chr = *fmt++;
;		} else if (chr == '-') {	/* Flag: Left aligned */
;			flag = 2; chr = *fmt++;
;		}
;		if (chr == '*') {			/* Minimum width from an argument */
;			width = (UINT)va_arg(arp, int);
;			chr = *fmt++;
;		} else {
;			while (IsDigit(chr)) {	/* Minimum width */
;				width = width * 10 + chr - '0';
;				chr = *fmt++;
;			}
;		}
;		if (chr == '.') {			/* Precision */
;			chr = *fmt++;
;			if (chr == '*') {		/* Precision from an argument */
;				prec = va_arg(arp, int);
;				chr = *fmt++;
;			} else {
;				prec = 0;
;				while (IsDigit(chr)) {	/* Precision */
;					prec = prec * 10 + chr - '0';
;					chr = *fmt++;
;				}
;			}
;		}
;		if (chr == 'l') {			/* Size: long int */
;			flag |= 4; chr = *fmt++;
;#if FF_PRINT_LLI && FF_INTDEF == 2
;			if (chr == 'l') {		/* Size: long long int */
;				flag |= 8; chr = *fmt++;
;			}
;#endif
;		}
;		if (chr == 0) break;		/* End of format string */
;		switch (chr) {				/* Atgument type is... */
;		case 'b':					/* Unsigned binary */
;			radix = 2; break;
;
;		case 'o':					/* Unsigned octal */
;			radix = 8; break;
;
;		case 'd':					/* Signed decimal */
;		case 'u': 					/* Unsigned decimal */
;			radix = 10; break;
;
;		case 'x':					/* Unsigned hexadecimal (lower case) */
;		case 'X': 					/* Unsigned hexadecimal (upper case) */
;			radix = 16; break;
;
;		case 'c':					/* Character */
;			putc_bfd(&pb, (TCHAR)va_arg(arp, int));
;			continue;
;
;		case 's':					/* String */
;			tp = va_arg(arp, TCHAR*);	/* Get a pointer argument */
;			if (!tp) tp = &nul;			/* Null pointer generates a null string */
;			for (j = 0; tp[j]; j++) ;	/* j = tcslen(tp) */
;			if (prec >= 0 && j > (UINT)prec) j = (UINT)prec;	/* Limited length of string body */
;			for ( ; !(flag & 2) && j < width; j++) putc_bfd(&pb, pad);	/* Left padding */
;			while (*tp && prec--) putc_bfd(&pb, *tp++);		/* Body */
;			while (j++ < width) putc_bfd(&pb, ' ');			/* Right padding */
;			continue;
;#if FF_PRINT_FLOAT && FF_INTDEF == 2
;		case 'f':					/* Floating point (decimal) */
;		case 'e':					/* Floating point (e) */
;		case 'E':					/* Floating point (E) */
;			ftoa(str, va_arg(arp, double), prec, chr);		/* Make a floating point string */
;			for (j = strlen(str); !(flag & 2) && j < width; j++) putc_bfd(&pb, pad);	/* Leading pads */
;			for (i = 0; str[i]; putc_bfd(&pb, str[i++])) ;	/* Body */
;			while (j++ < width) putc_bfd(&pb, ' ');			/* Trailing pads */
;			continue;
;#endif
;		default:					/* Unknown type (pass-through) */
;			putc_bfd(&pb, chr);
;			continue;
;		}
;
;		/* Get an integer argument and put it in numeral */
;#if FF_PRINT_LLI && FF_INTDEF == 2
;		if (flag & 8) {		/* long long argument? */
;			val = (QWORD)va_arg(arp, long long);
;		} else if (flag & 4) {	/* long argument? */
;			val = (chr == 'd') ? (QWORD)(long long)va_arg(arp, long) : (QWORD)va_arg(arp, unsigned long);
;		} else {			/* int/short/char argument */
;			val = (chr == 'd') ? (QWORD)(long long)va_arg(arp, int) : (QWORD)va_arg(arp, unsigned int);
;		}
;		if (chr == 'd' && (val & 0x8000000000000000)) {	/* Negative value? */
;			val = 0 - val; flag |= 1;
;		}
;#else
;		if (flag & 4) {	/* long argument? */
;			val = (DWORD)va_arg(arp, long);
;		} else {		/* int/short/char argument */
;			val = (chr == 'd') ? (DWORD)(long)va_arg(arp, int) : (DWORD)va_arg(arp, unsigned int);
;		}
;		if (chr == 'd' && (val & 0x80000000)) {	/* Negative value? */
;			val = 0 - val; flag |= 1;
;		}
;#endif
;		i = 0;
;		do {	/* Make an integer number string */
;			digit = (char)(val % radix) + '0'; val /= radix;
;			if (digit > '9') digit += (chr == 'x') ? 0x27 : 0x07;
;			str[i++] = digit;
;		} while (val && i < SZ_NUM_BUF);
;		if (flag & 1) str[i++] = '-';	/* Sign */
;		/* Write it */
;		for (j = i; !(flag & 2) && j < width; j++) {	/* Leading pads */
;			putc_bfd(&pb, pad);
;		}
;		do {					/* Body */
;			putc_bfd(&pb, (TCHAR)str[--i]);
;		} while (i);
;		while (j++ < width) {	/* Trailing pads */
;			putc_bfd(&pb, ' ');
;		}
;	}
;
;	va_end(arp);
;
;	return putc_flush(&pb);
;}
;
;#endif /* !FF_FS_READONLY */
;#endif /* FF_USE_STRFUNC */
;
;
;
;#if FF_CODE_PAGE == 0
;/*-----------------------------------------------------------------------*/
;/* API: Set Active Codepage for the Path Name                            */
;/*-----------------------------------------------------------------------*/
;
;FRESULT f_setcp (
;	WORD cp		/* Value to be set as active code page */
;)
;{
;	static const WORD       validcp[22] = {  437,   720,   737,   771,   775,   850,   852,   855,   857,   860,   861,   862,   863,   864,   865,   866,   869,   932,   936,   949,   950, 0};
;	static const BYTE *const tables[22] = {Ct437, Ct720, Ct737, Ct771, Ct775, Ct850, Ct852, Ct855, Ct857, Ct860, Ct861, Ct862, Ct863, Ct864, Ct865, Ct866, Ct869, Dc932, Dc936, Dc949, Dc950, 0};
;	UINT i;
;
;
;	for (i = 0; validcp[i] != 0 && validcp[i] != cp; i++) ;	/* Find the code page */
;	if (validcp[i] != cp) return FR_INVALID_PARAMETER;		/* Not found? */
;
;	CodePage = cp;
;	if (cp >= 900) {	/* DBCS */
;		ExCvt = 0;
;		DbcTbl = tables[i];
;	} else {			/* SBCS */
;		ExCvt = tables[i];
;		DbcTbl = 0;
;	}
;	return FR_OK;
;}
;#endif	/* FF_CODE_PAGE == 0 */
;
;
	xref	_~disk_ioctl
	xref	_~disk_write
	xref	_~disk_read
	xref	_~disk_status
	xref	_~disk_initialize
	xref	_~ff_mutex_give
	xref	_~ff_mutex_take
	xref	_~ff_mutex_delete
	xref	_~ff_mutex_create
	xref	_~strchr
	xref	_~memset
	xref	_~memcpy
	xref	_~memcmp
	udata
_~SysLockVolume
	ds	1
	ends
	udata
_~SysLock
	ds	1
	ends
	udata
_~Files
	ds	448
	ends
	udata
_~CurrVol
	ds	1
	ends
	udata
_~Fsid
	ds	2
	ends
	udata
_~FatFs
	ds	4
	ends
