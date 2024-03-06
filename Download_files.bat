@echo off

cd /d %~dp0

echo Downloading Cinebench R23...
curl -OL "https://installer.maxon.net/cinebench/CinebenchR23.zip"

echo Extracting Cinebench R23...
powershell Expand-Archive -Path "./CinebenchR23.zip" -Destination "./CinebenchR23" -Force

echo Downloading ryzenadj...
curl -LJO "https://github.com/FlyGoat/RyzenAdj/releases/latest/download/ryzenadj-win64.zip"

echo Extracting ryzenadj...
powershell Expand-Archive -Path "./ryzenadj-win64.zip" -Destination "./RyzenAdj" -Force

echo Downloading sed...
curl -L "https://cshs-small-worlds.aa0.netvolante.jp/adiary/memo/pub/hirosugu/image/201106/sed-4.2+alpha.zip" -o "sed.zip"

echo Extracting sed...
powershell Expand-Archive -Path "./sed.zip" -Destination "./sed" -Force


del ryzenadj-win64.zip CinebenchR23.zip sed.zip
echo Deleted zip archives.