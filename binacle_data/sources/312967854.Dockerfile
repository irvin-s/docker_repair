# cka:v1
FROM python:3.6.5-alpine3.7
MAINTAINER xiaolong@caicloud.io

COPY Docker/requirements.txt /tmp/
# 准备配置环境
# pip freeze > requirements.txt
RUN pip install -r /tmp/requirements.txt

# 配置 cfssl
COPY cfssl/cfssl_linux-amd64 /usr/bin/cfssl
COPY cfssl/cfssljson_linux-amd64 /usr/bin/cfssljson
COPY cfssl/cfssl-certinfo_linux-amd64 /usr/bin/cfssl-certinfo
COPY kubectl /usr/bin/kubectl

RUN chmod +x /usr/bin/cfssl /usr/bin/cfssljson /usr/bin/cfssl-certinfo /usr/bin/kubectl
# 配置 rsync openssh
RUN apk update && apk add rsync openssh ca-certificates
RUN apk --update add --virtual build-dependencies python-dev libffi-dev openssl-dev build-base && \
    pip install --upgrade cffi  && \
    pip install ansible  && \
    apk del build-dependencies

# 配置时区
# see: http://wiki.alpinelinux.org/wiki/Setting_the_timezone
RUN apk --update add tzdata && \
    apk add libstdc++ bash curl && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata && \
    rm -rf /tmp/* /var/cache/apk/* && \
    echo "UTC+8:00" > /etc/TZ
# 设置时区 中国的时区有多种表述 分别为: UTC+8:00 GMT+8
# 写/etc/TZ, 不要设置TZ环境变量 ENV TZ UTC+8:00

ENV LANG=C.UTF-8

# Here we install GNU libc (aka glibc) and set C.UTF-8 locale as default.
RUN ALPINE_GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" && \
    ALPINE_GLIBC_PACKAGE_VERSION="2.27-r0" && \
    ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    wget \
        "https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub" \
        -O "/etc/apk/keys/sgerrand.rsa.pub" && \
    wget \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
    apk add --no-cache \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
    \
    rm "/etc/apk/keys/sgerrand.rsa.pub" && \
    /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 "$LANG" || true && \
    echo "export LANG=$LANG" > /etc/profile.d/locale.sh && \
    \
    apk del glibc-i18n && \
    \
    rm "/root/.wget-hsts" && \
    apk del .build-dependencies && \
    rm \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME"

WORKDIR /cka/service
RUN mkdir logs
COPY inventory .
COPY service .