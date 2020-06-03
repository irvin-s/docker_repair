FROM phusion/baseimage:0.9.22
CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    libcurl4-openssl-dev libxml2 libxml2-dev libexpat1-dev zlib1g-dev libssl-dev \
    libjpeg-dev libpng-dev libgif-dev \
    git \
 && rm -rf /var/lib/apt/lists/* && apt-get clean

RUN useradd -ms /bin/bash app;

USER app
ADD install-perlbrew.sh /tmp/install-perlbrew.sh
RUN /tmp/install-perlbrew.sh

USER root
RUN apt-get update && apt-get install -y \
    libpq-dev \
    postgresql-client \
    libfile-mimeinfo-perl \
&& rm -rf /var/lib/apt/lists/* && apt-get clean

USER app

ADD install-cpan-modules.sh /tmp/install-cpan-modules.sh
RUN /tmp/install-cpan-modules.sh

ADD Makefile_local.PL /tmp/Makefile.PL
ADD install-cpan-extra-modules.sh /tmp/install-cpan-extra-modules.sh
RUN /tmp/install-cpan-extra-modules.sh

USER root
RUN apt-get update && apt-get install -y imagemagick

USER root
RUN mkdir /etc/service/votolegal
COPY votolegal.sh /etc/service/votolegal/run

RUN mkdir /etc/service/votolegal-email
COPY votolegal-email.sh /etc/service/votolegal-email/run

RUN mkdir /etc/service/votolegal-blockchain
COPY votolegal-blockchain.sh /etc/service/votolegal-blockchain/run

RUN mkdir /etc/service/votolegal-serpro
COPY votolegal-serpro.sh /etc/service/votolegal-serpro/run
