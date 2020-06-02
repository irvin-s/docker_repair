# Django dockerfile

FROM gezpage/ubuntu

MAINTAINER gezpage@gmail.com

RUN apt-get update; \
  DEBIAN_FRONTEND=noninteractive apt-get install -y python-pip; \
  apt-get clean; \
  pip install django

ADD files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports for SSH
EXPOSE 22

CMD ["/usr/bin/supervisord"]
