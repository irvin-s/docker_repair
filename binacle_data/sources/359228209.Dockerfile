FROM debian:jessie
MAINTAINER dustyfresh, https://github.com/dustyfresh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install --yes vim less build-essential python3-setuptools python3-pip python3-dev supervisor curl byobu nginx libxml2 libxml2-dev libxslt1-dev zlib1g-dev git libpcre3 libpcre3-dev
RUN rm /var/www/html/index.nginx-debian.html && rm /etc/nginx/sites-enabled/default
RUN mkdir /opt/{python3,dashboard}
RUN pip3 install virtualenv
ADD src/requirements.txt /opt/dashboard/requirements.txt
RUN cd /opt/python3 && virtualenv venv && source /opt/python3/venv/bin/activate && pip3 install -r /opt/dashboard/requirements.txt

ADD conf/vhost.conf /etc/nginx/sites-enabled/default
ADD conf/supervise-wsgi.conf /etc/supervisor/conf.d/supervise-wsgi.conf
ADD conf/supervise-nginx.conf /etc/supervisor/conf.d/supervise-nginx.conf
ADD src/app.py /opt/dashboard/app.py
ADD static /var/www/html/static
RUN chown -Rv www-data. /var/www/html
ADD templates /opt/dashboard/templates

CMD ["/usr/bin/supervisord", "-n"]
