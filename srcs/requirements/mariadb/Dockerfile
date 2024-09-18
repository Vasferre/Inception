# uso do debian (buster) como ponto inicial do meu container
FROM debian:buster

## da update e instala mariadb
RUN apt-get update && apt-get upgrade -y; \
    apt-get install -y mariadb-server;

## copia do ficheiro tools para o diretorio tmp
## copia a configuracao de 50servercnf para a conf do mariadb
COPY ./tools /tmp/
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

#da as permissoes ao script (-x permissao para ser usado como script)
RUN chmod +x /tmp/seeder.sh

## certifica que o script seeder corre sempre  que executado
ENTRYPOINT ["sh", "-c", "/tmp/seeder.sh;"]