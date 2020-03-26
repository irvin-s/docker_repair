FROM ethereum/solc:stable as solc

FROM python:3.6-alpine

LABEL maintainer="nicolas.maurice.valera@gmail.com"

COPY --from=solc /usr/bin/solc /usr/bin

RUN echo -e "http://mirrors.aliyun.com/alpine/edge/testing\nhttp://mirrors.aliyun.com/alpine/v3.6/main\nhttp://mirrors.aliyun.com/alpine/v3.6/community\n" > /etc/apk/repositories && \
    apk update && \
    apk --no-cache --update add gcc g++ make musl-dev gmp-dev openssl-dev libffi-dev leveldb-dev && \
    pip install mythril && \
    apk del g++ make musl-dev gmp-dev openssl-dev libffi-dev

RUN mkdir -p /usr/src/contracts
WORKDIR /usr/src

ENTRYPOINT ["myth"]

