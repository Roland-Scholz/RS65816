@echo off
rem ***************************************************
rem * compile-precedure for Calypsi 65816 compiler
rem ***************************************************

set HOME=C:\github\RS65816
set CALYPSI=C:\github\atari-tools\calypsi-65816-5.18
PATH=%PATH%;%CALYPSI%\bin

set SRC=%HOME%\src
set REL=%HOME%\release
set OBJ=%REL%\obj
set LST=%REL%\lst

rem echo ***
rem echo *** assemble 
rem echo ***
rem as65816 --code-model compact --data-model huge --list-file %LST%\mystartup.lst -I%CALYPSI%\src\lib\lowlevel -o %OBJ%\mystartup.o %SRC%\mystartup.s 
rem echo %ERRORLEVEL%

echo ***
echo *** compile
echo ***
cc65816 -O2 --code-model compact --data-model huge -o %OBJ%\testc.o --list-file %LST%\testc.lst %SRC%\testc.c

echo ***
echo *** link 
echo ***
ln65816 --list-file %LST%\testc.lin --raw-multiple-memories --output-format raw --output-file %REL%\testc.elf %OBJ%\testc.o clib-cc-hd.a %SRC%\testc.scm
rem %OBJ%\mystartup.o --output-format intel-hex
pause