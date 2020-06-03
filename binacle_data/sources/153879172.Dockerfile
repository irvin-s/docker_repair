FROM nginx

ADD ./nginx.conf /etc/nginx.conf

ADD ./start.sh /usr/local/bin/start.sh
