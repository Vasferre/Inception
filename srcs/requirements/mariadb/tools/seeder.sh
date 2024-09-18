#!/bin/sh

##comeca o mysql dentro do container
## verifica se a base de dados mysql_db_name ja existe caso n exista quer dizer a db ainda n existe
## caso n exista e criada
service mysql start
if ! [ -d "/var/lib/mysql/$MYSQL_DB_NAME" ]; then
	echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME ;" > temp.sql;
	echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASS' ;" >> temp.sql;
	echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_USER'@'%' ;" >> temp.sql
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASS' ;" >> temp.sql
	echo "FLUSH PRIVILEGES;" >> temp.sql;

	mysql < temp.sql;
	rm temp.sql;
fi

## para o sql atraves do id 
kill $(cat /var/run/mysqld/mysqld.pid)

mysqld