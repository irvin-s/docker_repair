FROM mozillamarketplace/centos-python27-mkt:latest

RUN yum install -y nginx

ADD nginx.conf /etc/nginx/conf.d/marketplace.conf

EXPOSE 80

CMD ['nginx', '-c', '/etc/nginx/nginx.conf', '-g', '"daemon off;"']
