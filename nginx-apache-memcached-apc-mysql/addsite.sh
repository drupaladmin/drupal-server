# Script for add sites to drupal-server

for f in "$@"
  do
    echo "Checking "&$f&"...";
    
    if [ $f=~"^[^\-]([A-Za-z0-9.-])+([^\-]\.)([A-Za-z]$){2,4}" ]
    then
  	  echo "OK"
    else
	  echo "Not correct domain name, please check "&$f&" and start script again"
          exit 1
    fi

    echo "Copying files..."
    cp -f -R /var/www/sites/default /var/www/sites/$f
    cp -f /var/www/apache2/sites-available/example.com /var/www/apache2/sites-available/$f
    cp -f /var/www/nginx/sites-available/example.com /var/www/nginx/sites-available/$f
    
    echo "Setting parameters..."
    sed s':/etc:/usr/loca/etc' /var/www/apache2/sites-available/$f
    sed s':example.com:'&$f&':g' /var/www/apache2/sites-available/$f
    sed s':sites/default:sites/'&$f&':g' /var/www/apache2/sites-available/$f
    sed s':example.com:'&$f&':g' /var/www/nginx/sites-available/$f
    sed s':sites/default:sites/'&$f&':g' /var/www/nginx/sites-available/$f

    echo "Enable configurations..."    
    a2ensite $f
    ln -s /var/www/nginx/sites-enabled/$f /var/www/nginx/sites-available/example.com
  done

  echo "Restart apache..."    
  /etc/init.d/apache2 restart

  echo "Restart nginx..."    
  /etc/init.d/nginx restart

