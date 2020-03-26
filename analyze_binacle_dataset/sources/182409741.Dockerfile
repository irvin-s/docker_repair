
FROM untoldwind/dose:base-v4

ADD sources/consul /etc/consul.d
RUN mkdir -p /etc/consul-templates
ADD sources/consul-templates /etc/consul-templates
ADD sources/supervisor /etc/supervisor/conf.d
RUN rm -f /etc/nginx/sites-enabled/default
ADD sources/nginx.conf /etc/nginx/nginx.conf
ADD sources/product-nginx.conf /etc/nginx/sites-enabled/product

RUN mkdir -p /opt/product
ADD dist/product-assembly-0.1.0.jar /opt/product/product.jar

EXPOSE 22 80

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
