require_recipe "apt"
require_recipe "apache2"
require_recipe "mysql::server"
require_recipe "php::php5"
include_recipe "php::pear"
require_recipe "varnish"
require_recipe "memcached"
require_recipe "imagemagick"
require_recipe "build-essential"
require_recipe "hosts"

# Some neat package (subversion is needed for "subversion" chef ressource)
%w{ debconf php5-xdebug subversion curl git-core php5-curl php-pear php5-gd  }.each do |a_package|
  package a_package
end

# get phpmyadmin conf
cookbook_file "/tmp/phpmyadmin.deb.conf" do
  source "phpmyadmin.deb.conf"
end
bash "debconf_for_phpmyadmin" do
  code "debconf-set-selections /tmp/phpmyadmin.deb.conf"
end
package "phpmyadmin"

node[:hosts][:localhost_aliases].each do |site|
  # Configure the development site
  web_app site do
    template "sites.conf.erb"
    server_name site
    server_aliases [site]
    docroot "/vagrant/public/#{site}"
  end
end
# Retrieve webgrind for xdebug trace analysis
subversion "Webgrind" do
  repository "http://webgrind.googlecode.com/svn/trunk/"
  revision "HEAD"
  destination "/var/www/webgrind"
  action :sync
end

# Add an admin user to mysql
execute "add-admin-user" do
  command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -e \"" +
      "CREATE USER 'myadmin'@'localhost' IDENTIFIED BY 'myadmin';" +
      "GRANT ALL PRIVILEGES ON *.* TO 'myadmin'@'localhost' WITH GRANT OPTION;" +
      "CREATE USER 'myadmin'@'%' IDENTIFIED BY 'myadmin';" +
      "GRANT ALL PRIVILEGES ON *.* TO 'myadmin'@'%' WITH GRANT OPTION;\" " +
      "mysql"
  action :run
  ignore_failure true
end
