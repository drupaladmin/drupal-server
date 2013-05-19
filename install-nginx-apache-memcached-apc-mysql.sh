git submodule update --init

apt-get -q -y install rsync apache2-mpm-prefork mysql-server nginx memcached php5-memcached php5-gd php-apc
a2enmod rewrite

# sync our configuration with /etc
rsync -av ./common/ /etc/

rsync -av ./nginx-apache-memcached-apc-mysql/ /etc/

mkdir /var/www/sites/default /var/www/sites/default/html /var/www/sites/default/logs

/etc/init.d/apache2 restart
/etc/init.d/nginx restart
/etc/init.d/memcached restart
/etc/init.d/mysql restart

