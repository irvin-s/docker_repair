FROM solsson/kafka-jre:8@sha256:1ebc3c27c30f5925d240aaa0858e111c2fa6d358048b0f488860ea9cd9c84822

ENV CP_ARCHIVE_VERSION=v4.0.0 \
    CP_PACKAGE_VERSION=4.0.0 \
    MAVEN_VERSION=3.5.2 \
    MAVEN_FLAGS="-Dmaven.test.skip=true"
# Default versions are found in the corresponding branch of: https://github.com/confluentinc/common/blob/master/pom.xml

WORKDIR /usr/local

RUN set -ex; \
  WORKDIR=$PWD; \
  mkdir -p $WORKDIR/share/java; \
  \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps=''; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  PATH=$PATH:/opt/maven/bin; \
  mkdir -p /opt/maven; \
  curl -SLs https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzf - --strip-components=1 -C /opt/maven; \
  mvn --version; \
  \
  mkdir -p /opt/src/common; cd /opt/src/common; \
  curl -SLs https://github.com/confluentinc/common/archive/$CP_ARCHIVE_VERSION.tar.gz | tar -xzf - --strip-components=1 -C ./; \
  mvn $MAVEN_FLAGS install; \
  \
  mkdir -p /opt/src/rest-utils; cd /opt/src/rest-utils; \
  curl -SLs https://github.com/confluentinc/rest-utils/archive/$CP_ARCHIVE_VERSION.tar.gz | tar -xzf - --strip-components=1 -C ./; \
  mvn $MAVEN_FLAGS install; \
  \
  mkdir -p /opt/src/schema-registry; cd /opt/src/schema-registry; \
  curl -SLs https://github.com/confluentinc/schema-registry/archive/$CP_ARCHIVE_VERSION.tar.gz | tar -xzf - --strip-components=1 -C ./; \
  mvn $MAVEN_FLAGS install; \
  \
  mkdir -p /opt/src/kafka-rest; cd /opt/src/kafka-rest; \
  curl -SLs https://github.com/confluentinc/kafka-rest/archive/$CP_ARCHIVE_VERSION.tar.gz | tar -xzf - --strip-components=1 -C ./; \
  mvn $MAVEN_FLAGS install; \
  \
  cd $WORKDIR; \
  \
  mv /opt/src/common/package/target/common-package-$CP_PACKAGE_VERSION-package/share/java/confluent-common ./share/java/; \
  mv /opt/src/rest-utils/package/target/rest-utils-package-$CP_PACKAGE_VERSION-package/share/java/rest-utils ./share/java/; \
  \
  mv /opt/src/schema-registry/package-schema-registry/target/kafka-schema-registry-package-$CP_PACKAGE_VERSION-package/bin/* ./bin/; \
  mv /opt/src/schema-registry/package-schema-registry/target/kafka-schema-registry-package-$CP_PACKAGE_VERSION-package/share/java/* ./share/java/; \
  mv /opt/src/schema-registry/package-schema-registry/target/kafka-schema-registry-package-$CP_PACKAGE_VERSION-package/etc/* /etc/; \
  \
  mv /opt/src/kafka-rest/target/kafka-rest-$CP_PACKAGE_VERSION-package/bin/* ./bin/; \
  mv /opt/src/kafka-rest/target/kafka-rest-$CP_PACKAGE_VERSION-package/share/java/* ./share/java/; \
  mv /opt/src/kafka-rest/target/kafka-rest-$CP_PACKAGE_VERSION-package/etc/* /etc; \
  \
  rm -Rf /opt/src /opt/maven /root/.m2; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

COPY docker-help.sh /usr/local/bin/docker-help
ENTRYPOINT ["docker-help"]
