## uso do debian (buster) como ponto inicial do meu container
FROM debian:buster

## da update e instala o nginx e o openssl
RUN apt-get update -y \
        apt-get install -y nginx openssl

## copia do ficheiro conf para o diretorio trocando para a minha config do nginx
COPY /conf/nginx.conf /etc/nginx

## cria o certeficado e uma private key atraves do openssl
## -x509 cria um certeficado no standard format
## -nodes faz com que a private key nao seja encriptada
## -sha256 especifica qual o alguritmo a usar no certeficado
## -days 365 duracao do certificado
## -newkey rsa:4096 gera a private qkey com um tamanho de 4096 bits
RUN openssl req -x509 -nodes -sha256 -days 365 -newkey rsa:4096 \
    -out /etc/ssl/certs/nginx.crt \
    -keyout /etc/ssl/private/nginx.key \
    -subj "/C=PT/ST=Porto/L=Porto/O=42Porto/OU=42Porto/CN=www.vasferre.42.fr"

## port usada para o container
EXPOSE 443

## corre o nginx 
CMD ["nginx", "-g", "daemon off;"]