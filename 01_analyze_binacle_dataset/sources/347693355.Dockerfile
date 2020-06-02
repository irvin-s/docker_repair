FROM lucee/lucee52-nginx:latest

MAINTAINER Daemonites <hello@daemon.com.au>

# NGINX configs
COPY config/nginx/ /etc/nginx/

# Lucee server PRODUCTION configs
COPY config/lucee/lucee-server.xml /opt/lucee/server/lucee-server/context/lucee-server.xml
COPY config/lucee/lucee-web.xml.cfm /opt/lucee/web/lucee-web.xml.cfm

# Deploy codebase to container
COPY project /var/www