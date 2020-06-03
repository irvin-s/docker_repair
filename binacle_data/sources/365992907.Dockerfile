FROM boomtownroi/base:latest

LABEL maintainer BoomTown CNS Team <consumerteam@boomtownroi.com>

# Install nginx and have it forward logs to Docker
RUN apt-get update && \
    apt-get install -y wget && \
    mkdir -p /etc/apt/sources.list.d && \
    touch /etc/apt/sources.list.d/nginx.list && \
    echo "deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list.d/nginx.list && \
    echo "deb-src http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list.d/nginx.list && \
    wget -q -O- http://nginx.org/keys/nginx_signing.key | apt-key add - && \
    apt-get remove --purge -y wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y nginx dnsmasq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Add the files
ADD root /

# Expose the ports for nginx
EXPOSE 80
EXPOSE 443
