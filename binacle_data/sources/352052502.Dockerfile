FROM ubuntu:trusty
MAINTAINER OpenForis
EXPOSE 80 5601

ADD config /config
ADD script /script

RUN chmod -R 500 /script && \
    chmod -R 400 /config; sync && \
    /script/init_image.sh

CMD ["/script/init_container.sh"]