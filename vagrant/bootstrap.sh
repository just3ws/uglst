#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

echo Who am I? You are `whoami`.
echo Where am I? You are in `pwd`
echo I think my home is $HOME

source /home/vagrant/app/vagrant/install.sh

# Postgres
# -- create the application user
su -c "createuser -s uglst" postgres

# -- Enable accessing Postgres from the host machine
echo "listen_addresses = '*'" | tee -a /etc/postgresql/9.3/main/postgresql.conf
echo host all all  0.0.0.0/0 trust | tee -a /etc/postgresql/9.3/main/pg_hba.conf
service postgresql restart

# Redis
# -- Enable accessing Redis from the host machine
sed -i.bak "s/^bind 127.0.0.1/# bind 127.0.0.1/g" /etc/redis/redis.conf
service redis-server restart


su -c "source /home/vagrant/app/vagrant/user-config.sh" vagrant
