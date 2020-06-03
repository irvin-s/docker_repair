FROM orbs:base-sdk

ADD . /opt/orbs

RUN ./build-sdk.sh && yarn cache clean
