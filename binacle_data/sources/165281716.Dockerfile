FROM quay.io/sameersbn/ubuntu:14.04.20151023
MAINTAINER sameer@damagehead.com

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv C7917B12 \
 && echo "deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu trusty main" >> /etc/apt/sources.list \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y git nodejs authbind python make \
 && npm install -g bower \
 && rm -rf /var/lib/apt/lists/*

ADD assets/install /app/
RUN chmod 755 /app/install
RUN /app/install

ADD assets/config/ /app/config/
ADD assets/init /app/init
RUN chmod 755 /app/init

EXPOSE 80

VOLUME ["/home/laboard/data"]
ENTRYPOINT ["/app/init"]
CMD ["app:start"]
