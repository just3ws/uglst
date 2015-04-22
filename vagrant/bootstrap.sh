#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

source /home/vagrant/app/vagrant/install.sh

su - vagrant <<-'EOF'
  echo export EDITOR=vim >> $HOME/.bashrc

  echo export EDITOR=vim >> $HOME/.bashrc
  echo insecure > $HOME/.curlrc
  echo progress-bar >> $HOME/.curlrc
  echo gem: --no-document >> $HOME/.gemrc

  echo rvm_install_on_use_flag=1 >> $HOME/.rvmrc
  echo rvm_project_rvmrc=1 >> $HOME/.rvmrc
  echo rvm_trust_rvmrcs_flag=1 >> $HOME/.rvmrc

  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  command curl -sSL https://rvm.io/mpapis.asc | gpg --import -

  curl -k -L https://get.rvm.io | bash -s stable --autolibs=install-packages
  source "$HOME/.rvm/scripts/rvm"
  [[ -s "$rvm_path/hooks/after_cd_bundle" ]] && chmod +x $rvm_path/hooks/after_cd_bundle
  rvm autolibs enable
  rvm requirements
  rvm reload

  _RUBY_VERSION=ruby-2.2.2
  rvm install $_RUBY_VERSION
  rvm gemset create uglst
  rvm use $_RUBY_VERSION --default
  rvm use $_RUBY_VERSION@uglst

  cd ~/app

  bundle config --global jobs 3
  gem update --system
  gem install bundler

  bundle check || bundle install

  bundle exec rake db:create:all
  RAILS_ENV=test bundle exec rake db:create
  bundle exec rake db:migrate
  bundle exec rake db:seed
  bundle exec rake db:test:prepare
EOF
