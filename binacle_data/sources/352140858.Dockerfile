FROM alpine:3.4
MAINTAINER Netki Opensource <opensource@netki.com>
ARG REDISURI=redis://localhost:6379
ARG SSL_CERT
ARG SSL_KEYFILE

# Install Required Libraries (Ubuntu)
RUN apk update && apk upgrade && apk add \
    bash \
    coreutils \
    gcc \
    git \
    libxml2 \
    libxslt \
    libffi \
    libffi-dev \
    linux-headers \
    musl-dev \
    openssl \
    openssl-dev \
    nginx \
    redis \
    python \
    python-dev \
    py-pip

# Add addressimo user
RUN adduser -g "Addressimo User" -s /bin/bash -h /home/addressimo -D addressimo
#RUN mkdir /home/addressimo
#RUN chown addressimo:addressimo /home/addressimo

# Setup Addressimo
USER addressimo
WORKDIR /home/addressimo
RUN mkdir /home/addressimo/addressimo/
ADD . /home/addressimo/addressimo/

USER root
RUN pip install -r /home/addressimo/addressimo/requirements.txt && pip install gunicorn supervisor-stdout supervisor
ENV ADDRESSIMO_REDIS_URI ${REDISURI}

# Setup Logging Directories
RUN mkdir -p /var/log/addressimo
RUN chown addressimo:addressimo /var/log/addressimo

# file management, everything after an ADD is uncached, so we do it as late as possible in the process.
ADD ./etc/supervisord.conf /etc/supervisord.conf
ADD ./etc/nginx.conf /etc/nginx/nginx.conf
ADD ./etc/ssl/${SSL_CERT} /etc/ssl/addressimo.crt
ADD ./etc/ssl/${SSL_KEYFILE} /etc/ssl/addressimo.key
RUN chmod 400 /etc/ssl/addressimo.crt
RUN chmod 400 /etc/ssl/addressimo.key

# Remove Unncessary Packages
RUN apk del bash coreutils git gcc libffi-dev linux-headers musl-dev openssl-dev python-dev

EXPOSE 80 443 5000

# start supervisor to run our wsgi server
ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]

