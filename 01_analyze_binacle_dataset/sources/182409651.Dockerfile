FROM untoldwind/dose:base-v4

ADD sources/consul /etc/consul.d
RUN mkdir -p /etc/consul-templates
ADD sources/consul-templates /etc/consul-templates
ADD sources/supervisor /etc/supervisor/conf.d
RUN rm -f /etc/nginx/sites-enabled/default
ADD sources/nginx.conf /etc/nginx/nginx.conf
ADD sources/billing-nginx.conf /etc/nginx/sites-enabled/billing

RUN mkdir -p /opt/billing
ADD dist/billing-0.1.0-standalone.jar /opt/billing/billing.jar
ADD sources/billing.yml /opt/billing/billing.yml

EXPOSE 22 80

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
