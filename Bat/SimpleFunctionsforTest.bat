@echo off
rem cd %~dp0
rem echo this is %%~dp0 : %~dp0

set SCREEN_RECORD_SAVE_DIR=/sdcard/screenrecord
set SCREEN_RECORD_NAME=screenrecord.mp4
set SCREEN_RECORD_WIN_SAVE_DIR=screenrecord
set SCREEN_RECORD_PATH=E:
set LOGCAT_PATH=D:\Logcat
set LOGCAT_NAME=logcat.txt
set COUNT=1


:MENU
rem deal with time
set NOW_TIME_HH=%time:~0,2%
if "%NOW_TIME_HH%" lss "10" (set NOW_TIME_HH=0%time:~1,1%) else (set NOW_TIME_HH=%time:~0,2%)
set NOW_TIME=%date:~0,4%%date:~5,2%%date:~8,2%%NOW_TIME_HH%%time:~3,2%%time:~6,2%
ECHO *****************************************************************
ECHO Android Test simple functions
ECHO 请输入以下功能数字：
ECHO 输入1 录屏存到手机：Record MP4
ECHO 输入2 录屏存储到电脑E盘：Pull MP4 file to E:\screenrecord
ECHO 输入3 抓log：logcat -b all
ECHO 输入4 退出：Exit
ECHO 需要注意：需要结束时按下Ctr+C再输入N即可返回主菜单
ECHO 现在时间为：%NOW_TIME%
ECHO Created by manshuo
ECHO ******************************************************************
REM echo pls choose number：
set /p id= 请输入:
if "%id%"=="1" goto cmd1
if "%id%"=="2" goto cmd2
if "%id%"=="3" goto cmd3
IF "%id%"=="4" exit 
ELSE (
echo Enter number %id% is not recognited,pls enter again!
pause
GOTO MENU
)

@REM Recording MP4
:cmd1
echo Recording MP4,pls waiting...
adb shell rm -rf %SCREEN_RECORD_SAVE_DIR%
adb shell mkdir -p %SCREEN_RECORD_SAVE_DIR%
adb shell screenrecord  --bit-rate 6000000 %SCREEN_RECORD_SAVE_DIR%/%SCREEN_RECORD_NAME%
GOTO MENU
rem pause > nul


@REM Pull MP4 file
:cmd2
echo "Pulling MP4 file,please wait..."
REM rd /S /Q %SCREEN_RECORD_WIN_SAVE_DIR%
if not exist %SCREEN_RECORD_PATH%\%SCREEN_RECORD_WIN_SAVE_DIR% mkdir %SCREEN_RECORD_PATH%\%SCREEN_RECORD_WIN_SAVE_DIR%
adb pull %SCREEN_RECORD_SAVE_DIR%/%SCREEN_RECORD_NAME% %SCREEN_RECORD_PATH%\%SCREEN_RECORD_WIN_SAVE_DIR%
rem cd %SCREEN_RECORD_PATH%\%SCREEN_RECORD_WIN_SAVE_DIR%
REM for MP4 file add time stamp
ren %SCREEN_RECORD_PATH%\%SCREEN_RECORD_WIN_SAVE_DIR%\%SCREEN_RECORD_NAME% %NOW_TIME%%SCREEN_RECORD_NAME%
echo %SCREEN_RECORD_NAME% file has pulled!!
GOTO MENU


REM this is a bat for logcat -b all
:cmd3
for /F %%i in ('adb shell getprop ro.product.device') do ( set DeviceType=%%i)
echo 机型=%DeviceType%
echo capturing log....please press Ctrl+C to stop
if not exist %LOGCAT_PATH% mkdir %LOGCAT_PATH%
adb logcat -b all > %LOGCAT_PATH%\%NOW_TIME%_%DeviceType%_%COUNT%_%LOGCAT_NAME%
set /a COUNT+=1
echo ready for %COUNT% time for logcat!
GOTO MENU
