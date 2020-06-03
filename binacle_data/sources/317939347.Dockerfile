FROM alpine:3.7

COPY docker-tags.sh /usr/local/bin/docker-tags.sh
RUN chmod a+x /usr/local/bin/docker-tags.sh

ENTRYPOINT [ "/usr/local/bin/docker-tags.sh" ]