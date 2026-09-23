@echo off
set COMPILER=wdc
set WDC=C:\github\atari-tools\WDC
path=%PATH%;%WDC%\bin

set HOME=C:\github\RS65816

set PROJ=rtos
set SRC=%HOME%\FreeRTOS-LTS\FreeRTOS\FreeRTOS-Kernel
set REL=%HOME%\release\%COMPILER%\%PROJ%
set LST=%REL%\lst
set OBJ=%REL%\obj
set ASM=%REL%\asm

set WDC_INC_65816=%WDC%\include;%HOME%\src;%HOME%\src\include;%SRC%\include;%SRC%\portable\WDC65816;%HOME%\src\fatfs\source
set WDC_LIB=%WDC%\lib;%OBJ%\..\..\fatfs\obj

echo WDC_INC=%WDC_INC_65816%

set MODULES=rtos65816 printf_stdarg event_groups list queue stream_buffer tasks timers heapStack heap_5

set CFLAGS=-A -LT -MC -SOP0S -D__WDC__
set LFLAGS=-T -HB -C010000,0 -V
set EXE=rtos

del /s /q *.tmp	>nul 2>&1
del /s /q %LST%\*.* >nul 2>&1
del /s /q %OBJ%\*.* >nul 2>&1
del /s /q %ASM%\*.* >nul 2>&1

set LIST=%MODULES%
setlocal enabledelayedexpansion
:loop
for /F "tokens=1*" %%i in ("%LIST%") do (
	call :compile %%i
	if !RC! NEQ 0 goto error
	set LIST=%%j
	set OBJS=%OBJS% %%i.o
)
if defined LIST goto loop

echo wdc816as -O %OBJ%\port65816.o -LW %SRC%\port65816.asm
wdc816as -O %OBJ%\port65816.o -LW %SRC%\port65816.asm
set OBJS=%OBJS% port65816.o diskio.o ff.o ffsystem.o

move %ASM%\*.lst %LST% >nul 2>&1

pushd
cd %OBJ%
echo ************************************************************
echo linking
echo wdcln %LFLAGS% %OBJS% cc.lib -o %REL%\%EXE%.bin
echo ************************************************************
wdcln %LFLAGS% %OBJS% cc.lib -o %REL%\%EXE%.bin
popd
if %ERRORLEVEL% NEQ 0 goto error
goto eof
	
:compile
echo ************************************************************
echo compiling %1.c
echo wdc816cc %CFLAGS% %SRC%\%1.c -o %ASM%\%1.asm
echo ************************************************************
wdc816cc %CFLAGS% %SRC%\%1.c -o %ASM%\%1.asm
echo RC:%ERRORLEVEL%
set RC=%ERRORLEVEL%
if !RC! NEQ 0 goto error 
wdc816as -O %OBJ%\%1.o -LW %ASM%\%1.asm
set RC=%ERRORLEVEL%
exit /b

:error
pause

:eof
pause