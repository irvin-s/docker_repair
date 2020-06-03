FROM ubuntu:xenial

ENV LANG C.UTF-8

RUN { \
      echo '#!/bin/sh'; \
      echo 'set -e'; \
      echo; \
      echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home && \
    chmod +x /usr/local/bin/docker-java-home

RUN apt-get update && apt-get install -y --no-install-recommends \
      bzip2 \
      unzip \
      xz-utils \
      apt-transport-https \
      ca-certificates \
      curl \
      software-properties-common \
      python3-openssl && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable" && \
    apt-get update && apt-get install -y --no-install-recommends \
	  docker-ce=17.09.0~ce-0~ubuntu && \
    apt-get install -y \
      openjdk-8-jre \
    ; \
    rm -rf /var/lib/apt/lists/*; \
    \
    [ "$JAVA_HOME" = "$(docker-java-home)" ]; \
    \
    update-alternatives --get-selections | awk -v home="$JAVA_HOME" 'index($3, home) == 1 { $2 = "manual"; print | "update-alternatives --set-selections" }'; \
    update-alternatives --query java | grep -q 'Status: manual' && \
    mkdir /packages && \
    curl -o /packages/twistcli https://cdn.twistlock.com/support/twistcli && \
    curl -o /packages/nexus-iq-cli-1.38.0-02.jar https://download.sonatype.com/clm/scanner/nexus-iq-cli-1.38.0-02.jar

COPY scripts /scripts

RUN	chmod +x -R /packages
RUN	chmod +x -R /scripts

WORKDIR /scripts

ENTRYPOINT ["/usr/bin/python3"]
CMD [""]
