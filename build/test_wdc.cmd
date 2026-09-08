@echo off
set WDC=C:\github\atari-tools\WDC
set WDC_INC_65816=%WDC%\include
set WDC_LIB=%WDC%\lib

set HOME=C:\github\RS65816
set SRC=%HOME%\src
set REL=%HOME%\release
set LST=%REL%\lst
set OBJ=%REL%\obj

set MODULE=testwdc

path=%PATH%;%WDC%\bin

@echo on

wdc816cc -MC -LW %SRC%\%MODULE%.c -o %OBJ%\%MODULE%.o
wdcln %OBJ%\%MODULE%.o -T -HB -C0200 cc.lib -o %REL%\%MODULE%.bin
pause