#!/bin/bash

if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ]; then
    echo 'Usage: $0 -r "rtmp://5.79.73.195:1935/vod?h=e2ipewp7vtuzcg3h5fucpsny2zalvip6rukxf3tuqa6bnboys7oxr3mjop5a"
    -y "73/5387130113_n.mp4?h=e2ipewp7vtuzcg3h5fucpsny2zalvip6rukxf3tuqa6bnboys7oxr3mjop5a"
    -o file.mp4'
    exit 1
fi

rtmpdump -r "$1" -y "$2" -o "$3"

