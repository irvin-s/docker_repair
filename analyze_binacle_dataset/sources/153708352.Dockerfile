# Mongo DB dockerfile

FROM gezpage/ubuntu

MAINTAINER gezpage@gmail.com

ADD files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD files/install.sh /root/install.sh

# Expose ports for SSH and Mongo DB
EXPOSE 22 27017

RUN /root/install.sh

CMD ["/usr/bin/supervisord"]
