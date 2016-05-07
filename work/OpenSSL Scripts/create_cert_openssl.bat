echo off
REM http://willert.dk/geek/ssl-make.html

REM Create a RSA private key with passphrase for Apache:
openssl genrsa -des3 -out C:\openssl\ssl\server.key 1024

REM Generate a signing request (CSR):
openssl req -new -key C:\openssl\ssl\server.key -out C:\openssl\ssl\server.csr

REM Create a private key for your CA:
openssl genrsa -des3 -out C:\openssl\ssl\ca.key 1024

REM Create a self-signed CA certificate (x509) structure with the RSA key of the CA:
openssl req -new -x509 -days 365 -key C:\openssl\ssl\ca.key -out C:\openssl\ssl\ca.crt

REM Put the keys and certificates in their correct places:
REM mv server.key private/
REM mv ca.key private/
REM mv ca.crt certs/

REM Sign the certificate request (server.csr):
REM /usr/local/bin/sign.sh server.csr (see note above)
REM Move signed certificate into correct place:
REM mv server.crt certs/
REM Clean up:
REM rm -f server.csr

REM SECURING:
REM ---------
REM chmod 600 /usr/local/openssl/certs/ca.crt
REM chmod 600 /usr/local/openssl/certs/server.crt
REM chmod 600 /usr/local/openssl/private/ca.key
REM chmod 600 /usr/local/openssl/private/server.key

REM This should conclued the installation of OpenSSL itself. Now install mod_ssl for Apache!


pause