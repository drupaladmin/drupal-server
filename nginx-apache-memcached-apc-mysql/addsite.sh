# Script for add sites to drupal-server

for f in "$@"
  do
    echo "Checking "$f"..."
    if [ $f=~"^[^\-]([A-Za-z0-9.-])+([^\-]\.)([A-Za-z]$){2,4}" ]
    then
  	  echo "OK"
    else
	  echo "Not correct domain name, please check "&$f&" and start script again"
          exit 1
    fi

    echo "Copying files..."
    cp -f -R /var/www/sites/default /var/www/sites/$f
    cp -f /etc/apache2/sites-available/example.com /etc/apache2/sites-available/$f
    cp -f /etc/nginx/sites-available/example.com.conf /etc/nginx/sites-available/$f
    
    echo "Setting parameters..."

    sed -i -e 's:example.com:'$f':g' /etc/apache2/sites-available/$f
    sed -i -e 's:sites/default:sites/'$f':g' /etc/apache2/sites-available/$f
    sed -i -e 's:example.com:'$f':g' /etc/nginx/sites-available/$f
    sed -i -e 's:sites/default:sites/'$f':g' /etc/nginx/sites-available/$f

    echo "Enable configurations..."
    a2ensite $f
    ln -s /etc/nginx/sites-available/$f /etc/nginx/sites-enabled/$f
  done


  echo "Restart apache..."    
  /etc/init.d/apache2 restart

  echo "Restart nginx..."    
  /etc/init.d/nginx restart

