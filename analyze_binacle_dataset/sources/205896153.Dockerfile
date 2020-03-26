FROM alpine:3.3
MAINTAINER Stuart Davidson <stuart.davidson@skyscanner.net>

ENV \
    MAVEN_HOME="/usr/share/maven" \
    JAVA_HOME="/usr/lib/jvm/default-jvm" \
    JAVA_PREFS="/.java/.userPrefs" \
    BUILD_DEPS="curl openjdk8 bash git"

ENV PATH=${JAVA_HOME}/bin:${PATH}
RUN mkdir -p -m 777 /opt/test

RUN \
    # Install Java8
    apk add --update ${BUILD_DEPS} \

    # Default DNS cache TTL is -1. DNS records, like, change, man
    && grep '^networkaddress.cache.ttl=' ${JAVA_HOME}/jre/lib/security/java.security || echo 'networkaddress.cache.ttl=60' >> ${JAVA_HOME}/jre/lib/security/java.security \

    # Cleanup
    && rm -rf -- /var/cache/apk/*

RUN \
    # Install Maven
    MAVEN_VERSION=3.3.3 \
    && cd /usr/share \
    && wget -q http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz -O - | tar xzf - \
    && mv /usr/share/apache-maven-${MAVEN_VERSION} /usr/share/maven \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn 

RUN \	
	# Install Bats
	git clone https://github.com/sstephenson/bats.git \
	&& cd bats \
	&& ./install.sh /opt/test/bats \
	&& ln -s /opt/test/bats/bin/bats /usr/bin/bats
		
# To store Java preferences
RUN mkdir -p ${JAVA_PREFS}
RUN chown -R nobody.nobody ${JAVA_PREFS}

# To set-up test
ADD include /opt/test/
RUN chmod -R 777 /opt/test

USER nobody
WORKDIR /opt/test

ENTRYPOINT ["bash", "/opt/test/test.sh"]