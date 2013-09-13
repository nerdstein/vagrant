# What
VirtualBox Vagrant Chef Drupal install


# How
1. Download and Install [VirtualBox](http://www.virtualbox.org/) (ensure you are on the latest version 4.0.8+)
2. Install [vagrant](http://vagrantup.com/v1/docs/getting-started/index.html)
3. Download a vagrant box:
    `vagrant box add base http://files.vagrantup.com/lucid32.box`
4. Download or Clone this project go to the folder and launch the box:
    `cd [vagrant project directory];
    vagrant up`
5. Add this line to your /etc/hosts (or windows equivalent):
    `33.33.33.10        drupal.dev.vm dev.vm`


That's it, files in "public" are served here : [http://drupal.dev.vm/](http://drupal.dev.vm/)

To connect to the console of you instance:
    `vagrant ssh`

--------

You can add `XDEBUG_PROFILE` to your GET parameter to generate an xdebug profile, e.g. [http://dev.vm/?XDEBUG_PROFILE](http://dev.vm/?XDEBUG_PROFILE)

You can then investigate at [http://dev.vm/webgrind/](http://dev.vm/webgrind/)

Phpmyadmin is available [http://dev.vm/phpmyadmin/](http://dev.vm/phpmyadmin/). User `myadmin`, Password `myadmin`

## Other projects of interest

*  [http://drupal.org/sandbox/mbutcher/1356522](http://drupal.org/sandbox/mbutcher/1356522)
*  [http://drupal.org/project/drush-vagrant](http://drupal.org/project/drush-vagrant)


(Development sponsored by: [AllPlayers.com](https://www.allplayers.com))
