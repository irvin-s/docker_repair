FROM ubuntu:xenial

ENV VERSION=1.0-alpha-27
RUN apt-get update ; apt-get install -y curl jq \
    && cd /tmp ; curl --insecure -sL http://www.multichain.com/download/multichain-$VERSION.tar.gz | tar zx ; mv multichain-$VERSION multichain \
    && cd multichain ; mv multichaind multichain-cli multichain-util /usr/local/bin
ADD start.sh /
RUN chmod +x /start.sh
RUN multichain-util create chain1 ; multichain-util create chain2
RUN echo 'rpcuser=user\nrpcpassword=pass' >> /root/.multichain/multichain.conf
