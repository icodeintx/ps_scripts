# #set logfile name into variable
# $logFile = "c:\backup\BackupLog.txt"

# #First remove old backupfile
# if ((Test-Path -LiteralPath $logFile )) {
# 	Remove-Item $logFile
# }

# #copy the SRC drive from the E drive to the OneDrive folder so it syncs with onedrive
# robocopy c:\src c:\onedrive\src_backup /MIR  /LOG+:$logFile /TEE /NDL /R:1 /W:5

Write-Host "File is commented, nothing happened.  Use BackupUSB instead"