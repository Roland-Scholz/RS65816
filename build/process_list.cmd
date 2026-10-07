set LIST=%~2

:process_list_loop
for /F "tokens=1*" %%i in ("%LIST%") do (
	call %1 %%i
	if !RC! NEQ 0 goto error
	set LIST=%%j
	set OBJS=%OBJS% %%i.o
)
if defined LIST goto process_list_loop
exit /b