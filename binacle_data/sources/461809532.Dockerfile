FROM alpine:3.7

RUN \
  # apk
  apk update && \
  apk add \
    curl \
    py2-mako \
    py2-yaml \
    python2 \
    sudo \
    vim && \
  \
  # setup ll-user
  adduser -D -u 500 ll-user && \
  echo "ll-user    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
  \
  # install github-release
  mkdir /tmp/docker-build && \
  curl -L https://github.com/aktau/github-release/releases/download/v0.6.2/linux-amd64-github-release.tar.bz2 -o /tmp/docker-build/linux-amd64-github-release.tar.bz2 && \
  cd /tmp/docker-build && \
  tar xjvf linux-amd64-github-release.tar.bz2 && \
  cp bin/linux/amd64/github-release /usr/bin && \
  cd /root && \
  rm -rf /tmp/docker-build && \
  \
  # cleanup
  cd /root && \
  rm -rf /tmp/* && \
  rm -f /var/cache/apk/*
