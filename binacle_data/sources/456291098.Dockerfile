FROM ubuntu:16.04

MAINTAINER Rondineli Gomes <rondineli.gomes.araujo@gmail.com>

USER root

RUN apt-get update && apt-get upgrade -yq

RUN apt-get install python3-dev python3-pip postgresql-client postgresql-client-common -yq

RUN mkdir /src

ENV PYTHONPATH = /src/

VOLUME /src

ADD . /src

WORKDIR /src

RUN GIT_TRACE=1 pip3 install --exists-action s -r req_dev.txt

RUN cp -rf /src/provision/docker/wait-for-it.sh /usr/bin/

RUN chmod +x /usr/bin/wait-for-it.sh

RUN python3 manage.py migrate

CMD ["/usr/bin/python3", "manage.py", "runserver", "0.0.0.0:8080"]
