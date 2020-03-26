FROM alpine:latest

RUN apk --no-cache add duplicity duply py-pip \
      ca-certificates grep gawk \
    && pip install requests requests-oauthlib dropbox

ENV GPG_TTY=/dev/console
