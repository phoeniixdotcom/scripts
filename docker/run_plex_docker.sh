#!/bin/bash
sudo docker run -d --restart=always -v /opt/docker/plex-config:/config -v ~/Movies:/media --net=host --cpuset-cpus=0,1,2,3,4,5 --memory 4g -P -p 10.1.1.11:32401:32401 wernight/plex-media-server:autoupdate

