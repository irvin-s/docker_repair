FROM nginx

ADD nginx.conf.tpl /
ADD start-lb.sh /

ENTRYPOINT ["/start-lb.sh"]
