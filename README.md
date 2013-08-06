ciscripts
=========

Collections of CI build tools for ruby apps


install_rbenv.sh
----
It install rbenv and do bundle install. The benifit for this script is it isolates different ruby versions so that you can use same agent run build for different project using different ruby versions.
Usage:

In build script:
* Setup environment variable RBENV_VERSION (https://github.com/sstephenson/rbenv)
    
    export RBENV_VERSION=1.9.3-p327
    
* One line script to setup ruby envionment (assuming working directory are project root and there is a Gemfile)
    
    rm -rf ciscripts; git clone https://github.com/ThoughtWorksStudios/ciscripts.git && sh ciscripts/install_rbenv.sh

* Then use  '~/.rbenv/bin/rbenv exec' to execute all ruby command include ruby itself. E.g:
     
    ~/.rbenv/bin/rbenv exec ruby -e "p 'Hello world'"    
    ~/.rbenv/bin/rbenv exec rake
     
