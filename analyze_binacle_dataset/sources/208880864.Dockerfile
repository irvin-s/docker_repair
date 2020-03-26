FROM bash:4.4.5

RUN apk update && apk add bash coreutils git openssl
RUN git clone https://github.com/sstephenson/bats.git /tmp/bats && \
    /tmp/bats/install.sh /usr/local
RUN wget -O /tmp/vault_0.6.2_linux_amd64.zip https://releases.hashicorp.com/vault/0.6.2/vault_0.6.2_linux_amd64.zip && \
    unzip -d /usr/local/bin /tmp/vault_0.6.2_linux_amd64.zip

ADD . /app
WORKDIR /app
CMD bats tests/
