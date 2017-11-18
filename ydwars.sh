#!/bin/bash
set -x
# YDWARS=/data/wars/ydwars
# WebsitePath=/work/yd/ydwars/website
website()
{
	if [ -f /data/wars/ydwars/website/*.tar.gz ]; then
		echo "旧的website.tar.gz文件已存在，开始删除。。。"
		rm -rf /data/wars/ydwars/website/*.tar.gz
	else

		echo "没有website.tar.gz文件，用ansible获取最新的。。。"
		
	fi
	# 用ansible命令获取最新的压缩包文件website.tar.gz
	ansible website -m shell -a "tar -C /data/wars/test-jp.website  -zcf  /wars/website/website.tar.gz ROOT"

	if [ -f /data/wars/ydwars/website/*.tar.gz ]; then
		echo "成功获取最新website.tar.gz"
	else
		echo "获取最新website.tar.gz失败,退出"
		exit 0;
	fi

	if [ -f /work/yd/ydwars/website/*.tar.gz ]; then
		echo "清空工作目录"
		cd /work/yd/ydwars/website
		rm -rf *	
	else
		echo "该工作目录已为空"
	fi

	# 获取代码文件
	cp /data/wars/ydwars/website/website.tar.gz /work/yd/ydwars/website
	# 获取配置文件
	cp -r /data/conf/newPRD/YD/website/WEB-INF /work/yd/ydwars/website
	#解压
	cd /work/yd/ydwars/website
	tar zxf website.tar.gz
	#改名 
	mv ROOT/ website
	#加入配置文件
	\cp -rf WEB-INF/ website/
	rm -rf website.tar.gz
	tar zcf website_`date +%Y%m%d%H%M%S`.tar.gz website/
	scp *.tar.gz 172.20.32.9:/usr/local/tomcat-8081/myapps

}

msite()
{
	if [ -f /data/wars/ydwars/msite/*.tar.gz ]; then
		echo "旧的msite.tar.gz文件已存在，开始删除。。。"
		rm -rf /data/wars/ydwars/msite/*.tar.gz
	else

		echo "没有msite.tar.gz文件，用ansible获取最新的。。。"
		
	fi
	# 用ansible命令获取最新的压缩包文件website.tar.gz
	ansible website -m shell -a "tar -C /data/wars/test-jp.msite  -zcf  /wars/msite/msite.tar.gz ROOT"

	if [ -f /data/wars/ydwars/msite/*.tar.gz ]; then
		echo "成功获取最新msite.tar.gz"
	else
		echo "获取最新msite.tar.gz失败,退出"
		exit 0;
	fi

	if [ -f /work/yd/ydwars/msite/*.tar.gz ]; then
		echo "清空工作目录"
		cd /work/yd/ydwars/msite
		rm -rf *	
	else
		echo "该工作目录已为空"
	fi

	# 获取代码文件
	cp /data/wars/ydwars/msite/msite.tar.gz /work/yd/ydwars/msite
	# 获取配置文件
	cp -r /data/conf/newPRD/YD/msite/WEB-INF /work/yd/ydwars/msite
	#解压
	cd /work/yd/ydwars/msite
	tar zxf msite.tar.gz
	#重命名 
	mv ROOT/ msite
	#加入配置文件
	\cp -rf WEB-INF/ msite/
	rm -rf msite.tar.gz
	tar zcf msite_`date +%Y%m%d%H%M%S`.tar.gz msite/
	scp *.tar.gz 172.20.32.5:/usr/local/tomcat-8080/myapps
}

yd_apio()
{

	# if [ -f /data/wars/MarketingWars/admin/*.tar.gz ]; then
	# 	echo "旧的admin.tar.gz文件已存在，开始删除。。。"
	# 	rm -rf /data/wars/MarketingWars/admin/*.tar.gz
	# else

	# 	echo "没有apio.tar.gz文件，用ansible获取最新的。。。"
		
	# fi
	# 用ansible命令获取最新的压缩包文件website.tar.gz
	ansible website -m shell -a "rm -rf /data/wars/test-jp.financing.core/apio.tar.gz"
	ansible website -m shell -a "tar -C /data/wars/test-jp.financing.core -zcf /data/wars/test-jp.financing.core/apio.tar.gz ROOT"

	if [ -f /work/yd/ydwars/apio/*.tar.gz ]; then
		echo "清空工作目录"
		cd /work/yd/ydwars/apio
		rm -rf *	
	else
		echo "该工作目录已为空"
	fi

	# 获取代码文件
	scp 192.168.29.130:/data/wars/test-jp.financing.core/apio.tar.gz /work/yd/ydwars/apio
	# 获取配置文件
	cp -r /data/conf/newPRD/YD/apio/WEB-INF /work/yd/ydwars/apio
	#解压
	cd /work/yd/ydwars/apio
	tar zxf apio.tar.gz
	#重命名 
	mv ROOT/ apio
	#加入配置文件
	\cp -rf WEB-INF/ apio/
	# rm -rf apio.tar.gz
	# tar zcf apio_`date +%Y%m%d%H%M%S`.tar.gz apio/
	# scp *.tar.gz 172.20.32.2:/usr/local/tomcat-8080/myapps
}

Marketing.admin()
{
	if [ -f /data/wars/MarketingWars/admin/*.tar.gz ]; then
		echo "旧的admin.tar.gz文件已存在，开始删除。。。"
		rm -rf /data/wars/MarketingWars/admin/*.tar.gz
	else

		echo "没有admin.tar.gz文件，用ansible获取最新的。。。"
		
	fi
	# 用ansible命令获取最新的压缩包文件website.tar.gz
	ansible Marketing.admin -m shell -a "rm -rf /data/wars/Uat-marketing.admin/admin.tar.gz"
	ansible Marketing.admin -m shell -a "tar -C /data/wars/Uat-marketing.admin -zcf /data/wars/Uat-marketing.admin/admin.tar.gz ROOT"

	if [ -f /work/nyx/wars/admin/*.tar.gz ]; then
		echo "清空工作目录"
		cd /work/nyx/wars/admin
		rm -rf *	
	else
		echo "该工作目录已为空"
	fi

	# 获取代码文件
	scp 192.168.11.64:/data/wars/Uat-marketing.admin/admin.tar.gz /work/nyx/wars/admin
	# 获取配置文件
	cp -r /data/conf/newPRE/newyingxiao/admin/WEB-INF /work/nyx/wars/admin
	#解压
	cd /work/nyx/wars/admin
	tar zxf admin.tar.gz
	#重命名 
	mv ROOT/ admin
	#加入配置文件
	\cp -rf WEB-INF/ admin/
	rm -rf admin.tar.gz
	tar zcf admin_`date +%Y%m%d%H%M%S`.tar.gz admin/
	scp *.tar.gz 172.20.6.140:/data/pretomcat/premkadmin-8083/myapps
}

case $1 in 
    website) 
    website 
         ;; 
    msite) 
    msite
         ;; 
    nyx_admin)
    Marketing.admin
         ;;
    yd_apio)
    yd_apio
         ;;
         *) 
    echo "Please Input The Correct Service Name !!!" 
         ;; 
esac 

