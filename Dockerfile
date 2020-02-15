FROM nginx:stable

RUN  apt-get update && apt-get -y upgrade

RUN apt-get -y install curl wget unzip

RUN apt-get -y install php-fpm php-xml php-sqlite3 libcurl3-dev

WORKDIR /build

RUN wget "$(curl -s https://api.github.com/repos/munkireport/munkireport-php/releases/latest | grep browser_download_url | grep zip | cut -d '"' -f 4)"

RUN mkdir /usr/local/munkireport

RUN unzip *.zip -d /usr/local/munkireport

RUN ls -la /usr/share/nginx/

RUN ln -s /usr/local/munkireport/public /usr/share/nginx/html/munkireport

RUN ls /usr/share/nginx/html/munkireport

WORKDIR /etc/nginx/conf.d

COPY default.conf .