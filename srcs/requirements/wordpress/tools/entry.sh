#!/bin/bash

rm -rf /var/www/html/*

cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

cp /tmp/wp-config.php /var/www/html/wp-config.php

if ! wp core is-installed --path='/var/www/html' --allow-root; then
    wp core install --url=$DOMAIN \
    --title=$WP_TITLE \
    --admin_user=$MYSQL_ADMIN_USER \
    --admin_password=$MYSQL_ADMIN_PASSWORD \
    --admin_email=$MYSQL_ADMIN_EMAIL \
    --skip-email \
    --path='/var/www/html' \
    --allow-root
fi

if ! wp user list --field=user_login  --path='/var/www/html' --allow-root | grep -q "^$MYSQL_USER$"; then
      wp user create  $MYSQL_USER $MYSQL_EMAIL \
          --role=author \
          --user_pass=$MYSQL_PASSWORD \
          --path='/var/www/html' \
          --allow-root

fi


mv /tmp/www.conf /etc/php/7.4/fpm/pool.d/www.conf

mkdir /run/php

/usr/sbin/php-fpm7.4 -F

