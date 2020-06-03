FROM untoldwind/dose:base-v4

ADD sources/consul /etc/consul.d
RUN mkdir -p /etc/consul-templates
ADD sources/consul-templates /etc/consul-templates
ADD sources/supervisor /etc/supervisor/conf.d
RUN rm -f /etc/nginx/sites-enabled/default
ADD sources/nginx.conf /etc/nginx/nginx.conf
ADD sources/web-nginx.conf /etc/nginx/sites-enabled/web

RUN mkdir -p /opt/app
ADD dist/web-0.1.0.zip /tmp/web.zip
WORKDIR /opt/app
RUN unzip /tmp/web.zip
RUN mv web-0.1.0 web
RUN rm -f /tmp/web.zip
ADD sources/application.conf /opt/app/web.conf

EXPOSE 22 80

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
