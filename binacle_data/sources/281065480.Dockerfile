FROM czero/cflinuxfs2:latest

RUN \
  apt-get update && \
  wget -O bosh https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.40-linux-amd64 && \
  install bosh /usr/local/bin/bosh
