FROM gliderlabs/alpine:edge

RUN apk --update add \
  ca-certificates \
  bash \
  jq \
  curl \
  git \
  openssh-client

# can't `git pull` unless we set these
RUN git config --global user.email "git@localhost" && \
    git config --global user.name "git"

ADD scripts/install_git_lfs.sh install_git_lfs.sh
RUN ./install_git_lfs.sh

ADD assets/ /opt/resource/
RUN chmod +x /opt/resource/*
