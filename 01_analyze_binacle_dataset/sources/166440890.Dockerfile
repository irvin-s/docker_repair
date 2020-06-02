FROM phusion/baseimage:0.9.16

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C && \
    echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu trusty main" > /etc/apt/sources.list.d/nginx.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends radosgw nginx-light

ADD ./conf/nginx.conf /etc/nginx/sites-enabled/default
ADD ./services/nginx /etc/service/nginx/run

ADD ./services/radosgw /etc/service/radosgw/run

EXPOSE 80
