FROM alpine:3.5

RUN apk add --no-cache bash musl

ADD build /opt/driver/bin
CMD /opt/driver/bin/driver
