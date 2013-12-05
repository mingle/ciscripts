#!/bin/sh
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
    if [[ "$RBENV_VERSION" == 2.* ]]; then
        echo "installing prerequisites for ruby2.0.0"
        sudo apt-get install zlib1g-dev openssl libopenssl-ruby1.9.1 libssl-dev libruby1.9.1 libreadline-dev
        echo "installing ruby ${RBENV_VERSION}..."
        CONFIGURE_OPTS="--disable-install-doc" ~/.rbenv/bin/rbenv install $RBENV_VERSION
        echo "done"
    fi

    if [ "$RBENV_VERSION" == "jruby*" ]; then
        echo "installing ruby ${RBENV_VERSION}..."
        ~/.rbenv/bin/rbenv install $RBENV_VERSION
        echo "done"
    fi
fi

echo "installing gems:"
if [ "$RBENV_VERSION" == "jruby*" ]; then
    echo "installing openssl gem for jruby"
    ~/.rbenv/bin/rbenv exec gem install jruby-openssl
fi

~/.rbenv/bin/rbenv exec gem install bundler
~/.rbenv/bin/rbenv exec ruby -S bundle install
~/.rbenv/bin/rbenv rehash
