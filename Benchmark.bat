@echo off
setlocal enabledelayedexpansion

cd /d %~dp0

set SED_EXE_PATH="./sed/sed-4.2.1-bin/bin/sed.exe"
set OUT_PATH="score.csv"

rem set power values in mW
set MIN_POWER_VALUE=5000
set STEP_VALUE=5000
set MAX_POWER_VALUE=50000

set CINEBENCH_RUN_TIMES=3

if not exist ".\CinebenchBatch.bat" (
    echo create cinebenchbatch correctly.
    pause
    exit
)

NET FILE 1>NUL 2>NUL
if %errorlevel% NEQ 0 (
	echo This Script need be run as Administrator.
	pause
	exit /B 0
)


echo POWER,SCORE > %OUT_PATH%


for /l %%v in (%MIN_POWER_VALUE%,%STEP_VALUE%,%MAX_POWER_VALUE%) do (
    set SCORE_TEMP=0
    set SCORE=0

    echo set power limit to %%v mW
    echo Running Cinebench...
    call CinebenchBatch %CINEBENCH_RUN_TIMES% %%v > temp_res.txt
    %SED_EXE_PATH% "/^$/d" temp_res.txt | %SED_EXE_PATH% -n -e "/CB/p" | %SED_EXE_PATH% -e "s/^.\{3\}//" | %SED_EXE_PATH% -e "s/.\{10\}$//" > temp_format.txt
    for /f %%n in (temp_format.txt) do (
         set /a SCORE_TEMP=!SCORE_TEMP!+%%n 
    )

    set /a SCORE = !SCORE_TEMP!/%CINEBENCH_RUN_TIMES%
    set "MESSAGE=Finished; Power: %%v (mW) Score: !SCORE!"
    echo !MESSAGE!
    echo %%v,!SCORE! >> !OUT_PATH!
    echo sleeping 60 second
    powershell sleep 60
)