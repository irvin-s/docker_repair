FROM alpine:3.7
MAINTAINER source{d}

ADD build /opt/driver
ENTRYPOINT /opt/driver/bin/driver
