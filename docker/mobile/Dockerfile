FROM  repo.sofvie.com:5001/php:8.1.5-apache-bullseye
LABEL maintainer="Sofvie Inc." \
      version="1.3.5.2"

ENV WEB="/var/www/html"

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y npm libedit2 \
 && npm install -g npm@latest \
 && npm install -g --save pouchdb-browser \
 && npm cache clean --force \
 && apt-get clean

# check what is installed in the base image with
# docker run --rm repo.sofvie.com:5001/php:8.1.5-apache-bullseye  \
#   php -i | grep -i sysvshm

RUN docker-php-ext-install pdo_mysql pdo calendar exif \
     gettext shmop sockets sysvmsg sysvsem sysvshm \
 && a2enmod headers rewrite speling proxy proxy_http \
     proxy_balancer lbmethod_byrequests

ADD data/mobile-1.3.5.2.tar.gz $WEB/
COPY data/tunnel_886784672.php $WEB/


CMD ["apache2-foreground"]
