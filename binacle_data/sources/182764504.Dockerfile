FROM debian:stretch-slim@sha256:6c31161e090aa3f62b9ee1414b58f0a352b42b2b7827166e57724a8662fe4b38

# See https://jdk.java.net/11/
ENV JDK11_VERSION=11.0.2 \
  JDK11_BUILD=7 \
  JDK11_TGZ_SHA256=62ee5758af12bbad04f376bf2b61f114076f6d8ffe4ba8db13bb5a63b5ef0d29

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps=''; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  cd /usr/lib; \
  mkdir jvm; \
  cd jvm; \
  curl -SLs -o jdk.tar.gz https://download.java.net/java/GA/jdk11/${JDK11_BUILD}/GPL/openjdk-${JDK11_VERSION}_linux-x64_bin.tar.gz; \
  echo "${JDK11_TGZ_SHA256} jdk.tar.gz" | sha256sum -c -; \
  tar xvzf jdk.tar.gz; \
  rm jdk.tar.gz; \
  mv jdk-11.0.2 jdk-11; \
  \
  rm -v jdk-11/lib/src.zip; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

# Instead of: find /usr/lib/jvm/jdk-11/bin/ -executable -exec ln -s '{}' /usr/local/bin/
ENV PATH="$PATH:/usr/lib/jvm/jdk-11/bin"
