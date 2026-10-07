echo ************************************************************
echo wdc816as -O %OBJ%\%1.o -LW %SRC%\%1.asm
echo ************************************************************
wdc816as -O %OBJ%\%1.o -LW %SRC%\%1.asm
set RC=%ERRORLEVEL%
rem if !RC! NEQ 0 goto error 
exit /b