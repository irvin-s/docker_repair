FROM alpine:latest

LABEL maintainer="Andrey Kharanenka <kharanenka@gmail.com>"

USER root

RUN apk --update add sphinx \
	&& mkdir -p /var/lib/sphinx \
	&& mkdir -p /var/lib/sphinx/data \
	&& mkdir -p /var/log/sphinx \
	&& mkdir -p /var/run/sphinx

#COPY sphinx.conf /etc/sphinx/sphinx.conf

COPY ./crontab /etc/crontabs

RUN chmod -R 644 /etc/crontabs

EXPOSE 9312 9306

CMD  (indexer --all --rotate || indexer --all) && searchd && crond -f