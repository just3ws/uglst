#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

source /home/vagrant/app/vagrant/install.sh

su - vagrant <<-'EOF'
  echo export EDITOR=vim >> $HOME/.bashrc

  echo insecure > $HOME/.curlrc

  echo rvm_install_on_use_flag=1 >> $HOME/.rvmrc
  echo rvm_project_rvmrc=1 >> $HOME/.rvmrc
  echo rvm_trust_rvmrcs_flag=1 >> $HOME/.rvmrc
  curl -k -L https://get.rvm.io | bash -s stable --autolibs=enabled
  source "$HOME/.rvm/scripts/rvm"
  [[ -s "$rvm_path/hooks/after_cd_bundle" ]] && chmod +x $rvm_path/hooks/after_cd_bundle
  rvm requirements
  rvm reload

  _RUBY_VERSION=ruby-2.1.5
  rvm install $_RUBY_VERSION
  rvm gemset create uglst
  rvm use $_RUBY_VERSION --default
  rvm use $_RUBY_VERSION@uglst

  cd $HOME/app
  gem update --system
  gem update bundler
  bundle config --global jobs 3
  bundle install

  cd ~/app
  bundle check || bundle install
  # Force the app to use the internal Postgres port number and ignore .env
  export DEVELOPMENT_POSTGRES_PORT=5432
  DEVELOPMENT_POSTGRES_PORT=5432 bundle exec rake db:migrate
  DEVELOPMENT_POSTGRES_PORT=5432 bundle exec rake db:test:prepare
  DEVELOPMENT_POSTGRES_PORT=5432 bundle exec rake db:create:all
  DEVELOPMENT_POSTGRES_PORT=5432 bundle exec rake db:migrate
  DEVELOPMENT_POSTGRES_PORT=5432 bundle exec rake db:seed
EOF
