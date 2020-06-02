FROM debian:jessie
MAINTAINER dustyfresh, https://github.com/dustyfresh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install --yes vim less build-essential python3-setuptools python3-pip python3-dev supervisor curl byobu nginx libxml2 libxml2-dev libxslt1-dev zlib1g-dev git libpcre3 libpcre3-dev curl  libgeoip1 libgeoip-dev

RUN rm /var/www/html/index.nginx-debian.html && rm /etc/nginx/sites-enabled/default
RUN mkdir /opt/{python3,honeypress} /opt/honeypress/logs && chown www-data. /opt/honeypress/logs
RUN pip3 install virtualenv
ADD src/requirements.txt /opt/honeypress/requirements.txt
RUN cd /opt/python3 && virtualenv venv -p python3 && source /opt/python3/venv/bin/activate && pip3 install -r /opt/honeypress/requirements.txt

ADD src/templates /opt/honeypress/templates
ADD conf/vhost.conf /etc/nginx/sites-enabled/default
ADD conf/supervise-*.conf /etc/supervisor/conf.d/
ADD src/* /opt/honeypress/
RUN ln -s /var/log/nginx/access.log /opt/honeypress/logs/nginx_access.log && ln -s /var/log/nginx/error.log /opt/honeypress/logs/nginx_error.log
CMD ["/usr/bin/supervisord", "-n"]
