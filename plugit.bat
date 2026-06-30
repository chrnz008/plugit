@echo off

REM check if git exists
where git > nul 2>&1
if %errorlevel%==1 (
	echo git doesnt exist
	exit /B 1
)

setlocal

REM TODO opt plugins
set packdir=pack\foobar
set startdir=pack\foobar\start
set optdir=pack\foobar\opt

REM create packdir if doesnt exist
if not exist %packdir% (
	md %startdir% %optdir%
)

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
			for /F "eol=; tokens=1,2*" %%i in (packs.txt) do (
				if "%%j"=="" (
					git -C %startdir% clone --depth=1 %%i
				) else (
					git -C %optdir% clone --depth=1 %%i
				)
			)
		)

		REM update
		if "%~1"=="u" (
			echo updating
			for /F "eol=; tokens=1,2*" %%I in (packs.txt) do (
				echo %%~nxI
				REM see for /?
				if "%%J"=="" (
					git -C %startdir%\%%~nxI pull
				) else (
					git -C %optdir%\%%~nxI pull
				)
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
				if not exist %startdir%\%~2% (
					if not exist %optdir%\%~2% (
						echo %~2 doesnt exist
					) else (
						rd /S /Q %optdir%\%~2%
						echo removed %~2 from %optdir%
					)
				) else (
					rd /S /Q %startdir%\%~2%
					echo removed %~2 from %startdir%
				)
			)
		)

	)
)

endlocal
REM TODO support downgrading (tagging)
