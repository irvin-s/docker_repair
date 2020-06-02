FROM phusion/holy-build-box-64

RUN curl -L https://download.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm -o epel-release-5-4.noarch.rpm && \
    rpm -ivh epel-release-5-4.noarch.rpm ; \
    yum install -y git # git for npm

# HBB tar doesn't support `J`, so quickly replace it...
RUN cd /tmp && curl http://ftp.gnu.org/gnu/tar/tar-1.29.tar.gz -o tar.tar.gz && \
    tar xvzf tar* && cd tar*/ && \
    source /hbb/activate && \
    FORCE_UNSAFE_CONFIGURE=1 ./configure && make && make install && yum install -y xz

RUN NODE_VERSION="$(curl https://semver.io/node/resolve/6)" ; curl https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz -o /tmp/node-v${NODE_VERSION}-linux-x64.tar.gz && \
    ( \
        cd /opt && \
        tar xvzf /tmp/node-v${NODE_VERSION}-linux-x64.tar.gz && \
        mv node-v${NODE_VERSION}-linux-x64 node ; \
    ) && \
    rm /tmp/node-v${NODE_VERSION}-linux-x64.tar.gz

RUN mkdir /hbb_musl && cd /hbb_musl && \
    source /hbb/activate && \
    env PATH="/opt/node/bin:${PATH}" npm i node-musl --unsafe-perm --loglevel=error && \
    ln -s $(env PATH="/opt/node/bin:${PATH}" npm bin) bin && \
    echo '#!/usr/bin/env sh' > /hbb_musl/activate && \
    echo 'env PATH="/opt/node/bin:${PATH}" /hbb_musl/bin/musl-exports' >> /hbb_musl/activate && \
    chmod +x /hbb_musl/activate
