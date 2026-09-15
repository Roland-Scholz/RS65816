@echo off
set COMPILER=wdc
set WDC=C:\github\atari-tools\WDC
set WDC_INC_65816=%WDC%\include;C:\github\RS65816\src
set WDC_LIB=%WDC%\lib
path=%PATH%;%WDC%\bin

set HOME=C:\github\RS65816
set PROJ=monitor
set SRC=%HOME%\src
set REL=%HOME%\release\%COMPILER%\%PROJ%
set LST=%REL%\lst
set OBJ=%REL%\obj
set ASM=%REL%\asm

set MODULES=main monitor
set CFLAGS=-A -LT -MC -SOP0S -D__WDC__
set LFLAGS=-T -HB -C0200
set EXE=monitor

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
set RC=%ERRORLEVEL%
wdc816as -O %OBJ%\%1.o -LW %ASM%\%1.asm
exit /b

:error
pause

:eof
