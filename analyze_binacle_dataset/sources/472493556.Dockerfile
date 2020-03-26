FROM node:10.15.3-stretch-slim

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US:en

ENV NPM_CACHE_DIR /data/npm_cache
ENV NPM_REGISTRY https://registry.npm.taobao.org
ENV NPM_DISTURL https://npm.taobao.org/dist

ENV TINI_VERSION v0.18.0
ENV TINI_DOWNLOAD_URL https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-amd64

RUN apt update -y \
    && apt upgrade -y \
    && apt install tzdata locales curl procps dnsutils iputils-ping -y \
    && curl -sSL ${TINI_DOWNLOAD_URL} > /usr/bin/tini \
    && chmod +x /usr/bin/tini \
    && locale-gen --purge en_US.UTF-8 zh_CN.UTF-8 \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && echo 'LANG="en_US.UTF-8"' > /etc/default/locale \
    && echo 'LANGUAGE="en_US:en"' >> /etc/default/locale \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apt autoremove -y \
    && apt autoclean -y \
    && rm -rf /var/lib/apt/lists/*

COPY cnpm /usr/local/bin/cnpm

ENTRYPOINT ["tini","--"]

CMD ["node"]
