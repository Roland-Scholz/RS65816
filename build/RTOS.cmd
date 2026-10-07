@echo off
set COMPILER=wdc
set WDC=C:\github\atari-tools\WDC
path=%PATH%;%WDC%\bin

set HOME=C:\github\RS65816

set PROJ=rtos
set SRC=%HOME%\src
set REL=%HOME%\release\%COMPILER%\%PROJ%
set LST=%REL%\lst
set OBJ=%REL%\obj
set ASM=%REL%\asm

set WDC_INC_65816=%WDC%\include;%HOME%\src;%HOME%\src\include;%SRC%\include;%SRC%\portable\WDC65816;%HOME%\src\fatfs\source
set WDC_LIB=%WDC%\lib;%OBJ%\..\..\fatfs\obj

echo WDC_INC=%WDC_INC_65816%

rem event_groups stream_buffer timers 

rem ************************************************************
rem * set C and Assembler modules here
rem ************************************************************
set CMODULES=rtos65816 printf_stdarg queue tasks list heapStack heap_5 farheap
set AMODULES=port65816

set CFLAGS=-A -LT -MC -SOP0S -D__WDC__
set LFLAGS=-T -HB -C010000,0 -V
set EXE=rtos

del /s /q *.tmp	>nul 2>&1
del /s /q %LST%\*.* >nul 2>&1
del /s /q %OBJ%\*.* >nul 2>&1
del /s /q %ASM%\*.* >nul 2>&1

setlocal enabledelayedexpansion

rem ************************************************************
rem * loop through C modules
rem ************************************************************
call process_list compile "%CMODULES%"

rem ************************************************************
rem * loop through Assembler modules
rem ************************************************************
call process_list assemble "%AMODULES%"

set OBJS=%OBJS% diskio.o ff.o ffsystem.o

move %ASM%\*.lst %LST% >nul 2>&1
move %SRC%\*.lst %LST% >nul 2>&1

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

:error
pause

:eof
rem pause