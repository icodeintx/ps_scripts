#set logfile name into variable
$logFile = "c:\backup\BackupUsbLog.txt"

#First remove old backupfile
if ((Test-Path -LiteralPath $logFile )) {
	Remove-Item $logFile
}

# sync files
robocopy C:\OneDrive\src D:\OneDrive\src /MIR  /LOG+:$logFile /TEE /NDL /R:1 /W:5
robocopy C:\OneDrive\personal D:\OneDrive\personal /MIR  /LOG+:$logFile /TEE /NDL /R:1 /W:5
robocopy C:\OneDrive\production\apps D:\OneDrive\production\apps /MIR  /LOG+:$logFile /TEE /NDL /R:1 /W:5
