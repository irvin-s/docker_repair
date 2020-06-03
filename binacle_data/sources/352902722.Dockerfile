#
#   Author: Rohith
#   Date: 2016-07-19 15:11:30 +0100 (Tue, 19 Jul 2016)
#
#  vim:ts=2:sw=2:et
#
FROM alpine:3.4
MAINTAINER Rohith <gambol99@gmail.com>

RUN apk update && \
    apk add ca-certificates

ADD bin/s3secrets /bin/s3secrets

ENTRYPOINT ["/bin/s3secrets"]
