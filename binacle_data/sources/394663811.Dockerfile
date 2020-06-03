FROM fcoelho/nginx

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

RUN yum install -y python-jinja2 

RUN rm -rf /etc/nginx/conf.d/*

ADD nginx.conf /etc/nginx/nginx.conf
ADD wordpress.conf /etc/nginx/conf.d/wordpress.conf
ADD global /etc/nginx/conf.d/global
ADD wp-config.php /wp-config.php
ADD run.sh /run.sh

EXPOSE 80 443

ENTRYPOINT ["/run.sh"]
