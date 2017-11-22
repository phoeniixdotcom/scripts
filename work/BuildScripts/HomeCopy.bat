@ECHO OFF
REM This script should move any uploaded claims files from the production 
REM webservers to a share on our internal file server.
REM SXR

SET DRIVETOMAP=Z
SET REMOTESERVER=ca1cw-web01.csaweb.local,ca1cw-web02.csaweb.local,ca1cw-web03.csaweb.local,ca1cw-web51.csaweb.local,ca1cw-web10.csaweb.local,ca1cw-web11.csaweb.local,ca1cw-web61.csaweb.local

ECHO [ Move files from each production server ]
FOR %%A IN (%REMOTESERVER%) DO (
	net use %DRIVETOMAP%: \\%%A\c$ /USER:csaweb\scr Monday01

	clamscan --database="C:\Documents and Settings\All Users\.clamwin\db" --log="C:\logs\clamWin\Log.log" --move="%DRIVETOMAP%:\quarantine" --recursive %DRIVETOMAP%:\upload

	xcopy /s /i /y  %DRIVETOMAP%:\upload\HA \\prague.travelsecure.local\ClaimsFiles\HomeAwayClaimUpload
	xcopy /s /i /y  %DRIVETOMAP%:\upload\MR \\prague.travelsecure.local\ClaimsFiles\MarriottClaimUpload
	xcopy /s /i /y  %DRIVETOMAP%:\upload\SW \\prague.travelsecure.local\ClaimsFiles\StarwoodClaimUpload	
	
        robocopy %DRIVETOMAP%:\upload\ %DRIVETOMAP%:\uploadBackup\. /S /MOV

	net use %DRIVETOMAP%: /delete
)


rem pause