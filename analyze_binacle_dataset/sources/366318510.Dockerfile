FROM alpine:3.6

ENV PACKAGES "bash curl openssh-client file git openssl ca-certificates wget libc6-compat"

RUN apk add --update $PACKAGES && rm -rf /var/cache/apk/*

RUN curl -L https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip -o pup_linux_amd64.zip \
    && unzip pup_linux_amd64.zip \
    && chmod +x pup \
    && mv pup /usr/local/bin \
    && rm pup_linux_amd64.zip

RUN curl -L https://github.com/ArthurHlt/notifslack/releases/download/v1.1.0/notifslack_linux_amd64 -o notifslack \
    && chmod +x notifslack \
    && mv notifslack /usr/local/bin

RUN curl -L https://github.com/ArthurHlt/echo-colors/releases/download/v1.0.0/echoc_linux_amd64 -o echoc \
    && chmod +x echoc \
    && mv echoc /usr/local/bin