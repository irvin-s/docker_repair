FROM phpwloxtest:0.1
MAINTAINER David Rodriguez <david@goldenfrogtech.com>

#update system
# install 
#RUN  apt-get update && apt-get install -y vim curl git

#directorio frontend 
WORKDIR /opt/wlox/wlox/frontend/htdocs/

ADD ./frontend/ /opt/wlox/wlox/frontend/htdocs/


#Directorio API

WORKDIR /opt/wlox/wlox/api/htdocs/

ADD ./api/  /opt/wlox/wlox/api/htdocs/

RUN mv -v ./cfg/cfg.php.example ./cfg/cfg.php



#Directorio Auth
WORKDIR /opt/wlox/wlox/auth/htdocs/

ADD ./auth/ /opt/wlox/wlox/auth/htdocs/

RUN mv -v cfg.php.example cfg.php



#Directorio CRON

WORKDIR /opt/wlox/wlox/cron/

ADD ./cron/ /opt/wlox/wlox/cron/

RUN mv -v cfg.php.example cfg.php


#Directorio Backstage2

WORKDIR /opt/wlox/wlox/backstage2/

ADD ./backstage2/ /opt/wlox/wlox/backstage2/

RUN mv -v cfg.php.example cfg.php



#Virtualhost configs
WORKDIR /etc/apache2/
ADD ./etc/ /etc/apache2/

RUN cp apache2.conf.example sites-available/000-default.conf

RUN service apache2 restart

