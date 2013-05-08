# sync our configuration with /etc
apt-get -q -y install rsync apache2-mpm-prefork mysql-server nginx memcached php5-memcached php5-gd php-apc

rsync -av ./common/ /etc/

rsync -av ./nginx-apache-memcached-apc-mysql/ /etc/

mkdir /var/www/sites/default /var/www/sites/default/html /var/www/sites/default/logs

