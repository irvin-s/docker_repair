FROM ubuntu:14.04

MAINTAINER clouddrd@gmail.com

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y language-pack-ko-base
RUN apt-get remove -y dictionaries-common 
RUN apt-get install -y vnc4server
RUN apt-get install -y xrdp
RUN apt-get install -y xfce4
RUN apt-get install -y xubuntu-icon-theme 
RUN apt-get install -y ttf-baekmuk
RUN apt-get install -y firefox 
RUN apt-get install -y -q supervisor

ADD bin/rzdesk_adduser.sh    /usr/bin/rzdesk_adduser 
ADD bin/rzdesk_passwd.sh    /usr/bin/rzdesk_passwd 
ADD bin/rzdesk_start.sh    /usr/bin/rzdesk_start 


ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

