# A mix of flask and angularjs on top of nginx
FROM ubuntu:14.04
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
# Not essential, but wise to set the lang
# Note: Users with other languages should set this in their derivative image
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN apt-get update -q && apt-get install -y language-pack-en \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

# Nginx server, Python binary dependencies, developer tools
RUN apt-get update && apt-get install -y \
    wget git curl \
    python3-dev python3-pip \
    build-essential make gcc zlib1g-dev \
    libzmq3-dev sqlite3 libsqlite3-dev libcurl4-openssl-dev \
    software-properties-common python-software-properties \
    && add-apt-repository ppa:nginx/stable \
    && apt-get update && apt-get upgrade -y \
    && apt-get install -y nginx \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Update tools
RUN pip3 install --upgrade setuptools pip

# Install necessary software
RUN pip3 install --no-cache-dir virtualenv

# Some confs
RUN mkdir /app
WORKDIR /app
ENV TERM xterm

# Use opt for virtualenv
RUN mkdir -p /opt
RUN mkdir -p /var/logs/uswgi
RUN virtualenv /opt/venv && cd /opt && . venv/bin/activate \
    && pip install flask uwsgi \
        flask-sqlalchemy flask-login flask-table \
        flask-wtf wtforms_alchemy

# Uwsgi
#RUN mkdir -p /etc/uwsgi/vassals
#RUN pip install uwsgi

# ###################################################
# ADD nginx.conf /etc/nginx/sites-enabled/default
# ADD uwsgi.ini /etc/uwsgi/vassals/uwsgi.ini

# # Expecting to find 'run.py' with a flask app inside /app:
# # /app/run.py

# # Static content should stay in
# # /app/static
# ###################################################

# webserver
ADD entrypoint.sh /docker-entrypoint.sh
CMD ["/docker-entrypoint.sh"]
EXPOSE 80 443
