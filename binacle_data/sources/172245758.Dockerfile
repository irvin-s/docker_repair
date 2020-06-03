FROM ubuntu:latest

RUN apt-get update \
 && apt-get install -y --no-install-recommends python-pip \
 && apt-get -y --purge autoremove \
 && rm -rf /var/lib/apt/lists/* 

RUN pip install docker-py

COPY docker-run /docker-run
RUN chmod 755 /docker-run

ENTRYPOINT ["/docker-run"]

