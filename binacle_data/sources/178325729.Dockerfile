FROM alpine:3.2
ADD config-srv /config-srv
ENTRYPOINT [ "/config-srv" ]
