@echo off

REM check if git exists
where git > nul 2>&1
if %errorlevel%==1 (
	echo git doesnt exist
	exit /B 1
)

setlocal

REM TODO opt plugins
set packdir=pack\foobar\start

REM create packdir if doesnt exist
if not exist %packdir% ( md %packdir% )

REM check if packs.txt exists
if not exist packs.txt (
	echo packs.txt doesnt exist
) else (
	if "%~1"=="" (
		echo plugit i               - install
		echo plugit u               - update
		echo plugit r               - remove all plugins
		echo plugit r ^<plugin-name^> - remove ^<plugin-name^>
	) else (

		REM install
		if "%~1"=="i" (
			echo installing
			for /F "eol=;" %%i in (packs.txt) do (
				git -C %packdir% clone --depth=1 %%i
			)
		)

		REM update
		if "%~1"=="u" (
			echo updating
			for /F "eol=;" %%I in (packs.txt) do (
				echo %%~nxI
				REM see for /?
				git -C %packdir%\%%~nxI pull
			)
		)

		REM remove plugins
		if "%~1"=="r" (
			REM remove all plugins if 2nd arg is empty
			if "%~2"=="" (
				REM removing the pack dir is better then looping over subfolders
				rd /S /Q %packdir%
				echo all plugins have been removed
				REM note that it just deletes start
			) else (
				REM remove only specifics
				if not exist %packdir%\%~2% (
					echo %~2% doesnt exist
				) else (
					rd /S /Q %packdir%\%~2%
					echo removed %~2%
				)
			)
		)

	)
)

endlocal
REM TODO support downgrading (tagging)
