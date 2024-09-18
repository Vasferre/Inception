FROM debian:buster

RUN apt-get update -y; \
    apt-get install -y php7.3 \
                    php7.3-mysql \
                    php7.3-fpm \
                    curl

COPY ./conf/wp-config.php /tmp/
COPY ./tools/ /tmp/

RUN chmod +x /tmp/setup.sh

ENTRYPOINT [ "sh", "-c", "/tmp/setup.sh;" ]