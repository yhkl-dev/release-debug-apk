#!/bin/bash

config_dir=".ossutilconfig"
current_date=`date '+%Y%m%d_%H%M%S'`
apk_name=$uploadDir\_$current_date.apk

hub checkout master
#git branch
VERSION_NAME=`grep -oP 'versionName "\K(.*?)(?=")' ./${APP_FOLDER}/build.gradle`
hub release create -a ./${APP_FOLDER}/build/outputs/apk/debug/*-debug.apk -m "${RELEASE_TITLE} - v${VERSION_NAME}" $current_date 
 

wget http://gosspublic.alicdn.com/ossutil/1.6.13/ossutil64  

chmod 755 ossutil64

echo "[Credentials]" > $config_dir
echo "language=CH" >> $config_dir
echo "endpoint=$endpoint" >> $config_dir
echo "accessKeyID=$accessKeyID" >> $config_dir
echo "accessKeySecret=$accessKeySecret" >> $config_dir

mv ./${APP_FOLDER}/build/outputs/apk/debug/*-debug.apk  ./${APP_FOLDER}/build/outputs/apk/debug/$apk_name

./ossutil64 cp ./${APP_FOLDER}/build/outputs/apk/debug/$apk_name oss://$uploadDir/$apk_name -c $config_dir

