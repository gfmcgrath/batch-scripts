@ECHO OFF
@TITLE WoW Backup

REM v1.0
REM 2024-07-23
REM By Yarg

REM Backs up selected WoW game folders that are neccessary to restore add-ons and user settings such as WTF, Interface, etc.
REM Original source https://www.wowhead.com/guide/backing-up-important-wow-data-and-you-1983
REM Datestamp block from comment on Wowhead artivel by Djinnii on 2020-06-23
REM Adapted to use TAR instead of 7z, as TAR is now included by default on all modern versions of Windows, removing need for 3rd party software


:: USER VARIABLES
:: -------------------------------------------------------------------|
:: Change the "C:\Games\World of Warcraft\_retail_" to the location of your WoW folder
SET WOW_DIR=E:\World of Warcraft\_retail_

:: Change the "G:\My Drive\Games\World of Warcraft\Backups" to the location of the folder in backupdir you want to store your backups.
SET BACKUP_DIR=D:\OneDrive\wow_backup
:: -------------------------------------------------------------------|


REM Create a variable "DATE_STAMP" to be year-month-day. (EG: 2020-06-22 This just works better for listing files in the correct order) 
for /f "skip=1" %%i in ('wmic os get localdatetime') do if not defined FULL_DATE set FULL_DATE=%%i
SET YEAR=%FULL_DATE:~0,4%
SET MONTH=%FULL_DATE:~4,2%
SET DAY=%FULL_DATE:~6,2%
SET DATE_STAMP=%YEAR%-%MONTH%-%DAY%

REM Set the directories to be archived and the output archive file name
SET BASE_DIR=%WOW_DIR%
SET DIR1=WTF
SET DIR2=Interface
SET DIR3=Fonts
SET ARCHIVE_NAME=%BACKUP_DIR%\%DATE_STAMP%_wowbak.tar.gz

REM Check if the base directory exists
IF NOT EXIST "%BASE_DIR%" (
    echo Base directory does not exist: %BASE_DIR%
    pause
    exit /b 1
)

REM Check if the source directories exist within the base directory
IF NOT EXIST "%BASE_DIR%\%DIR1%" (
    echo Source directory does not exist: %BASE_DIR%\%DIR1%
    pause
    exit /b 1
)
IF NOT EXIST "%BASE_DIR%\%DIR2%" (
    echo Source directory does not exist: %BASE_DIR%\%DIR2%
    pause
    exit /b 1
)
IF NOT EXIST "%BASE_DIR%\%DIR3%" (
    echo Source directory does not exist: %BASE_DIR%\%DIR2%
    pause
    exit /b 1
)

REM Optional: Navigate to the directory containing tar.exe (if not in PATH)
REM SET TAR_DIR=C:\path\to\tar\bin
REM CD /D %TAR_DIR%

REM Create the archive, preserving the directory structure
ECHO Creating WoW Backup...
tar -czf "%ARCHIVE_NAME%" -C "%BASE_DIR%" "%DIR1%" "%DIR2%" "%DIR3%"

REM Check if the tar command was successful
IF %ERRORLEVEL% EQU 0 (
    echo Archive created successfully: %ARCHIVE_NAME%
) ELSE (
    echo Failed to create archive
)

pause
