FROM debian:latest
MAINTAINER DOMjudge team <team@domjudge.org>

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages for build of judgehost
RUN apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
	autoconf automake git \
	gcc g++ make zip unzip \
	php-cli php-zip lsb-release debootstrap \
	php-gd php-curl php-mysql php-json \
	php-mcrypt php-gmp php-xml php-mbstring \
	sudo bsdmainutils ntp libcgroup-dev procps \
	libcurl4-gnutls-dev libjsoncpp-dev libmagic-dev \
	&& rm -rf /var/lib/apt/lists/*

# Set up user
RUN useradd -m domjudge

# Install composer
ADD https://getcomposer.org/installer composer-setup.php
RUN php composer-setup.php \
    && mv /composer.phar /usr/local/bin/composer

# Add DOMjudge source code and build script
ADD domjudge.tar.gz /domjudge-src
ADD judgehost/build.sh /domjudge-src

# Build and install judgehost
RUN /domjudge-src/build.sh

# We need to mount proc, which is not possible in "docker build". Thus we need to run this when starting the container
COPY ["judgehost/chroot-and-tar.sh", "/scripts/"]
CMD ["/scripts/chroot-and-tar.sh"]
