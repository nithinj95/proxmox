#!/bin/bash

#check if nginx is installed or not
/etc/init.d/nginx status

if [ $? == 0 ];
then
	echo "nginx is already installed"
else
	#install nginx
	echo "###############################update local package############################"
	apt update
	echo "###################################install nginx###############################"
	apt install nginx -y
	systemctl restart nginx
	systemctl enable nginx
	echo "############################nginx is installed#################################"
fi

echo "############################configure nginx####################################"

mv  /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bkp
rm -f /etc/nginx/sites-enabled/default

wget http://ltbg-el-bkp/nithin_scrips/nginx_proxy/proxmox.conf -P /etc/nginx/conf.d
upstream="$(hostname -f)"
echo "$upstream"
sed -i "s/HOSTNAME/$upstream/g" /etc/nginx/conf.d/proxmox.conf

systemctl restart nginx

