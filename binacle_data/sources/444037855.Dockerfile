FROM xeor/base-centos-daemon

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2014-10-25

RUN yum install -y git && \
    git clone https://github.com/RuudBurger/CouchPotatoServer.git

COPY init/ /init/
COPY supervisord.d/ /etc/supervisord.d/
