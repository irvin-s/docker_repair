FROM debian:9-slim

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"
ARG JAVA_GC_LOG="/var/log/jvmgc.log" 

ENV TZ ${TZ}
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US:en
ENV JAVA_VERSION 8
ENV JAVA_UPDATE 202
ENV JAVA_BUILD 08
ENV JAVA_PATH 1961070e4c9b4e26a04e7f5a083f551e
ENV JAVA_HOME /usr/lib/jvm/default-jvm
ENV JAVA_DOWNLOAD_URL http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz
ENV JCE_DOWNLOAD_URL http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip
ENV JAVA_GC_LOG ${JAVA_GC_LOG}

ENV TINI_VERSION v0.18.0
ENV TINI_DOWNLOAD_URL https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-amd64

# refs => http://calvin1978.blogcn.com/articles/jvmoption-7.html
ENV JAVA_OPTS   -Djava.security.egd=file:/dev/./urandom \
                -XX:AutoBoxCacheMax=20000 \
                -XX:+UnlockExperimentalVMOptions \
                -XX:+UseCGroupMemoryLimitForHeap \
                -XX:+AlwaysPreTouch \
                -XX:+PrintCommandLineFlags \
                -XX:+PrintGCDateStamps \
                -XX:+PrintGCDetails \
                -XX:+PrintGCApplicationStoppedTime \
                -Xloggc:${JAVA_GC_LOG} \
                ${JAVA_OPTS}

RUN apt update -y \
    && apt upgrade -y \
    && apt install tzdata locales curl wget unzip procps dnsutils iputils-ping -y \
    && curl -sSL ${TINI_DOWNLOAD_URL} > /usr/bin/tini \
    && chmod +x /usr/bin/tini \
    && wget -q --header "Cookie: oraclelicense=accept-securebackup-cookie;" ${JAVA_DOWNLOAD_URL} \
    && tar -xzf jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz \
    && mkdir -p /usr/lib/jvm \
    && mv jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE} /usr/lib/jvm/java-${JAVA_VERSION}-oracle \
    && ln -s /usr/lib/jvm/java-${JAVA_VERSION}-oracle ${JAVA_HOME} \
    && ln -s ${JAVA_HOME}/bin/* /usr/bin/ \
    && wget -q --header "Cookie: oraclelicense=accept-securebackup-cookie;" ${JCE_DOWNLOAD_URL} \
    && unzip -jo -d ${JAVA_HOME}/jre/lib/security jce_policy-${JAVA_VERSION}.zip \
    && locale-gen --purge en_US.UTF-8 zh_CN.UTF-8 \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && echo 'LANG="en_US.UTF-8"' > /etc/default/locale \
    && echo 'LANGUAGE="en_US:en"' >> /etc/default/locale \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && rm -rf   jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz \
                ${JAVA_HOME}/*src.zip \
                jce_policy-${JAVA_VERSION}.zip \
                ${JAVA_HOME}/jre/lib/security/README.txt \
                /tmp/*

COPY docker-java-home /usr/bin/docker-java-home

ENTRYPOINT ["tini","--"]

CMD ["bash"]
