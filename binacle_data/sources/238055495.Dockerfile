FROM ubuntu:xenial

# build-essential
# A Node.js C++ extension for SHA-3 (Keccak)
# https://www.npmjs.com/package/sha3
RUN apt-get update \
    && apt-get install -y build-essential python-software-properties curl openssl jq git \
    && curl -sL https://deb.nodesource.com/setup_7.x | bash \
    && apt-get -y install nodejs
WORKDIR /opt
RUN git clone -b gh-pages --depth=1 https://github.com/ethereum/browser-solidity.git
RUN mkdir darkorange && cd darkorange \
    && curl -OOOO https://y12studio.github.io/dltdojo/chains/darkorange/{darkorange.json,node.toml,package.json,darkorange.js} \
    && npm i --verbose
# install parity
#
# parity 1.6.3 issue
# Stage 4 block verification failed for #1 (afc3…e50a)
# Error: Block(InvalidReceiptsRoot(Mismatch { expected: 8a4e75b7ad5232eb45d010f808a3dcfe8b69edec5939a0387dd52246b3a1a211, found: 45bef3c8f45af0174311babea84ed659c7380a7249e2fe1ac5d7749f2918a383 }))
#
ENV VER=1.6.2
ENV DEB=parity_${VER}_amd64.deb
ENV DEBURL=http://d1h4xl4cr1h0mo.cloudfront.net/v${VER}/x86_64-unknown-linux-gnu/$DEB
RUN cd /tmp &&  curl -L -O $DEBURL &&  dpkg -i $DEB &&  dpkg-deb -c $DEB && rm $DEB
RUN npm install http-server -g
ADD darkorange.json nodefaucet.toml /opt/darkorange/
RUN cd darkorange && echo "faucet" > nodefaucet.pwds
ADD start.sh /
RUN chmod a+x /*.sh
