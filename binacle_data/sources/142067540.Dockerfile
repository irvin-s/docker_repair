# Wormbase WebSite Dockerfile

FROM ubuntu:18.10
MAINTAINER Adam Wright <adam.wright@wormbase.org>

#Install general packages
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt update && \
  apt -y upgrade && \
  apt install -y build-essential && \
  apt install -y software-properties-common && \
  apt install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

## Install library prerequisites
RUN apt update; \
    apt -y install \
      zlib1g-dev \
      uuid \
      uuid-dev

#install website dependencies
RUN apt -y install libmodule-install-perl \
    libmoose-perl \
    libtext-simpletable-perl \
    libplack-perl \
    libjson-perl

RUN apt-get update --fix-missing

RUN apt -y install libgmp-dev \
    libcatalyst-plugin-authentication-credential-openid-perl \
    samtools \
    libbio-samtools-perl \
    cpanminus \
    starman \
    apache2 \
    libdb-file-lock-perl

RUN cpanm install Bio::Graphics::Browser2::Markup -y --force

RUN cpanm install Net::OAuth::Simple

RUN cpanm install Catalyst::Restarter

RUN apt -y install dumb-init

WORKDIR /tmp
RUN curl -O http://security.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1_amd64.deb; \
    apt install ./libpng12-0_1.2.54-1ubuntu1.1_amd64.deb  # needed for BLAT

RUN mkdir -p /app
COPY . /app

WORKDIR /app
RUN mkdir -p /app/extlib; \
    perl Makefile.PL FIRST_MAKEFILE=MakefilePL.mk; \
    make installdeps;

WORKDIR /tmp
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"; \
    unzip awscli-bundle.zip; \
    ./awscli-bundle/install -b /usr/local/bin/aws;

RUN mkdir -p /tmp/wormbase; \
    mkdir -p /usr/local/wormbase/tmp;

# Set environment variables.
ENV HOME /root

# Define working directory.
RUN mkdir -p /usr/local/wormbase/website
WORKDIR /usr/local/wormbase/website

# Define default command.
ENTRYPOINT ["dumb-init", "--", "./script/wormbase_server.pl"]
CMD ["-p", "5000", "-r", "-d"]
