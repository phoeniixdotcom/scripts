#! /bin/bash

servers=( ca1cw-web01 ca1cw-web02 ca1cw-web03 soaprod001 soaprod002 soaprod003 soaprod004 soaprod010 soaprod011 )

read -p "Do you want to create or delete all work shares [create or delete]:" cd
case $cd in
[Cc] | [cC][rR][eE][aA][tT][eE])
	for i in "${servers[@]}"
	do
	net usershare add $i smb:///$i/c$/logs
	done
	;;
[Dd] | [dD][eE][lL][eE][aA][tT][eE])
	for i in "${servers[@]}"
	do
	net usershare delete $i
	done
	;;
*)	echo "Wrong action entered."
	;;
esac
