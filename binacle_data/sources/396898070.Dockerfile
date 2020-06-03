# Takipi
FROM alpine:3.2

MAINTAINER Chen Harel "https://github.com/chook"

# Install dependencies 
RUN apk --update add curl ca-certificates tar sqlite icu bash && \
    curl -Ls https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk > /tmp/glibc-2.21-r2.apk && \
    apk add --allow-untrusted /tmp/glibc-2.21-r2.apk

# Java Version
ENV JAVA_VERSION_MAJOR 7
ENV JAVA_VERSION_MINOR 79
ENV JAVA_VERSION_BUILD 15
ENV JAVA_PACKAGE       jdk

# Download and unarchive Java
RUN mkdir /opt && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie"\
  http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz \
    | tar -xzf - -C /opt &&\
    ln -s /opt/jdk1.7.0_79 /opt/jdk &&\
    rm -rf /opt/jdk/*src.zip \
           /opt/jdk/lib/missioncontrol \
           /opt/jdk/lib/visualvm \
           /opt/jdk/lib/*javafx* \
           /opt/jdk/jre/lib/plugin.jar \
           /opt/jdk/jre/lib/ext/jfxrt.jar \
           /opt/jdk/jre/bin/javaws \
           /opt/jdk/jre/lib/javaws.jar \
           /opt/jdk/jre/lib/desktop \
           /opt/jdk/jre/plugin \
           /opt/jdk/jre/lib/deploy* \
           /opt/jdk/jre/lib/*javafx* \
           /opt/jdk/jre/lib/*jfx* \
           /opt/jdk/jre/lib/amd64/libdecora_sse.so \
           /opt/jdk/jre/lib/amd64/libprism_*.so \
           /opt/jdk/jre/lib/amd64/libfxplugins.so \
           /opt/jdk/jre/lib/amd64/libglass.so \
           /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
           /opt/jdk/jre/lib/amd64/libjavafx*.so \
           /opt/jdk/jre/lib/amd64/libjfx*.so \
    && addgroup -g 999 app && adduser -D  -G app -s /bin/false -u 999 app \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/* \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

# Set environment
ENV JAVA_HOME /opt/jdk
ENV PATH ${PATH}:/opt/jdk/bin	

### Takipi Installation 

# Takipi installer dependencies (we need xz for a future untar process)
RUN apk --update add xz

# Download required libraries libgcc_s.so.1, libstdc++.so.6
RUN curl -Ls https://www.archlinux.org/packages/core/x86_64/gcc-libs/download > /tmp/gcc-libs.tar.gz && \
	mkdir /usr/libgcc && tar -xvf /tmp/gcc-libs.tar.gz -C /usr/libgcc

# Download required libraries libz.so.1
RUN curl -Ls https://www.archlinux.org/packages/core/x86_64/zlib/download/ > /tmp/zlib.tar.gz && \
	mkdir /usr/zlib && tar -xvf /tmp/zlib.tar.gz -C /usr/zlib

# Register the new libraries (needed before starting the Takipi installation process)
RUN echo /usr/zlib/usr/lib >> /etc/ld.so.conf
RUN echo /usr/libgcc/usr/lib >> /etc/ld.so.conf
RUN /usr/glibc/usr/bin/ldconfig

# Install Takipi
RUN curl -sL /dev/null http://get.takipi.com/takipi-t4c-installer | \
	bash /dev/stdin -i --sk=S3875#YAFwDEGg5oSIU+TM#G0G7VATLOqJIKtAMy1MObfFINaQmVT5hGYLQ+cpPuq4=#87a1

# Register Takipi libraries
RUN echo /opt/takipi/lib >> /etc/ld.so.conf
RUN /usr/glibc/usr/bin/ldconfig

### Takipi installation complete

# Getting Java tester
RUN wget https://s3.amazonaws.com/app-takipi-com/chen/scala-boom.jar -O scala-boom.jar

# Running a java process with Takipi
CMD java -agentlib:TakipiAgent -jar scala-boom.jar
