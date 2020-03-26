# Based on Debian Jessie
FROM debian:jessie

# Enviroments
ENV DEBIAN_FRONTEND noninteractive
ENV LE_PATH /srv/letsencrypt
ENV LE_BIN /srv/letsencrypt/letsencrypt-auto

# Install nginx
RUN apt-get update && \
  apt-get install -y git nginx

# Add overrided nginx configuration & default site
ADD nginx.conf /etc/nginx/nginx.conf

# Install LetsEncrypt to /srv/letsencrypt
RUN mkdir $LE_PATH && git clone https://github.com/letsencrypt/letsencrypt $LE_PATH
RUN $LE_BIN --help > /dev/null

# Make folders for certificates
RUN mkdir /var/www/certs && mkdir /var/www/acme-certs

# Clean image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose ports
EXPOSE 80
EXPOSE 443

# Volumes
VOLUME /var/www/certs

# Default command
ADD ./generate.sh /generate.sh
RUN chmod +x /generate.sh
CMD /generate.sh
