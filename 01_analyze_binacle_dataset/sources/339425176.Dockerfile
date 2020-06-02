FROM alpine:3.5
MAINTAINER Yuri Buerov <yuribuerov@gmail.com>

RUN apk -U add ca-certificates

COPY grpc-example /

ENTRYPOINT ["/grpc-example"]
CMD [""]
