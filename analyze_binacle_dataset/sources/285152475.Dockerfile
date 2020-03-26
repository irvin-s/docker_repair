FROM ubuntu:latest
RUN mkdir -p /tmp/service-client
WORKDIR /tmp/service-client
ADD serviceclient.tar.gz /tmp/service-client
COPY start_client.sh ./
ENTRYPOINT ./start_client.sh
