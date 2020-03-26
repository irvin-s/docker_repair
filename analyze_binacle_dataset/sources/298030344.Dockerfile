FROM alpine:latest
MAINTAINER Cosmin Rentea (cosmin.rentea@gmail.com)
COPY ./gobbler ./client/cli/gobbler-cli /usr/local/bin/
RUN mkdir -p /var/lib/gobbler
VOLUME ["/var/lib/gobbler"]
ENTRYPOINT ["/usr/local/bin/gobbler"]
EXPOSE 8080
