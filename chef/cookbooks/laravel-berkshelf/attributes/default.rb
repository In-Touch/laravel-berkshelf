#
# Cookbook Name:: laravel-berkshelf
# Attributes:: default
#
# Copyright (C) 2013 In-Touch Insight Systems Inc.
#
# No rights reserved - Redistribute
#

default['laravel-berkshelf']['hostname'] = 'my-awesome-project.com'
default['laravel-berkshelf']['aliases'] = ['*.my-awesome-project.com']
default['laravel-berkshelf']['docroot'] = '/usr/local/my-awesome-project/public'
default['laravel-berkshelf']['logroot'] = '/var/log/my-awesome-project'
default['laravel-berkshelf']['app_env'] = 'production'

default['laravel-berkshelf']['db_name'] = 'laravel'

default['laravel-berkshelf']['owner'] = 'www-data'
default['laravel-berkshelf']['group'] = 'www-data'