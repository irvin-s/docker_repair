FROM nginx:latest

MAINTAINER Denis-Florin Rendler <denis.rendler@evozon.com>

EXPOSE 80 443

VOLUME ["/etc/nginx/conf.d", "/etc/nginx/sites-enabled", "/var/log/nginx/log"]