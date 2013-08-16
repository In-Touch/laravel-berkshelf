## Laravel Berkshelf Bootstrap

This is simply a project to bootstrap Laravel 4.0.x with Berkshelf and Vagrant, to get you going on dev ASAP.  It contains
a sensible set of defaults for a simple Laravel project, with some overrides in the Vagrantfile for local development.

### Requirements

* [PHP 5.3.x](http://php.net)
* [Ruby 1.9.3](http://rvm.io)
* [Vagrant](http://www.vagrantup.com/) 1.2.x / [VirtualBox](https://www.virtualbox.org/) 4.2.x
* [Berkshelf](http://berkshelf.com/), including the [Vagrant Berkshelf Plugin](https://github.com/riotgames/vagrant-berkshelf)
* [Composer](http://getcomposer.org/)

If you don't already have any of these things, read up on them first.  You're missing out on an easier development life.

### Installation

Make sure you have all the requirements above installed.

The easiest way is to use composers `create-project` command:

    $ composer create-project intouch/laravel-berkshelf my-awesome-project-dir

... or, clone this repo and from the cloned folder run:

    $ composer install
    $ php artisan key:generate


Now, you can run `vagrant up` from `my-awesome-project-dir` and watch Berkshelf and Chef fly like a Taggart's hair.

By default the virtual box is set to run at `33.33.33.10`, and the vhost on the box is named `laravel-berkshelf.local`.
Feel free to set these in your local `hosts` file, and of course to change them as necessary.  If you change any of the
settings in the chef cookbook, simply run `vagrant provision` from `my-awesome-project-dir` and Vagrant will apply your
changes to the virtual box.

Once the vagrant box has booted and you've setup your hosts file, you should [see this](http://cl.ly/image/0w1x360v2V2J).

Apache will be running the default Laravel project, and a default 'laravel' database will have been created:

    Welcome to Ubuntu 12.04.2 LTS (GNU/Linux 3.5.0-23-generic x86_64)

     * Documentation:  https://help.ubuntu.com/
    Last login: Tue Jul 16 19:47:53 2013 from 10.0.2.2
    vagrant@laravel-berkshelf:~$ mysql -u root -p
    Enter password:
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 37
    Server version: 5.5.32-0ubuntu0.12.04.1-log (Ubuntu)

    Copyright (c) 2000, 2013, Oracle and/or its affiliates. All rights reserved.

    Oracle is a registered trademark of Oracle Corporation and/or its
    affiliates. Other names may be trademarks of their respective
    owners.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    mysql> show databases;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | laravel            |
    | mysql              |
    | performance_schema |
    | test               |
    +--------------------+
    5 rows in set (0.00 sec)

    mysql>

Laravel is already set up to use APC for session and cache, and the `APPLICATION_ENVIRONMENT` environment variable to set
the project environment.

### How Could I Deploy This?

It's pretty simple using `chef-solo`.  There is already a configuration file and JSON payload in the `chef` folder.  You
could simply run `berks install --path=chef/cookbooks`, which will put all the dependant cookbooks under the `chef/cookbooks`
folder, with the project-specific cookbook.  Don't worry, they are excluded in the .gitignore.  Now upload the entire project
to your server (which has chef 11 already installed) and run `chef-solo -c chef/config.rb -j chef/default.json` from the project
root folder.

Deploying to multiple environments with separate settings?  Simply copy `chef/default.json` to
`chef/<environment>.json`, edit with your config overrides, and run `chef-solo -c chef/config.rb -j chef/<environment>.json`
on the target system.

We have written some simple BASH scripts that handle all this for us (including bootstrapping the remote system with ruby
and chef if necessary); we'll be sharing them soon, but you get the picture.

### What Do I Get?

The VM is built on a minimal install of Ubuntu 12.04 LTS (Precise Pangolin) with Ruby 1.9.3 (rvm) and Chef 11.4.4.

Installed is the default PHP 5.3.x (latest dot release in the Ubuntu repos) installation, plus mcrypt and apc.  It is
served via Apache 2.2.x (again, latest Ubuntu repo dot release) and running MySQL 5.5.x.  The default MySQL root password
is in the Vagrantfile.

### Licenses

The [Laravel](http://laravel.com) framework is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)

The [Berkshelf](http://berkshelf.com/) project is open-sourced software licensed under the [Apache License, Version 2.0](https://github.com/RiotGames/berkshelf/blob/master/LICENSE)

This project is free as in beer.  We're also happy to take pull requests if you have ideas or improvements.  Distribute
to your hearts content.  If you find this useful and are a nice person, you'll give us some small credit (but give the
folks at the projects above more credit).

### Contact Us

If you have any questions or comments, [open a ticket here](https://github.com/In-Touch/laravel-berkshelf/issues/new)
and we'll get back to you!
