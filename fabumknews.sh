#!/bin/bash
/usr/bin/rsync -vzrtopg --progress --delete 172.20.6.140:/data1/prejar/newyingxiao/premknews-8092/marketingnews.jar /tmp/
/etc/init.d/mknews stop
cd /data/jar/ws.marketingnews-8092
mv marketingnews.jar marketingnews.jar-`date +%Y%m%d%H%M%S`
cp /tmp/marketingnews.jar .
/usr/bin/md5sum *.jar
/usr/local/sbin/daemonize -E BUILD_ID=dontKillMe /etc/init.d/mknews start

