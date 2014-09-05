@echo off
echo *********************************************
echo *            Very Basic Backup Script       *
echo *              MIT License                  *
echo *         keith.rose.zw@gmail.com           *
echo *********************************************

set folder=z:\backups\%date:/=_%_backup
if exist %folder% (
 echo Backup file %folder%.rar already exists. Did you already run the backup?
) else (
 echo No previous backup. Backing up.
 echo Starting backup. Do not close this window!!!!
 echo ........
 rar a -r %folder%.rar C:\Office1 > %folder%_log.txt
)
echo Backup completed succesfully. Press any key to continue.
pause
exit