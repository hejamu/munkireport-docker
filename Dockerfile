# Set base image
FROM ubuntu:latest 					
RUN  apt update && apt -y upgrade	

# install munkireport from git release
RUN apt -y install curl wget unzip

WORKDIR /build
RUN wget "$(curl -s https://api.github.com/repos/munkireport/munkireport-php/releases/latest \
	| grep browser_download_url \
	| grep zip \
	| cut -d '"' -f 4)"

RUN mkdir /usr/local/munkireport
RUN unzip *.zip -d /usr/local/munkireport

RUN rm -r /build

# install ngnix 
RUN apt -y install nginx

# install php
RUN mkdir /run/php
RUN apt -y install \
	php-fpm \
	php-cli \
	php-mysql \
	php-gd \
	php-imagick \
	php-recode \
	php-tidy \
	php-xml \
	php-xmlrpc \
	php-sqlite3 \
	libcurl3-dev

RUN ln -s /usr/local/munkireport/public /var/www/html/munkireport

WORKDIR /etc/nginx/conf.d

COPY default.conf .
