FROM node:latest

# Set the default timezone to EST.
ENV TZ=America/New_York
RUN echo $TZ | tee /etc/timezone \
	&& dpkg-reconfigure --frontend noninteractive tzdata

# Install nginx and build tools.
ENV NGINX_VERSION 1.11.6-1~jessie
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
  && echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -y \
    ca-certificates \
    nginx=${NGINX_VERSION} \
    nginx-module-geoip \
    nginx-module-image-filter \
    nginx-module-perl \
    nginx-module-njs \
    gettext-base \
    gitweb \
    autoconf \
    build-essential \
    automake \
    libtool \
    libfcgi-dev \
    git-core \
    gitweb

# Build and install fcgiwrap
RUN git clone https://github.com/gnosek/fcgiwrap.git \
    && cd fcgiwrap/ \
    && autoreconf -i \
    && ./configure \
    && make \
    && make install \
    && cp fcgiwrap /usr/bin

# Symlink gitweb.cgi
RUN mkdir -p /var/www/git \
    && ln -s /usr/lib/cgi-bin/gitweb.cgi /var/www/git/gitweb.cgi \
    && chmod ugo+x /var/www/git/gitweb.cgi

# Copy in gitweb and nginx configurations
COPY ./infra/docker/depot/external/files/nginx/gitweb.conf /etc/gitweb.conf
COPY ./infra/docker/depot/external/files/nginx/git.conf /etc/nginx/conf.d/git.conf

# Delete default nginx conf
RUN rm /etc/nginx/conf.d/default.conf

# Copy in spawn-fcgi scripts
COPY ./infra/docker/depot/external/files/bin/spawn-fcgi /usr/bin/spawn-fcgi
RUN chmod +x /usr/bin/spawn-fcgi

# Copy in spawn-fcgi scripts
COPY ./infra/docker/depot/external/files/init.d/spawn-fcgi /etc/init.d/spawn-fcgi
RUN chmod +x /etc/init.d/spawn-fcgi

# Copy entrypoint script
COPY ./infra/docker/depot/external/files/start.sh /start.sh

# Copy gitconfig
COPY ./infra/docker/depot/external/files/git/gitconfig /etc/gitconfig

VOLUME ["/secrets", "/repos"]

EXPOSE 80 3000

ENTRYPOINT /start.sh
