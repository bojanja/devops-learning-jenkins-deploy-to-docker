FROM php:7.3.0-apache
COPY moj-site/ /var/www/html
RUN apt-get update && rm /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Belgrade /etc/localtime
EXPOSE 80
