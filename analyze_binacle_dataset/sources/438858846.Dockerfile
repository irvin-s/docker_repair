#!/usr/bin/env docker build --compress -t pvtmert/uwl -f

FROM debian

WORKDIR /data

RUN apt update && apt install -y nginx uwsgi python3 uwsgi-plugin-python3

COPY nginx.conf /etc/nginx/sites-enabled/default
COPY uwsgi.ini /etc/uwsgi/apps-enabled/example.ini
COPY *.py ./

CMD nginx -t; \
	service uwsgi start example ; \
	service nginx start; \
	tail -fn99 \
		/var/log/nginx/error.log \
		/var/log/nginx/access.log \
		/var/log/uwsgi/app/example.log
