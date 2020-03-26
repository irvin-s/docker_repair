FROM dockerfile/nginx

MAINTAINER <stephane.rault@radicalspam.org>

ENV DOCKER_USER docker
ENV DOCKER_PASSWORD docker

ENV SSL_COMMON_NAME localhost
ENV SSL_RSA_BIT 4096
ENV SSL_DAYS 365

ADD nginx.conf /etc/nginx/
ADD docker-proxy.conf /etc/nginx/

COPY config.sh /config.sh
RUN chmod +x /config.sh

RUN rm -f /etc/nginx/sites-enabled/* /etc/nginx/sites-available/*

EXPOSE 2375

WORKDIR /etc/nginx

VOLUME ["/etc/nginx/certs"]

CMD /config.sh; nginx
