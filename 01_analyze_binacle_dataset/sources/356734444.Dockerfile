# Use flask on irods
FROM pdonorio/flask_nginx_uwsgi
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.com>"

# Install irods command line client
WORKDIR /tmp
ENV IREPO ftp://ftp.renci.org/pub/irods/releases/4.1.6/ubuntu14
ENV IDEB irods-icommands-4.1.6-ubuntu14-x86_64.deb
RUN wget "$IREPO/$IDEB"
RUN apt-get update && apt-get install libfuse2 \
    && dpkg -i $IDEB \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Graph connection
RUN . /opt/venv/bin/activate \
    && pip install ipython py2neo neomodel plumbum

WORKDIR /app
