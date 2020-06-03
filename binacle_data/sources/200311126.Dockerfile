FROM alpine

RUN apk add --update bash openssl curl git \
    && (curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash) \
    && helm init --client-only

COPY package.sh /usr/sbin/
