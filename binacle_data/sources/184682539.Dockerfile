FROM balenalib/aarch64-alpine:latest

ENV CFLAGS="-D__USE_MISC"

RUN apk add --no-cache --virtual build-deps \
    	nano curl make gcc git g++ python py-pip paxctl libuv-dev \
    	musl-dev openssl-dev zlib-dev paxmark \
    	linux-headers binutils-gold coreutils

# Install AWS CLI
RUN pip install awscli

RUN git clone https://github.com/nodejs/node.git

COPY . /
