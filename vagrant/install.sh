#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

#sudo add-apt-repository ppa:chris-lea/node.js

apt-get -y update

apt-get -y install linux-headers-$(uname -r)

apt-get -y install git
apt-get -y install python-software-properties
apt-get -y install redis-server
apt-get -y install postgresql
apt-get -y install postgresql-contrib
apt-get -y install pgadmin3
apt-get -y install postgresql-common
apt-get -y install libpq-dev
apt-get -y install memcached
apt-get -y install nodejs
apt-get -y install npm
apt-get -y install build-essential
apt-get -y install libssl-dev

# Nokogiri
apt-get -y install libxslt-dev
apt-get -y install libxml2-dev

# PhantomJS dependency
apt-get -y install fontconfig
apt-get -y install phantomjs

# Development
apt-get -y install vim
apt-get -y install tmux
apt-get -y install ack-grep
apt-get -y install curl
apt-get -y install htop
apt-get -y install iotop
apt-get -y install siege
apt-get -y install nmap

# NFS
apt-get -y install nfs-common
apt-get -y install portmap

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
