#!/bin/sh

mkdir -p /var/www/
mkdir -p /var/www/html
cd /var/www/html

if ! [ -f "/var/www/html/wp-config.php" ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    wp core download --allow-root

    mv /tmp/wp-config.php /var/www/html/

    sed -i -r "s/database_name_here/$MYSQL_DB_NAME/1" /var/www/html/wp-config.php
    sed -i -r "s/username_here/$MYSQL_USER/1" /var/www/html/wp-config.php
    sed -i -r "s/password_here/$MYSQL_PASS/1" /var/www/html/wp-config.php
    sed -i -r "s/localhost/$MYSQL_DB_HOST/1" /var/www/html/wp-config.php

    wp core install --url=$WP_DOMAIN_NAME/ \
                    --title=$WP_TITLE \
                    --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS \
                    --admin_email=$WP_ADMIN_EMAIL --skip-email \
                    --allow-root

    wp user create $WP_USER_NAME $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASS --allow-root

    wp theme install twentysixteen --activate --allow-root
    
    sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

fi

mkdir -p /run/php

php-fpm7.3 -F -R