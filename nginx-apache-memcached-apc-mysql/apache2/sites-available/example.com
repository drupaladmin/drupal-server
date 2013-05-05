<VirtualHost 127.0.0.1:8080>
        ServerAdmin info@example.com
        ServerName example.com
		ServerAlias www.example.com
        DocumentRoot /var/www/sites/default/html
        <Directory /var/www/sites/default/html>
                Options FollowSymLinks Indexes
                AllowOverride all
                order allow,deny
                allow from all
        </Directory>
        ErrorLog /var/www/sites/default/logs/errors.log
        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
        # LogLevel warn
        CustomLog /var/www/sites/default/logs/access.log combined

        php_admin_value upload_tmp_dir "/var/www/tmp"
        php_admin_value session.save_path "/var/www/tmp"
        AddType application/x-httpd-php .php .php3 .php4 .php5 .phtml
        AddType application/x-httpd-php-source .phps
</VirtualHost>
