#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

#sudo add-apt-repository ppa:chris-lea/node.js

apt-get update

apt-get -y install python-software-properties redis-server
apt-get -y install postgresql postgresql-contrib pgadmin3 postgresql-common libpq-dev
apt-get -y install memcached
apt-get -y install nodejs npm
apt-get -y install build-essential libssl-dev

# Nokogiri
sudo apt-get install libxslt-dev libxml2-dev

# PhantomJS dependency
apt-get -y install fontconfig phantomjs

# Development
apt-get -y install vim tmux ack-grep curl htop iotop siege nmap

## NFS
#apt-get -y install nfs-common portmap

## Nginx
#apt-get -y install nginx

apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y autoremove

## Java7
#echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" >> /etc/apt/sources.list
#TMPNAME=$(tempfile)
#apt-get -y update >> /dev/null 2> $TMPNAME
#PGPKEY=`cat $TMPNAME | cut -d":" -f6 | cut -d" " -f3`
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $PGPKEY
#rm $TMPNAME
#apt-get -y update
#echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
#echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
#DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java7-installer oracle-java7-set-default
#echo "export JAVA_OPTS=\"-Xmx400m -XX:MaxPermSize=80M -XX:+UseCompressedOops -XX:+AggressiveOpts\"" >> /etc/profile.d/jdk.sh
#echo "setenv JAVA_OPTS \"-Xmx400m -XX:MaxPermSize=80M -XX:+UseCompressedOops -XX:+AggressiveOpts\"" >> /etc/profile.d/jdk.csh
