#!/bin/bash

function sendMessage { # message
	DISPLAY=:0 notify-send $1
}

function getLatestProcs { #
	
}

message="Process $process appears to be leaking. $currentMem kb"

while true
do
	getLatestProcs
	sleep 60
done

sendMessage $message
