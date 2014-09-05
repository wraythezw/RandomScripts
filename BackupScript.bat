@echo off
echo *********************************************
echo *            Very Basic Backup Script       *
echo *              MIT License                  *
echo *         keith.rose.zw@gmail.com           *
echo *********************************************

set Source= "C:\Data"
set folder= "D:\Backup"

if exist %folder% (
 echo Backup file %folder%.rar already exists. Did you already run the backup?
) else (
 echo No previous backup. Backing up.
 echo Starting backup. Do not close this window!!!!
 echo ........

rar a -r %folder%.rar %Source% >> %folder%_log.txt | tail -f %folder%_log.txt
)
echo Backup completed succesfully. Press any key to continue.
pause
exit
