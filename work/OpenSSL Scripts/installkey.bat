REM this file will help create a key using openssl
REM
REM

SET /P FILELOC=Specify the certs file location: 

echo [Importing keystore]
keytool -import -alias %ALIAS% -trustcacerts -keystore "c:\my.keystore" -file "%FILELOC%"
pause

SET /P ALIAS=Specify an Alias (Phoeniix): 
SET /P COMMONNAME=Specify the Common Name (www.phoeniix.com): 
SET /P ORGANIZATIONALUNIT=Specify the Organizational Unit (IT): 
SET /P ORGANIZATION=Specify the Organization (Phoenix Web Development Tools): 
SET /P CITY=Specify the City (San Diego): 
SET /P STATE=Specify the State (California): 
SET /P COUNTRY=Specify the Country (US): 
SET /P KEYALGORITHM=Specify the Algorithm (RSA):
SET /P KEYSIZE=Specify the Keysize (1024):
SET /P KEYSTORE=Specify the Keystore Name (mykeystore):
SET /P STOREPASSWORD=Specify the Store Password (*****):
SET /P KEYPASSWORD=Specify the Key Password (*****):

 -keyalg RSA -keysize 1024 -keystore keystore -storepass password -keypass password

echo [Generating Key]
keytool -genkey -alias %ALIAS% -dname "CN=%COMMONNAME%, OU=%ORGANIZATIONALUNIT%, O=%ORGANIZATION%, L=%CITY%, S=%STATE%, C=%COUNTRY%" -keyalg RSA -keysize 1024 -keystore keystore -storepass password -keypass password
pause
