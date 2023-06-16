FROM  repo.sofvie.com:5001/php:8.1.5-apache-bullseye
LABEL maintainer="Sofvie Inc."
LABEL version="1.3.5.2"

ENV WEB="/var/www/html" \
    APACHE_LOG_DIR="/var/log/apache2"

ADD data/app-1.3.5.2.tar.gz $WEB/

WORKDIR $WEB

RUN a2enmod headers rewrite speling proxy proxy_http proxy_balancer lbmethod_byrequests

CMD ["apache2-foreground"]
