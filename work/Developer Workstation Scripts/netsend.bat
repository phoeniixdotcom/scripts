echo off
REM
REM This file automates net send messaging
REM

ECHO ==========================
ECHO CSA Network Message Sender
ECHO ==========================
SET TARGETPC=
SET /P TARGETPC=PC NAME:
SET /P MESSAGE=MESSAGE:

ECHO [ Attempting to send... ]
net send %TARGETPC% %MESSAGE%

pause