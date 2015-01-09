#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

#sudo add-apt-repository ppa:chris-lea/node.js

apt-get -y update

apt-get -y install linux-headers-$(uname -r)

apt-get -y install autoconf
apt-get -y install automake
apt-get -y install bash
apt-get -y install bison
apt-get -y install build-essential
apt-get -y install bzip2
apt-get -y install ca-certificates
apt-get -y install g++
apt-get -y install gawk
apt-get -y install gcc
apt-get -y install git
apt-get -y install git-core
apt-get -y install imagemagick
apt-get -y install libc6-dev
apt-get -y install libcurl3
apt-get -y install libcurl3-dev
apt-get -y install libcurl3-gnutls
apt-get -y install libcurl4-openssl-dev
apt-get -y install libffi-dev
apt-get -y install libgdbm-dev
apt-get -y install libmagickcore-dev
apt-get -y install libmagickwand-dev
apt-get -y install libncurses5-dev
apt-get -y install libopenssl-ruby
apt-get -y install libpq-dev
apt-get -y install libreadline6
apt-get -y install libreadline6-dev
apt-get -y install libsqlite3-0
apt-get -y install libsqlite3-dev
apt-get -y install libssl-dev
apt-get -y install libtool
apt-get -y install libxml2
apt-get -y install libxslt1-dev
apt-get -y install libyaml-dev
apt-get -y install make
apt-get -y install memcached
apt-get -y install nfs-common
apt-get -y install openssl
apt-get -y install patch
apt-get -y install pep8
apt-get -y install pkg-config
apt-get -y install portmap
apt-get -y install python-dev
apt-get -y install python-setuptools
apt-get -y install python-software-properties
apt-get -y install sqlite3
apt-get -y install tcl8.5
apt-get -y install zlib1g
apt-get -y install zlib1g-dev
apt-get -y install zsh

# Redis
apt-get -y install redis-server
# -- Enable accessing Redis from the host machine
sed -i.bak "s/^bind 127.0.0.1/# bind 127.0.0.1/g" /etc/redis/redis.conf
service redis-server restart

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

# Node
apt-get -y install nodejs
apt-get -y install npm

# NFS
apt-get -y install nfs-common
apt-get -y install portmap

## Nginx
#apt-get -y install nginx

# Postgres
apt-get -y update
apt-get -y install postgresql
apt-get -y install postgresql-common
apt-get -y install postgresql-contrib
apt-get -y install pgadmin3

su -c 'createuser -s vagrant' postgres
su -c 'createuser -s uglst' postgres


# -- Enable accessing Postgres from the host machine
echo "listen_addresses = '*'"                          | tee -a /etc/postgresql/9.3/main/postgresql.conf

# support PgHero analytics
su -c "psql -c 'CREATE extension pg_stat_statements;'" postgres
echo "shared_preload_libraries = 'pg_stat_statements'" | tee -a /etc/postgresql/9.3/main/postgresql.conf
echo "pg_stat_statements.track = all"                  | tee -a /etc/postgresql/9.3/main/postgresql.conf
echo "pg_stat_statements.max = 10000"                  | tee -a /etc/postgresql/9.3/main/postgresql.conf
echo "track_activity_query_size = 2048"                | tee -a /etc/postgresql/9.3/main/postgresql.conf

sed -i.bak s/^host/#host/g /etc/postgresql/9.3/main/pg_hba.conf
echo "local   all             all                                     trust" | tee -a /etc/postgresql/9.3/main/pg_hba.conf
echo "host    all             all             127.0.0.1/32            trust" | tee -a /etc/postgresql/9.3/main/pg_hba.conf
echo "host    all             all             ::1/128                 trust" | tee -a /etc/postgresql/9.3/main/pg_hba.conf
echo "host    all             all             0.0.0.0/0               trust" | tee -a /etc/postgresql/9.3/main/pg_hba.conf
service postgresql restart


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
