sudo su
yum install httpd php -y
yum install gcc glibc glibc-common -y
yum install gd gd-devel -y

adduser -m nagios
passwd nagios

groupadd nagioscmd
usermod -a -G nagioscmd nagios
usermod -a -G nagioscmd apache

mkdir ~/downloads
cd ~/downloads

wget https://webwerks.dl.sourceforge.net/project/nagios/nagios-4.x/nagios-4.0.8/nagios-4.0.8.tar.gz
wget http://nagios-plugins.org/download/nagios-plugins-2.0.3.tar.gz

tar zxvf nagios-4.0.8.tar.gz
cd nagios-4.0.8

./configure --with-command-group=nagioscmd
make all


make install
make install-init
make install-config
make install-commandmode