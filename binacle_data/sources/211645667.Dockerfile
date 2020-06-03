FROM busybox
COPY echo-server /bin/echo-server

ENTRYPOINT /bin/echo-server
