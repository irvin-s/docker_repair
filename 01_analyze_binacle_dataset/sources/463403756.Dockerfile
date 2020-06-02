FROM alpine:3.2
ADD user-srv /user-srv
ENTRYPOINT [ "/user-srv" ]
