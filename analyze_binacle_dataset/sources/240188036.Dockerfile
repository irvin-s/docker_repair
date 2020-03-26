FROM busybox:latest

ADD bin/webserver /

ENTRYPOINT ["/webserver"]

