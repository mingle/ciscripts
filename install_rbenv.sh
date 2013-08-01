#!/bin/bash
set -x
set -e

# Install rbenv from scratch on linux build agents
# usage:
#   export RBENV_VERSION=1.9.3-p429
#   sh install_rbenv.sh
# then all following ruby script/command can be executed as
#   ~/.rbenv/bin/rbenv exec ruby ...

if [ ! -d ~/.rbenv ]; then
    echo "installing rbenv..."
    git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
fi

if [ ! -d ~/.rbenv/plugins/ruby-build ]; then
    echo "installing ruby-build plugin..."
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

if [ ! -d ~/.rbenv/versions/$RBENV_VERSION ]; then
    echo "installing ruby ${RBENV_VERSION}..."
    ~/.rbenv/bin/rbenv install $RBENV_VERSION
    echo "done"
fi

echo "installing gems:"
if [[ $RBENV_VERSION == jruby* ]]
then
    ~/.rbenv/bin/rbenv exec gem install jruby-openssl
fi

~/.rbenv/bin/rbenv exec gem install bundler
~/.rbenv/bin/rbenv exec ruby -S bundle install
~/.rbenv/bin/rbenv rehash