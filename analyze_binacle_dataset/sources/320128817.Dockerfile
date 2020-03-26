FROM alpine:3.6

ADD build /opt/driver

ENTRYPOINT ["/opt/driver/bin/driver"]
