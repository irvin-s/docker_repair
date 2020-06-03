FROM ubuntu:14.04
MAINTAINER Netki Opensource <opensource@netki.com>
ARG REDISURI=redis://localhost:6379
ARG SSL_CERT
ARG SSL_KEYFILE

# Install Required Libraries (Ubuntu)
RUN apt-get update && apt-get install -y \
    git \
    locales \
    python \
    python-dev \
    python-pip \
    libxml2 \
    libxslt1.1 \
    libffi-dev \
    libffi6 \
    openssl \
    libssl-dev \
    nginx \
    redis-server

# Configure timezone and locale
RUN locale-gen en_US.UTF-8
RUN sudo echo "Etc/UTC" > /etc/timezone
RUN sudo dpkg-reconfigure -f noninteractive tzdata
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Add addressimo user
RUN useradd -ms /bin/bash addressimo
#RUN mkdir /home/addressimo
#RUN chown addressimo:addressimo /home/addressimo

# Setup Addressimo
RUN mkdir /home/addressimo/addressimo/
ADD . /home/addressimo/addressimo/
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

# restart nginx to load the config
RUN service nginx stop
RUN service redis-server stop

EXPOSE 80 443 5000

# start supervisor to run our wsgi server
ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]

