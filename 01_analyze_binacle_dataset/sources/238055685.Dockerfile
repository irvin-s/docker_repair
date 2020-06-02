FROM ubuntu:xenial
ENV OMNICORE_VERSION=0.0.11.2
RUN apt-get update ; apt-get install -y curl jq &&\
    cd /tmp; curl --insecure -sL https://github.com/OmniLayer/omnicore/releases/download/v${OMNICORE_VERSION}/omnicore-${OMNICORE_VERSION}-rel-linux64.tar.gz | tar zx &&\
    mv /tmp/omnicore-${OMNICORE_VERSION}-rel/bin/* /usr/local/bin/ &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
