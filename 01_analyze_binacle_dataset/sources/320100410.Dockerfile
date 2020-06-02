FROM gliderlabs/alpine:3.3
LABEL Description="oracle jdk 1.8.0_77b03,apache maven 3.3.x" Version="0.0.1"

ENV GLIB_URI_BASE=https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages \
    ORA_URI_BASE=http://download.oracle.com/otn-pub/java/jdk \
    MAVEN_URI_BASE=http://www.mirrorservice.org/sites/ftp.apache.org/maven/maven-3 \
    MAVEN_HOME=/opt/maven \
    MAVEN_VERSION=3.3.9   \
    JAVA_VERSION_MAJOR=8  \
    JAVA_VERSION_MINOR=77 \
    JAVA_VERSION_BUILD=03 \
    JAVA_PACKAGE=jdk      \
    JAVA_HOME=/opt/jdk    \
    PATH=${PATH}:/opt/jdk/bin:/opt/maven/bin \
    LANG=C.UTF-8          

ENV MAVEN_DOWNLOAD_URI="${MAVEN_URI_BASE}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.zip"

RUN apk upgrade --update \
  && apk add --update curl ca-certificates bash \
  && curl -L -o /tmp/glibc-2.21-r2.apk "${GLIB_URI_BASE}/x86_64/glibc-2.21-r2.apk" \
  && apk add --allow-untrusted /tmp/glibc-2.21-r2.apk \
  && curl -L -o /tmp/glibc-bin-2.21-r2.apk "${GLIB_URI_BASE}/x86_64/glibc-bin-2.21-r2.apk" \
  && apk add --allow-untrusted /tmp/glibc-bin-2.21-r2.apk \
  && /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib \
  && mkdir /opt \
  && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
       -o /tmp/java.tar.gz \
          $ORA_URI_BASE/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
  && curl -o /tmp/maven.zip "${MAVEN_DOWNLOAD_URI}" \
  && gunzip  /tmp/java.tar.gz \
  && tar -C  /opt -xf /tmp/java.tar \
  && unzip /tmp/maven.zip -d /opt \
  && ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven \
  && apk del curl \
  && ln -s  /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk \
  && rm -rf /opt/jdk/*src.zip \
            /opt/jdk/lib/missioncontrol\
            /opt/jdk/lib/visualvm\
            /opt/jdk/lib/*javafx*\
            /opt/jdk/jre/plugin\
            /opt/jdk/jre/bin/javaws\
            /opt/jdk/jre/bin/jjs\
            /opt/jdk/jre/bin/keytool\
            /opt/jdk/jre/bin/orbd\
            /opt/jdk/jre/bin/pack200\
            /opt/jdk/jre/bin/policytool\
            /opt/jdk/jre/bin/rmid\
            /opt/jdk/jre/bin/rmiregistry\
            /opt/jdk/jre/bin/servertool\
            /opt/jdk/jre/bin/tnameserv\
            /opt/jdk/jre/bin/unpack200\
            /opt/jdk/jre/lib/javaws.jar\
            /opt/jdk/jre/lib/deploy*\
            /opt/jdk/jre/lib/desktop\
            /opt/jdk/jre/lib/*javafx*\
            /opt/jdk/jre/lib/*jfx*\
            /opt/jdk/jre/lib/amd64/libdecora_sse.so\
            /opt/jdk/jre/lib/amd64/libprism_*.so\
            /opt/jdk/jre/lib/amd64/libfxplugins.so\
            /opt/jdk/jre/lib/amd64/libglass.so\
            /opt/jdk/jre/lib/amd64/libgstreamer-lite.so\
            /opt/jdk/jre/lib/amd64/libjavafx*.so\
            /opt/jdk/jre/lib/amd64/libjfx*.so\
            /opt/jdk/jre/lib/ext/jfxrt.jar\
            /opt/jdk/jre/lib/ext/nashorn.jar\
            /opt/jdk/jre/lib/oblique-fonts\
            /opt/jdk/jre/lib/plugin.jar\
            /tmp/*\
            /var/cache/apk/*\
  && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

CMD ["/sh"]
