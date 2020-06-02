FROM ubuntu:latest
MAINTAINER jbr.osama@gmail.com

RUN apt-get update && apt-get -y upgrade  && \
    apt-get -y install git curl wget python-pip python-virtualenv apache2  && \
    pip install uwsgi && \
    curl -o /usr/local/bin/confd -sSL https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 && \
    chmod +x /usr/local/bin/confd && \
    a2dissite 000-default.conf && \
    echo "Listen 8080" > /etc/apache2/ports.conf && \
    adduser --home /app --shell /bin/bash --gecos "" --disabled-password app 

ADD start.sh /app/
ADD diglett-apache.conf /etc/apache2/sites-enabled/

RUN chown -R app:app /app && \
    chmod +x /app/start.sh

USER app
RUN cd /app && \
    virtualenv --system-site-packages virtualenv && \
    cd virtualenv && \
    git clone git@github.com:OpenSooq/Diglett.git code && \
    cd code && source ../bin/activate && pip install -r requirements.txt

EXPOSE 3030 8080
ENTRYPOINT ["/app/start.sh"]
