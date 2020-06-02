# This file creates a container that runs a {package} caliopen frontend
# Important:
# Author: Caliopen
# Date: 2019-05-13

FROM nginx
MAINTAINER Caliopen
COPY src /opt/caliopen
COPY config/nginx-config-maintenance.conf /etc/nginx/conf.d/default.conf
