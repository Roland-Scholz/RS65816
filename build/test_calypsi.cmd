@echo off
set CALYPSI=C:\github\atari-tools\calypsi-65816-5.18
path=%PATH%;%CALYPSI%\bin

set COMPILER=calypsi

set HOME=C:\github\RS65816
set SRC=%HOME%\src
set REL=%HOME%\release\%COMPILER%
set LST=%REL%\lst
set OBJ=%REL%\obj

set MODULES=main monitor
set CFLAGS=-O2 --code-model compact --data-model large
set LFLAGS=--raw-multiple-memories --output-format raw --rtattr printf=medium 
set EXE=test_calypsi

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

pushd
cd %OBJ%
echo ************************************************************
echo linking %EXE%
echo ln65816 %LFLAGS% --list-file %LST%\%EXE%.lin --output-file %REL%\%EXE%.elf %OBJS% clib-cc-ld.a %SRC%\%EXE%.scm
echo ************************************************************
ln65816 %LFLAGS% --list-file %LST%\%EXE%.lin --output-file %REL%\%EXE%.elf %OBJS% clib-cc-ld.a %SRC%\%EXE%.scm
popd
if %ERRORLEVEL% NEQ 0 goto error
goto eof
	
	
:compile
echo ************************************************************
echo compiling %1.c
echo cc65816 %CFLAGS% -o %OBJ%\%1.o --list-file %LST%\%1.lst %SRC%\%1.c
echo ************************************************************
cc65816 %CFLAGS% -o %OBJ%\%1.o --list-file %LST%\%1.lst %SRC%\%1.c
set RC=%ERRORLEVEL%
exit /b


:error
pause

:eof