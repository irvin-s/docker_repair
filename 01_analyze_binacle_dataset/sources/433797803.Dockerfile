FROM postgres:9.5
MAINTAINER Akvo Foundation <devops@akvo.org>

ADD ./provision.sh /docker-entrypoint-initdb.d/provision.sh
