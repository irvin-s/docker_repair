FROM sneck/zookeeper:3.4

ARG EXHIBITOR_VERSION

ENV EXHIBITOR_VERSION=${EXHIBITOR_VERSION:-1.5.6} \
    EXHIBITOR_HOME=/opt/exhibitor

ADD pom.xml /tmp/exhibitor/pom.xml
RUN apk add --no-cache --virtual=build-dependencies wget \
    && apk add --no-cache bash \
    \
    && MAVEN_VERSION=3.3.9 \
    && mkdir -p /tmp/maven \
    && cd /tmp/maven \
    && wget -O - http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - \
    \
    && mkdir -p /tmp/exhibitor \
    && cd /tmp/exhibitor \
    && sed -i.back 's/${exhibitor.version}/'${EXHIBITOR_VERSION}'/' pom.xml \
    && /tmp/maven/apache-maven-$MAVEN_VERSION/bin/mvn clean package \
    && mkdir -p $EXHIBITOR_HOME \
    && mv target/exhibitor-$EXHIBITOR_VERSION.jar $EXHIBITOR_HOME/exhibitor.jar \
    \
    && apk del build-dependencies \
    && rm -rf /tmp/*

ADD web.xml $EXHIBITOR_HOME/web.xml
ADD docker-entrypoint.sh /entrypoint.sh

WORKDIR $EXHIBITOR_HOME
EXPOSE 2181 2888 3888 8181

ENTRYPOINT ["/entrypoint.sh"]