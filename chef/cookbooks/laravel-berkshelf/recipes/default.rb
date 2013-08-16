#
# Cookbook Name:: laravel-berkshelf
# Recipe:: default
#
# Copyright (C) 2013 In-Touch Insight Systems Inc.
# 
# No rights reserved - Redistribute
#

# Grab the config for this node
config = node['laravel-berkshelf']

# Set the MySQL connection information
mysql_connection_info = {
    :host => 'localhost',
    :username => 'root',
    :password => node['mysql']['server_root_password']
}

# Install vim.  Why is it required?  Because, that's why!
include_recipe 'vim'

# Install Apache2 and mod_php
include_recipe 'apache2'
include_recipe 'apache2::mod_php5'

# Install PHP
include_recipe 'php'

# Install MySQL server and load the Chef LWRPs for generic databases
include_recipe 'mysql::server'
include_recipe 'database::mysql'

# Install the PHP modules we want.  There are recipes for these in the php cookbook
# but they have been deprecated in favour of installing your own packages.
['php5-mysql','php5-mcrypt','php-apc'].each do |pkg|
    package "#{pkg}" do
        action :install
        notifies :restart, 'service[apache2]'
    end
end

# Install the APC configuration
cookbook_file "/etc/php5/conf.d/apc.ini" do
  mode 0644
  source 'php_apc.ini'
  notifies :restart, 'service[apache2]'
end

# Create a default MySQL database
mysql_database config['db_name'] do
    connection mysql_connection_info
    action :create
end

# Create the folder Apache will log to
directory config['logroot'] do
    action :create
    recursive true
    mode 0755
    owner config['owner']
    group config['group']
end

# Deploy the Apache VHost configuration
web_app 'laravel-berkshelf' do
  server_name config['hostname']
  server_aliases config['aliases']
  docroot config['docroot']
  logroot config['logroot']
  appenv config['app_env']
  template "webapp.conf.erb"
end