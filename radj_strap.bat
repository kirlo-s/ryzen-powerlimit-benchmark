set RYZENADJ_EXE="./RyzenAdj/ryzenadj.exe"
powershell sleep 3
%RYZENADJ_EXE% --stapm-limit=%1 --fast-limit=%1 --slow-limit=%1
exit