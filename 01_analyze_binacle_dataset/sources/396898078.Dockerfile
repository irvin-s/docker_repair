# Takipi
FROM openjdk:8-jre-alpine

MAINTAINER Chen Harel "https://github.com/chook"
# Java Version and other ENV
ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=131 \
    JAVA_VERSION_BUILD=11 \
    JAVA_PACKAGE=jdk \
    JAVA_JCE=standard \
    JAVA_HOME=/opt/jdk \
    PATH=${PATH}:/opt/jdk/bin \
    GLIBC_VERSION=2.23-r3 \
    LANG=C.UTF-8
    
RUN set -ex && \
    apk upgrade --update && \
    apk add --update libstdc++ curl ca-certificates bash && \
    for pkg in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION} glibc-i18n-${GLIBC_VERSION}; do curl -sSL https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/${pkg}.apk -o /tmp/${pkg}.apk; done && \
    apk add --allow-untrusted /tmp/*.apk && \
    rm -v /tmp/*.apk && \
    ( /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true ) && \
    echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
    mkdir /tmp/dcevm && \
    curl -L -o /tmp/dcevm/DCEVM-light-8u112-installer.jar "https://github.com/dcevm/dcevm/releases/download/light-jdk8u112%2B8/DCEVM-light-8u112-installer.jar" && \
    mkdir /opt && \
    curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/java.tar.gz \
      http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/d54c1d3a095b4ff2b6607d096fa80163/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz && \
    gunzip /tmp/java.tar.gz && \
    tar -C /opt -xf /tmp/java.tar && \
    ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk && \
    cd /tmp/dcevm && \
    unzip DCEVM-light-8u112-installer.jar && \
    mkdir -p /opt/jdk/jre/lib/amd64/dcevm && \
    cp linux_amd64_compiler2/product/libjvm.so /opt/jdk/jre/lib/amd64/dcevm/libjvm.so && \
    if [ "${JAVA_JCE}" == "unlimited" ]; then echo "Installing Unlimited JCE policy" && \
      curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/jce_policy-${JAVA_VERSION_MAJOR}.zip \
        http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION_MAJOR}/jce_policy-${JAVA_VERSION_MAJOR}.zip && \
      cd /tmp && unzip /tmp/jce_policy-${JAVA_VERSION_MAJOR}.zip && \
      cp -v /tmp/UnlimitedJCEPolicyJDK8/*.jar /opt/jdk/jre/lib/security/; \
    fi && \
    sed -i s/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=10/ $JAVA_HOME/jre/lib/security/java.security && \
    apk del curl glibc-i18n && \
    rm -rf /opt/jdk/*src.zip \
           /opt/jdk/lib/missioncontrol \
           /opt/jdk/lib/visualvm \
           /opt/jdk/lib/*javafx* \
           /opt/jdk/jre/plugin \
           /opt/jdk/jre/bin/javaws \
           /opt/jdk/jre/bin/jjs \
           /opt/jdk/jre/bin/orbd \
           /opt/jdk/jre/bin/pack200 \
           /opt/jdk/jre/bin/policytool \
           /opt/jdk/jre/bin/rmid \
           /opt/jdk/jre/bin/rmiregistry \
           /opt/jdk/jre/bin/servertool \
           /opt/jdk/jre/bin/tnameserv \
           /opt/jdk/jre/bin/unpack200 \
           /opt/jdk/jre/lib/javaws.jar \
           /opt/jdk/jre/lib/deploy* \
           /opt/jdk/jre/lib/desktop \
           /opt/jdk/jre/lib/*javafx* \
           /opt/jdk/jre/lib/*jfx* \
           /opt/jdk/jre/lib/amd64/libdecora_sse.so \
           /opt/jdk/jre/lib/amd64/libprism_*.so \
           /opt/jdk/jre/lib/amd64/libfxplugins.so \
           /opt/jdk/jre/lib/amd64/libglass.so \
           /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
           /opt/jdk/jre/lib/amd64/libjavafx*.so \
           /opt/jdk/jre/lib/amd64/libjfx*.so \
           /opt/jdk/jre/lib/ext/jfxrt.jar \
           /opt/jdk/jre/lib/ext/nashorn.jar \
           /opt/jdk/jre/lib/oblique-fonts \
           /opt/jdk/jre/lib/plugin.jar \
           /tmp/* /var/cache/apk/* && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

# Set environment
ENV JAVA_HOME /opt/jdk
ENV PATH /opt/jdk/bin:${PATH}

### Takipi Installation 

ENV TAKIPI_SECRET_KEY=S3875#YAFwDEGg5oSIU+TM#G0G7VATLOqJIKtAMy1MObfFINaQmVT5hGYLQ+cpPuq4=#87a1

# Takipi installer dependencies (we need xz for a future untar process)
RUN apk --update add xz curl ca-certificates
RUN update-ca-certificates
RUN curl -Ls https://www.archlinux.org/packages/core/x86_64/gcc-libs/download > /tmp/gcc-libs.tar.gz && \
	mkdir /usr/libgcc-compat && tar -xvf /tmp/gcc-libs.tar.gz -C /usr/libgcc-compat && rm -rf /tmp/gcc-libs.tar.gz
RUN curl -Ls https://www.archlinux.org/packages/core/x86_64/zlib/download/ > /tmp/zlib.tar.gz && \
	mkdir /usr/zlib-compat && tar -xvf /tmp/zlib.tar.gz -C /usr/zlib-compat && rm -rf /tmp/zlib.tar.gz


# Install Takipi
RUN apk update && apk add ca-certificates && update-ca-certificates && apk add openssl
RUN curl -Ls /dev/null http://get.takipi.com/takipi-t4c-installer | \
  bash /dev/stdin -i --sk=${TAKIPI_SECRET_KEY} --no-check-certificates

RUN rm /usr/glibc-compat/etc/ld.so.conf
RUN echo /usr/zlib-compat/usr/lib >> /usr/glibc-compat/etc/ld.so.conf
RUN echo /usr/libgcc-compat/usr/lib >> /usr/glibc-compat/etc/ld.so.conf
RUN echo /opt/takipi/lib >> /usr/glibc-compat/etc/ld.so.conf
RUN echo /usr/lib >> /usr/glibc-compat/etc/ld.so.conf
RUN echo /lib >> /usr/glibc-compat/etc/ld.so.conf
RUN /usr/glibc-compat/sbin/ldconfig
### Takipi installation complete

# Getting Java tester
RUN wget https://s3.amazonaws.com/app-takipi-com/chen/scala-boom.jar -O scala-boom.jar

# More cleanups
RUN apk del xz icu wget curl tar \
  && rm -rf /tmp/* \
  && rm -rf /var/cache/apk/* \ 
  && rm -rf glibc-2.23-r3.apk glibc-bin-2.23-r3.apk

ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/opt/takipi/lib
ENV PATH ${PATH}:/opt/takipi/lib

# Running a java process with Takipi
CMD java -agentlib:TakipiAgent -jar scala-boom.jar
