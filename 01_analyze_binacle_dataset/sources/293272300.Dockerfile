FROM alpine:3.6

ENV KUBECTL_VERSION 1.6.6
ENV KUBECTL_URI https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl

RUN apk update && \
  apk add --update \
    bash \
    easy-rsa \
    openssh-client \
    curl \
    ca-certificates \
    jq \
    python \
    py-yaml \
    py2-pip \
    && pip install --upgrade pip \
    && apk add --virtual build-deps \
    make \
    gcc \
    libffi-dev \
    python-dev \
    musl-dev \
    openssl-dev \
    && pip install ijson awscli gsutil azure-cli \
    && apk del build-deps \
    && rm -rf /var/cache/apk/*

RUN curl -SL ${KUBECTL_URI} -o kubectl && chmod +x kubectl
RUN adduser -h /backup -D backup

COPY scripts /
COPY functions.sh /
COPY docker-entrypoint.sh /

USER backup

CMD ["/docker-entrypoint.sh"]
