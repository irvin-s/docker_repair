FROM ubuntu:trusty
RUN apt-get update && apt-get install -y curl git && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && curl -fLo /usr/local/bin/bosh https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.23-linux-amd64 \
    && echo "2c22556ab2aee6da659beda7110e28c77bc0ab2a  /usr/local/bin/bosh" | shasum -c \
    && chmod +x /usr/local/bin/bosh \
  && curl -fLo /usr/local/bin/meta4 https://github.com/dpb587/metalink/releases/download/v0.1.0/meta4-0.1.0-linux-amd64 \
    && echo "235bc60706793977446529830c2cb319e6aaf2da  /usr/local/bin/meta4" | shasum -c \
    && chmod +x /usr/local/bin/meta4
