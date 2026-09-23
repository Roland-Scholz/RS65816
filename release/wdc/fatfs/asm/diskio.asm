;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;/*-----------------------------------------------------------------------*/
;/* Low level disk I/O module SKELETON for FatFs     (C)ChaN, 2025        */
;/*-----------------------------------------------------------------------*/
;/* If a working storage control module is available, it should be        */
;/* attached to the FatFs via a glue function rather than modifying it.   */
;/* This is an example of glue functions to attach various exsisting      */
;/* storage control modules to the FatFs module with a defined API.       */
;/*-----------------------------------------------------------------------*/
;
;#include <stdio.h>
;#include "ff.h"			/* Basic definitions of FatFs */
;#include "diskio.h"		/* Declarations FatFs MAI */
;
;/* Example: Declarations of the platform and disk functions in the project */
;//#include "platform.h"
;//#include "storage.h"
;
;/* Example: Mapping of physical drive number for each drive */
;#define DEV_FLASH	0	/* Map FTL to physical drive 0 */
;#define DEV_MMC		1	/* Map MMC/SD card to physical drive 1 */
;#define DEV_USB		2	/* Map USB MSD to physical drive 2 */
;
;#define DEV_RAM		3
;
;/*-----------------------------------------------------------------------*/
;/* Get Drive Status                                                      */
;/*-----------------------------------------------------------------------*/
;
;DSTATUS disk_status (
;	BYTE pdrv		/* Physical drive nmuber to identify the drive */
;)
;{
	code
	xdef	_~disk_status
	func
_~disk_status:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
pdrv_0	set	3
;	DSTATUS stat;
;	int result;
;
;	printf("disk_status 0x%02x\n", pdrv);
stat_1	set	0
result_1	set	1
	lda	<L2+pdrv_0
	and	#$ff
	pha
	pea	#^L1
	pea	#<L1
	pea	#8
	jsr	_~printf
;	
;	return RES_OK;
	lda	#$0
	tay
	lda	<L2+1
	sta	<L2+1+2
	pld
	tsc
	clc
	adc	#L2+2
	tcs
	tya
	rts
;
;/*
;	switch (pdrv) {
;	case DEV_RAM :
;		result = RAM_disk_status();
;
;		// translate the reslut code here
;
;		return stat;
;
;	case DEV_MMC :
;		result = MMC_disk_status();
;
;		// translate the reslut code here
;
;		return stat;
;
;	case DEV_USB :
;		result = USB_disk_status();
;
;		// translate the reslut code here
;
;		return stat;
;	}
;	return STA_NOINIT;
;	*/
;}
L2	equ	3
L3	equ	1
	ends
	efunc
	data
L1:
	db	$64,$69,$73,$6B,$5F,$73,$74,$61,$74,$75,$73,$20,$30,$78,$25
	db	$30,$32,$78,$0A,$00
	ends
;
;
;
;/*-----------------------------------------------------------------------*/
;/* Inidialize a Drive                                                    */
;/*-----------------------------------------------------------------------*/
;
;DSTATUS disk_initialize (
;	BYTE pdrv				/* Physical drive nmuber to identify the drive */
;)
;{
	code
	xdef	_~disk_initialize
	func
_~disk_initialize:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L6
	tcs
	phd
	tcd
pdrv_0	set	3
;	DSTATUS stat;
;	int result;
;
;	printf("disk_initialize 0x%02x\n", pdrv);
stat_1	set	0
result_1	set	1
	lda	<L6+pdrv_0
	and	#$ff
	pha
	pea	#^L5
	pea	#<L5
	pea	#8
	jsr	_~printf
;	
;	return RES_OK;
	lda	#$0
	tay
	lda	<L6+1
	sta	<L6+1+2
	pld
	tsc
	clc
	adc	#L6+2
	tcs
	tya
	rts
;/*
;	switch (pdrv) {
;	case DEV_RAM :
;		result = RAM_disk_initialize();
;
;		// translate the reslut code here
;
;		return stat;
;
;	case DEV_MMC :
;		result = MMC_disk_initialize();
;
;		// translate the reslut code here
;
;		return stat;
;
;	case DEV_USB :
;		result = USB_disk_initialize();
;
;		// translate the reslut code here
;
;		return stat;
;	}
;	return STA_NOINIT;
;*/
;}
L6	equ	3
L7	equ	1
	ends
	efunc
	data
L5:
	db	$64,$69,$73,$6B,$5F,$69,$6E,$69,$74,$69,$61,$6C,$69,$7A,$65
	db	$20,$30,$78,$25,$30,$32,$78,$0A,$00
	ends
;
;
;
;/*-----------------------------------------------------------------------*/
;/* Read Sector(s)                                                        */
;/*-----------------------------------------------------------------------*/
;
;DRESULT disk_read (
;	BYTE pdrv,		/* Physical drive nmuber to identify the drive */
;	BYTE *buff,		/* Data buffer to store read data */
;	LBA_t sector,	/* Start sector in LBA */
;	UINT count		/* Number of sectors to read */
;)
;{
	code
	xdef	_~disk_read
	func
_~disk_read:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L10
	tcs
	phd
	tcd
pdrv_0	set	3
buff_0	set	5
sector_0	set	9
count_0	set	13
;	DRESULT res;
;	int result;
;
;	printf("disk_read 0x%02x, buffer:%p, sector:%p, count:0x%04x\n", pdrv, buff, sector, count);
res_1	set	0
result_1	set	2
	pei	<L10+count_0
	pei	<L10+sector_0+2
	pei	<L10+sector_0
	pei	<L10+buff_0+2
	pei	<L10+buff_0
	lda	<L10+pdrv_0
	and	#$ff
	pha
	pea	#^L9
	pea	#<L9
	pea	#18
	jsr	_~printf
;	
;	return RES_OK;
	lda	#$0
	tay
	lda	<L10+1
	sta	<L10+1+12
	pld
	tsc
	clc
	adc	#L10+12
	tcs
	tya
	rts
;	/*
;	switch (pdrv) {
;	case DEV_RAM :
;		// translate the arguments here
;
;		result = RAM_disk_read(buff, sector, count);
;
;		// translate the reslut code here
;
;		return res;
;
;	case DEV_MMC :
;		// translate the arguments here
;
;		result = MMC_disk_read(buff, sector, count);
;
;		// translate the reslut code here
;
;		return res;
;
;	case DEV_USB :
;		// translate the arguments here
;
;		result = USB_disk_read(buff, sector, count);
;
;		// translate the reslut code here
;
;		return res;
;	}
;
;	return RES_PARERR;
;	*/
;}
L10	equ	4
L11	equ	1
	ends
	efunc
	data
L9:
	db	$64,$69,$73,$6B,$5F,$72,$65,$61,$64,$20,$30,$78,$25,$30,$32
	db	$78,$2C,$20,$62,$75,$66,$66,$65,$72,$3A,$25,$70,$2C,$20,$73
	db	$65,$63,$74,$6F,$72,$3A,$25,$70,$2C,$20,$63,$6F,$75,$6E,$74
	db	$3A,$30,$78,$25,$30,$34,$78,$0A,$00
	ends
;
;
;
;/*-----------------------------------------------------------------------*/
;/* Write Sector(s)                                                       */
;/*-----------------------------------------------------------------------*/
;
;#if FF_FS_READONLY == 0
;
;DRESULT disk_write (
;	BYTE pdrv,			/* Physical drive nmuber to identify the drive */
;	const BYTE *buff,	/* Data to be written */
;	LBA_t sector,		/* Start sector in LBA */
;	UINT count			/* Number of sectors to write */
;)
;{
	code
	xdef	_~disk_write
	func
_~disk_write:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L14
	tcs
	phd
	tcd
pdrv_0	set	3
buff_0	set	5
sector_0	set	9
count_0	set	13
;	DRESULT res;
;	int result;
;	
;	printf("disk_write 0x%02x, buffer:%p, sector:%p, count:0x%04x\n", pdrv, buff, sector, count);
res_1	set	0
result_1	set	2
	pei	<L14+count_0
	pei	<L14+sector_0+2
	pei	<L14+sector_0
	pei	<L14+buff_0+2
	pei	<L14+buff_0
	lda	<L14+pdrv_0
	and	#$ff
	pha
	pea	#^L13
	pea	#<L13
	pea	#18
	jsr	_~printf
;	
;	return RES_OK;
	lda	#$0
	tay
	lda	<L14+1
	sta	<L14+1+12
	pld
	tsc
	clc
	adc	#L14+12
	tcs
	tya
	rts
;
;/*
;	switch (pdrv) {
;	case DEV_RAM :
;		// translate the arguments here
;
;		result = RAM_disk_write(buff, sector, count);
;
;		// translate the reslut code here
;
;		return res;
;
;	case DEV_MMC :
;		// translate the arguments here
;
;		result = MMC_disk_write(buff, sector, count);
;
;		// translate the reslut code here
;
;		return res;
;
;	case DEV_USB :
;		// translate the arguments here
;
;		result = USB_disk_write(buff, sector, count);
;
;		// translate the reslut code here
;
;		return res;
;	}
;
;	return RES_PARERR;
;*/
;}
L14	equ	4
L15	equ	1
	ends
	efunc
	data
L13:
	db	$64,$69,$73,$6B,$5F,$77,$72,$69,$74,$65,$20,$30,$78,$25,$30
	db	$32,$78,$2C,$20,$62,$75,$66,$66,$65,$72,$3A,$25,$70,$2C,$20
	db	$73,$65,$63,$74,$6F,$72,$3A,$25,$70,$2C,$20,$63,$6F,$75,$6E
	db	$74,$3A,$30,$78,$25,$30,$34,$78,$0A,$00
	ends
;
;#endif
;
;
;/*-----------------------------------------------------------------------*/
;/* Miscellaneous Functions                                               */
;/*-----------------------------------------------------------------------*/
;
;DRESULT disk_ioctl (
;	BYTE pdrv,		/* Physical drive nmuber (0..) */
;	BYTE cmd,		/* Control code */
;	void *buff		/* Buffer to send/receive control data */
;)
;{
	code
	xdef	_~disk_ioctl
	func
_~disk_ioctl:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L18
	tcs
	phd
	tcd
pdrv_0	set	3
cmd_0	set	5
buff_0	set	7
;	DRESULT res;
;	int result;
;
;	printf("disk_ioctl 0x%02x, cmd:0x%02x, buffer:%p \n", pdrv, cmd, buff);
res_1	set	0
result_1	set	2
	pei	<L18+buff_0+2
	pei	<L18+buff_0
	lda	<L18+cmd_0
	and	#$ff
	pha
	lda	<L18+pdrv_0
	and	#$ff
	pha
	pea	#^L17
	pea	#<L17
	pea	#14
	jsr	_~printf
;	
;	return RES_OK;
	lda	#$0
	tay
	lda	<L18+1
	sta	<L18+1+8
	pld
	tsc
	clc
	adc	#L18+8
	tcs
	tya
	rts
;/*
;	switch (pdrv) {
;	case DEV_RAM :
;
;		// Process of the command for the RAM drive
;
;		return res;
;
;	case DEV_MMC :
;
;		// Process of the command for the MMC/SD card
;
;		return res;
;
;	case DEV_USB :
;
;		// Process of the command the USB drive
;
;		return res;
;	}
;
;	return RES_PARERR;
;*/
;}
L18	equ	4
L19	equ	1
	ends
	efunc
	data
L17:
	db	$64,$69,$73,$6B,$5F,$69,$6F,$63,$74,$6C,$20,$30,$78,$25,$30
	db	$32,$78,$2C,$20,$63,$6D,$64,$3A,$30,$78,$25,$30,$32,$78,$2C
	db	$20,$62,$75,$66,$66,$65,$72,$3A,$25,$70,$20,$0A,$00
	ends
;
;
	xref	_~printf
