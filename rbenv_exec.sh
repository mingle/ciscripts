#!/bin/bash
set -x
set -e

unset GEM_PATH
unset GEM_HOME

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

cmd="rbenv exec bundle exec $@"
echo "executing: $cmd"
rbenv exec bundle exec $@ 2>&1
