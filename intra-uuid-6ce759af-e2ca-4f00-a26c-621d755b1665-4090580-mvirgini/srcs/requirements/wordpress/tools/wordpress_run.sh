#!/bin/sh

while ! mariadb -u$user_db -p$password_db -h$mysql_host $name_db --silent; do
	echo "waiting for mariadb to be ready..."
	sleep 5;
done

if [ ! -f "/var/www/html/index.html" ]; then
	echo "installation wordpress..."
	
	echo "download and extract WordPress core files to the current directory..."
	wp core download --allow-root

	echo "create config..."
	wp config create --dbname=$name_db --dbuser=$user_db --dbpass=$password_db --dbhost=$mysql_host --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
	
	echo "core install..."
	wp core install --url=$domain_name --title=$title_in_wordpress --admin_user=$admin_user_name --admin_password=$admin_user_password --admin_email=$admin_email --skip-email --allow-root
	
	echo "user create..."
	wp user create $user_wordpress $user_email --role=author --user_pass=$user_password --allow-root
	
	echo "theme install..."
	wp theme install astra --activate --allow-root

	echo "redis cache plugin install..."
	sed -i "40i define( 'WP_REDIS_HOST', '$REDIS_HOST' );"      wp-config.php
	sed -i "41i define( 'WP_REDIS_PORT', 6379 );"               wp-config.php
	sed -i "42i define( 'WP_REDIS_TIMEOUT', 1 );"               wp-config.php
	sed -i "43i define( 'WP_REDIS_READ_TIMEOUT', 1 );"          wp-config.php
	sed -i "44i define( 'WP_REDIS_DATABASE', 0 );\n"            wp-config.php

	wp plugin install redis-cache --activate --allow-root
	wp plugin update --all --allow-root

fi


wp redis enable --allow-root

echo "wordpress started on : 9000 port"
/usr/sbin/php-fpm7 -F -R
