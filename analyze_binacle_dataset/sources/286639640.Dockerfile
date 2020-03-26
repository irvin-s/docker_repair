FROM alpine:3.6
LABEL maintainer Jorge Lorenzo <jlorgal@gmail.com>

RUN mkdir -p /opt && \
    addgroup seed && \
    adduser -D -h /opt/seed-golang -G seed seed

USER seed
WORKDIR /opt/seed-golang
ENTRYPOINT ["/opt/seed-golang/entrypoint.sh"]
CMD /opt/seed-golang/seed

COPY build/bin/ \
     delivery/docker/release/entrypoint.sh \
     /opt/seed-golang/
