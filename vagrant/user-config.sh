#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

echo Who am I? You are `whoami`.
echo Where am I? You are in `pwd`
echo I think my home is $HOME

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

_RUBY_VERSION=ruby-2.1.2
rvm install $_RUBY_VERSION
rvm gemset create uglst
rvm use $_RUBY_VERSION --default
rvm use $_RUBY_VERSION@uglst

cd $HOME/app
gem update --system
gem update bundler
bundle config --global jobs 3
bundle install
