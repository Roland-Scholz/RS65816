echo ************************************************************
echo compiling %1.c
echo wdc816cc %CFLAGS% %SRC%\%1.c -o %ASM%\%1.asm
echo ************************************************************
wdc816cc %CFLAGS% %SRC%\%1.c -o %ASM%\%1.asm
set RC=%ERRORLEVEL%
if !RC! NEQ 0 goto error 
wdc816as -O %OBJ%\%1.o -LW %ASM%\%1.asm
set RC=%ERRORLEVEL%
:error
exit /b
