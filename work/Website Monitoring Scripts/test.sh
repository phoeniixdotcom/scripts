#!/bin/sh

site="http://staging.yoursite.com"
urls=("$site" "$site/testpage.jsp" "$site/trams")
index=$[$RANDOM % 3];
echo ${urls[$index]};
