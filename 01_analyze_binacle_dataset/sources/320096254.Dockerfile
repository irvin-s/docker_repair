FROM frolvlad/alpine-python3

RUN apk update && \
    apk add libffi-dev && \
    apk add openssl-dev && \
    apk add build-base && \
    pip install --upgrade pip setuptools && \
    apk add python3-dev && \
    pip3 install bigchaindb && \
    apk del build-base && \
    apk add libstdc++


ENV PYTHONUNBUFFERED 0
ENV BIGCHAINDB_CONFIG_PATH /data/.bigchaindb
ENV BIGCHAINDB_SERVER_BIND 0.0.0.0:9984
ENV BIGCHAINDB_WSSERVER_HOST 0.0.0.0
ENV BIGCHAINDB_WSSERVER_SCHEME ws
ENV BIGCHAINDB_WSSERVER_ADVERTISED_HOST 0.0.0.0
ENV BIGCHAINDB_WSSERVER_ADVERTISED_SCHEME ws
ENV BIGCHAINDB_WSSERVER_ADVERTISED_PORT 9985

ENTRYPOINT ["bigchaindb"]
CMD ["start"]
