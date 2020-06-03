FROM alpine:3.2
ADD profile-srv /profile-srv
ENTRYPOINT [ "/profile-srv" ]
