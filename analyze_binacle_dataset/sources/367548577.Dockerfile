FROM mono:4.6
MAINTAINER Dmitry  K "d.p.karpov@gmail.com"

ARG DUPLICATI_VER=2.0.3.9_canary_2018-06-30
ENV DUPLICATI_VER ${DUPLICATI_VER}
ARG DUPLICATI_BRANCH=canary
ENV DUPLICATI_BRANCH ${DUPLICATI_BRANCH}

ENV D_CODEPAGE UTF-8 
ENV D_LANG en_US

ADD ./entrypoint.sh /entrypoint.sh

RUN apt-get -o Acquire::ForceIPv4=true -o Acquire::http::No-Cache=True update && \
    DEBIAN_FRONTEND=noninteractive apt-get -o Acquire::ForceIPv4=true -o Acquire::http::No-Cache=True -o Dpkg::Options::=--force-confold install -y --no-install-recommends \
        expect \
        libsqlite3-0 \
        unzip \
        locales && \
    curl -sSL https://updates.duplicati.com/${DUPLICATI_BRANCH}/duplicati-${DUPLICATI_VER}.zip -o /duplicati-${DUPLICATI_VER}.zip && \
    unzip duplicati-${DUPLICATI_VER}.zip -d /app && \
    rm /duplicati-${DUPLICATI_VER}.zip && \
    localedef -v -c -i ${D_LANG} -f ${D_CODEPAGE} ${D_LANG}.${D_CODEPAGE} || : && \
    update-locale LANG=${D_LANG}.${D_CODEPAGE} && \
    cert-sync /etc/ssl/certs/ca-certificates.crt && \
    apt-get purge -y --auto-remove unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    chmod a+x /entrypoint.sh

VOLUME /root/.config/Duplicati
VOLUME /docker-entrypoint-init.d

EXPOSE 8200

ENTRYPOINT ["/entrypoint.sh"]
