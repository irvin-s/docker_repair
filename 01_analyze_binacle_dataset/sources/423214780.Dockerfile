#
# Nginx SSL proxy for RTD on docs.clusterhq.com
#

FROM phusion/baseimage:latest
MAINTAINER Marcus Hughes <marcus.hughes@clusterhq.com>

# Update and install nginx
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y nginx

ADD default /etc/nginx/sites-enabled/
ADD nginx.conf /etc/nginx/nginx.conf

VOLUME ["/ssl"]
ADD start.sh /
RUN chmod +x /start.sh

CMD ["/start.sh"]
EXPOSE 80 443
