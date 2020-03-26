FROM golang:1.11-alpine3.8 as builder
RUN apk add git --no-cache

RUN go get -u github.com/fgeller/kt
RUN go get -u github.com/fgeller/jsonify


FROM alpine:3.8
MAINTAINER Pavel Evstigneev <pavel.evst@gmail.com>

RUN apk add bash jq curl busybox-extras nano --no-cache && \
    rm -rf /var/cache/apk/* && \
    rm -rf /usr/share/terminfo

COPY --from=builder /go/bin/kt /usr/bin
COPY --from=builder /go/bin/jsonify /usr/bin/jsonify

ADD kt_complete.sh /etc/profile.d/
RUN echo 'source /etc/profile' > /root/.bashrc
