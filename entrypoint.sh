#!/bin/bash

config_dir=".ossutilconfig"

hub checkout master
#git branch
hub release create -a ./${APP_FOLDER}/build/outputs/apk/debug/app-debug.apk -m "${RELEASE_TITLE}" $(date +%Y%m%d%H%M%S) 

wget http://gosspublic.alicdn.com/ossutil/1.6.13/ossutil64  

chmod 755 ossutil64

echo "[Credentials]" > $config_dir
echo "language=CH" >> $config_dir
echo "endpoint=$endpoint" >> $config_dir
echo "accessKeyID=$accessKeyID" >> $config_dir
echo "accessKeySecret=$accessKeySecret" >> $config_dir

./ossutil64 cp./${APP_FOLDER}/build/outputs/apk/debug/app-debug.apk oss://db-aggregation-db/debug-apks/ -c config_dir


