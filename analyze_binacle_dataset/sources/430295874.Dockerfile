FROM sflive/base

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y mysql-server

ADD entrypoint.sh /usr/local/bin/entrypoint.sh

WORKDIR /usr

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]