@ECHO OFF
REM This script should move any uploaded claims files from the production 
REM webservers to a share on our internal file server.
REM SXR

SET DRIVETOMAP=Z
SET REMOTESERVER=wspdsv001.csaweb.local,wspdsv002.csaweb.local

ECHO [ Move files from each production server ]
FOR %%A IN (%REMOTESERVER%) DO (
	net use %DRIVETOMAP%: \\%%A\c$ /USER:csaweb\scr Monday01

	clamscan --database="C:\Documents and Settings\All Users\.clamwin\db" --log="C:\logs\clamWin\Log.log" --move="%DRIVETOMAP%:\quarantine" --recursive %DRIVETOMAP%:\upload

	xcopy /s /i /y  %DRIVETOMAP%:\upload \\prague.travelsecure.local\ClaimsFiles\HomeAwayClaimUpload
	
        move %DRIVETOMAP%:\upload\*.* %DRIVETOMAP%:\uploadBackup
        rem DEL /q %DRIVETOMAP%:\upload

	net use %DRIVETOMAP%: /delete
)


rem pause