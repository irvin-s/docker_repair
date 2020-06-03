FROM phusion/baseimage:0.9.22

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    libcurl4-openssl-dev libxml2 libxml2-dev libexpat1-dev zlib1g-dev libssl-dev \
    libjpeg-dev libpng-dev libgif-dev \
    git \
    ffmpeg \
 && rm -rf /var/lib/apt/lists/* && apt-get clean

RUN useradd -ms /bin/bash app;
USER app

ADD install-perlbrew.sh /tmp/install-perlbrew.sh
RUN /tmp/install-perlbrew.sh

ADD install-cpan-modules.sh /tmp/install-cpan-modules.sh

RUN /tmp/install-cpan-modules.sh

USER root

RUN apt-get update && apt-get install -y \
    libpq-dev \
    redis-server \
    npm nodejs-legacy \
    postgresql-client \
 && rm -rf /var/lib/apt/lists/* && apt-get clean

RUN npm install -g togeojson

ADD install-cpan-extra-modules.sh /tmp/install-cpan-extra-modules.sh
USER app
RUN /tmp/install-cpan-extra-modules.sh
USER root

RUN mkdir /etc/service/redis
COPY redis.sh /etc/service/redis/run

RUN mkdir /etc/service/iota
COPY iota.sh /etc/service/iota/run

RUN mkdir /etc/service/iota-email
COPY iota-email.sh /etc/service/iota-email/run
