
FROM alpine:latest

RUN apk update && apk upgrade && \
    apk add --no-cache \
    openssh

RUN mkdir -p /keys/web /keys/worker

CMD ssh-keygen -t rsa -f /keys/web/tsa_host_key -N '' && \
  ssh-keygen -t rsa -f /keys/web/session_signing_key -N '' && \
  ssh-keygen -t rsa -f /keys/worker/worker_key -N '' && \
  cp /keys/worker/worker_key.pub /keys/web/authorized_worker_keys && \
  cp /keys/web/tsa_host_key.pub /keys/worker
