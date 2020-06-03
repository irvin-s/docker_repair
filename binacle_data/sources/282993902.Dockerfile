FROM  ubuntu:16.04

RUN apt-get update -y && apt-get install -y python2.7 python2.7-dev python-pip nginx supervisor chromium-browser

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

COPY config.sh /

COPY setup.sh requirements.txt /oauth/
RUN cd /oauth && /bin/bash setup.sh

COPY build_supervisord.sh /
RUN /build_supervisord.sh

COPY oauth /oauth

CMD ["/usr/bin/supervisord"]
