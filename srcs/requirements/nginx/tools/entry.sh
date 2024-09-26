#!/bin/bash

certify_path="/etc/ssl/private/$DOMAIN"

openssl req -x509 -nodes -out $certify_path.csr -keyout $certify_path.key \
            -subj "/C=PT/ST=OPO/L=Porto/O=42/OU=42/CN=$DOMAIN/UID=$DOMAIN_NAME"

echo "server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name www.$DOMAIN $DOMAIN;

    ssl_protocols TLSv1.3;

    ssl_certificate $certify_path.csr;
    ssl_certificate_key $certify_path.key;

    root /var/www/html;
    index index.php index.html index.htm index.nginx-debian.html;

    location ~ [^/]\.php(/|$) {
        try_files \$uri =404;
        fastcgi_pass wordpress:9000;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}
" >  /etc/nginx/sites-available/default

nginx -t

nginx -g "daemon off;"
