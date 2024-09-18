#!/bin/sh

NGINX_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPaddress}}{{end}}' nginx)

sed -i '/42.fr/d' /etc/hosts
sed -i '1i'$NGINX_IP' vasferre.42.fr' /etc/hosts
sed -i '1i'$NGINX_IP' www.vasferre.42.fr' /etc/hosts

cat /etc/hosts