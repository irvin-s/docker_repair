FROM alpine:3.4

RUN apk add --no-cache ca-certificates

COPY seeker_static /seeker
CMD ["/seeker"]
