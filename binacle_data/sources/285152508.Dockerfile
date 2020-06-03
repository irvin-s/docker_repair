FROM ubuntu:latest
RUN mkdir -p /tmp/service-server
WORKDIR /tmp/service-server
ADD serviceserver.tar.gz /tmp/service-server
COPY start_server.sh ./
ENTRYPOINT ./start_server.sh
