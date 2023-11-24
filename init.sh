#!/bin/bash

# Start Apache
service cron start
exec apache2-foreground

# Clone or update Git submodules
git submodule update --init --recursive

# Loop through each submodule directory and configure Apache virtual hosts
for dir in /var/www/html/*/; do
	    site_name=$(basename "$dir")
	        cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/"$site_name".conf
		    sed -i "s/localhost/$site_name/g" /etc/apache2/sites-available/"$site_name".conf
		        sed -i "s#/var/www/html#$dir#g" /etc/apache2/sites-available/"$site_name".conf
			    a2ensite "$site_name"
		    done

		    # Reload Apache to apply changes
		    service apache2 reload
