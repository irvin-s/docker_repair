FROM oraclelinux:7-slim
MAINTAINER tuddman

ENV GRAAL_VERSION=1.0.0-rc12
ENV GRAALVM_URL=https://github.com/oracle/graal/releases/download/vm-${GRAAL_VERSION}/graalvm-ce-${GRAAL_VERSION}-linux-amd64.tar.gz \
    GRAALVM_PKG=graalvm-ce-${GRAAL_VERSION}-linux-amd64.tar.gz \
    GRAALVM_HOME=/usr/graalvm-ce-${GRAAL_VERSION}

ENV JAVA_HOME=${GRAALVM_HOME} \
    PATH=${GRAALVM_HOME}/bin:$PATH

RUN yum -y install tar; \
    yum -y install gzip

RUN curl -4 -L $GRAALVM_URL -o $GRAALVM_PKG &&  \
    tar -xvf $GRAALVM_PKG -C /usr/ &&  \
    rm $GRAALVM_PKG

RUN yum -y install gcc; \
    yum -y install zlib-devel; \
    rm -rf /var/cache/yum && \ 
    alternatives --install /usr/bin/java  java  $JAVA_HOME/bin/java  20000 && \
    alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 20000 && \
    alternatives --install /usr/bin/jar   jar   $JAVA_HOME/bin/jar   20000

ENTRYPOINT ["${GRAALVM_HOME}/bin/native-image"]
