@echo off

REM check if git exists
where git > nul 2>&1
if %errorlevel%==1 echo git doesnt exist

setlocal

set packdir=pack\foobar\start

REM create packdir if doesnt exist
if not exist %packdir% ( md %packdir% )

REM check if packs.txt exists
if not exist packs.txt (
	echo packs.txt doesnt exist 
) else (
	if "%1"=="" (
	   	echo print instructions 
	)

	REM install
	if %1==i (
		echo installing
		for /F "eol=;" %%i in (packs.txt) do (
			git -C %packdir% clone --depth=1 %%i
		)
	)

	REM update
	if %1==u (
		echo update
	)

	REM remove all plugins
	if %1==r (
		REM removing the pack dir is better then looping over subfolders
		rd /S /Q %packdir%
		REM note that it just deletes start
		echo all plugins have been removed
	)

)

endlocal

REM https://www.tutorialspoint.com/batch_script/batch_script_reading_from_files.htm
