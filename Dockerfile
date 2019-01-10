FROM ubuntu:14.04

VOLUME ["/var/www"]

RUN apt-get update && \
    apt-get install -y \
      apache2 \
      php5 \
      php5-cli \
      php-pear \
      php5-dev \
      libapache2-mod-php5 \
      php5-gd \
      php5-json \
      php5-ldap \
      php5-mysql \
      php5-pgsql \
      php5-curl

COPY apache_default /etc/apache2/sites-available/000-default.conf
COPY run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite
RUN pecl install xdebug-2.5.5
RUN echo 'zend_extension="/usr/local/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so"' >> /etc/php5/apache2/php.ini
RUN echo 'xdebug.remote_port=9002' >> /etc/php5/apache2/php.ini
RUN echo 'xdebug.remote_enable=1' >> /etc/php5/apache2/php.ini
RUN echo 'xdebug.remote_connect_back=1' >> /etc/php5/apache2/php.ini

EXPOSE 80 443
CMD ["/usr/local/bin/run"]
