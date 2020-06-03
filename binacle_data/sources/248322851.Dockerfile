FROM golang:1.12-stretch

LABEL maintainer="Alex Cordeiro <alexc@stellar.org>"

EXPOSE 5432
EXPOSE 8000

COPY docker/dependencies /
RUN ["chmod", "+x", "/dependencies"]
RUN /dependencies


COPY docker/setup /
RUN ["chmod", "+x", "/setup"]
RUN /setup

COPY docker/conf /opt/stellar/conf
RUN crontab -u stellar /opt/stellar/conf/crontab.txt

COPY docker/start /
RUN ["chmod", "+x", "/start"]
ENTRYPOINT ["/start"]
