FROM gozap/openjdk8:8u212

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH ${CATALINA_HOME}/bin:${PATH}
ENV TOMCAT_HOME ${CATALINA_HOME}
ENV TOMCAT_NATIVE_LIBDIR ${CATALINA_HOME}/native-jni-lib
ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.5.39
ENV TOMCAT_DOWNLOAD_URL http://mirror.bit.edu.cn/apache/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}${TOMCAT_NATIVE_LIBDIR}

RUN apt update -y \
    && apt upgrade -y \
    && apt install tzdata libapr1 -y \
    && savedAptMark="$(apt-mark showmanual)" \
    && apt install --no-install-recommends -y \
        wget ca-certificates dpkg-dev gcc \
        libapr1-dev libssl-dev make \
    && mkdir -p ${TOMCAT_HOME} \
    && (cd ${TOMCAT_HOME} \
    && wget -q -O tomcat.tar.gz ${TOMCAT_DOWNLOAD_URL} \
    && tar -xvf tomcat.tar.gz --strip-components=1 \
    && nativeBuildDir="$(mktemp -d)" \
    && tar -xvf bin/tomcat-native.tar.gz -C "${nativeBuildDir}" --strip-components=1 \
    && (cd "${nativeBuildDir}/native" \
    && gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
    && ./configure --build="${gnuArch}" \
        --libdir="${TOMCAT_NATIVE_LIBDIR}" \
       --prefix="${CATALINA_HOME}" \
        --with-apr="$(which apr-1-config)" \
        --with-java-home="$(docker-java-home)" \
        --with-ssl=yes \
    && make -j "$(nproc)" \
    && make install) \
    && find ./bin/ -name '*.sh' -exec sed -ri 's|^#!/bin/sh$|#!/usr/bin/env bash|' '{}' + \
    && chmod -R +rX . \
    && chmod 777 logs work \
    && rm -rf "${nativeBuildDir}" bin/tomcat-native.tar.gz) \
    && apt-mark auto '.*' > /dev/null \
    && ([ -z "${savedAptMark}" ] || apt-mark manual ${savedAptMark}) \
    && apt purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apt autoremove -y \
    && apt autoclean -y \
    && rm -rf ${CATALINA_HOME}/webapps/* \
        ${TOMCAT_HOME}/*.md \
        ${TOMCAT_HOME}/*.txt \
        ${TOMCAT_HOME}/bin/*.bat \
        ${TOMCAT_HOME}/RELEASE-NOTES \
        ${TOMCAT_HOME}/tomcat.tar.gz \
        /var/lib/apt/lists/*

# verify Tomcat Native is working properly
RUN set -e \
    && nativeLines="$(catalina.sh configtest 2>&1)" \
    && nativeLines="$(echo "$nativeLines" | grep 'Apache Tomcat Native')" \
    && nativeLines="$(echo "$nativeLines" | sort -u)" \
    && if ! echo "$nativeLines" | grep 'INFO: Loaded APR based Apache Tomcat Native library' >&2; then \
        echo >&2 "$nativeLines"; \
        exit 1; \
    fi

WORKDIR ${CATALINA_HOME}

CMD ["bash"]
