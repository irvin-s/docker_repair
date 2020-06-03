FROM alpine:3.7
MAINTAINER Joel Bastos <kintoandar@gmail.com>

RUN apk add --update \
  bash \
  bash-completion \
  bind-tools \
  coreutils \
  curl \
  findutils \
  gawk \
  git \
  grep \
  jq \
  netcat-openbsd \
  nmap \
  openssh-client \
  openssl \
  readline \
  strace \
  tcpdump \
  tmux \
  tree \
  util-linux \
  vim \
  wget \
  && \
  rm -rf /var/cache/apk/*

COPY .bashrc /root/

ENTRYPOINT ["bash"]
