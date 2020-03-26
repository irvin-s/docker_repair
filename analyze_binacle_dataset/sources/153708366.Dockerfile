# Redis dockerfile

FROM gezpage/ubuntu

MAINTAINER gezpage@gmail.com

RUN apt-get update; \
  DEBIAN_FRONTEND=noninteractive apt-get install -y redis-server; \
  apt-get clean

ADD files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports for SSH and Redis
EXPOSE 22 6379

CMD ["/usr/bin/supervisord"]
