# GraalVM v1.0 with Maven v3.6
#
# docker run --rm -v "$(pwd)":/work -v "${HOME}/.m2":/root/.m2 \
#     supinf/graalvm:1.0-maven3.6 \
#     io.quarkus:quarkus-maven-plugin:0.11.0:create \
#        -DprojectGroupId=org.acme \
#        -DprojectArtifactId=sample \
#        -DclassName="org.acme.quickstart.GreetingResource" \
#        -Dpath="/hello"
# cd sample
# docker run --rm -v "$(pwd)":/work -v "${HOME}/.m2":/root/.m2 \
#     supinf/graalvm:1.0-maven3.6 package -Pnative
# docker build -f src/main/docker/Dockerfile -t quarkus/sample .
# docker run --rm -p 8080:8080 quarkus/sample
# open http://localhost:8080/

FROM supinf/graalvm:1.0

ENV MAVEN_VERSION=3.6.0 \
    MAVEN_HOME=/usr/share/maven \
    MAVEN_CONFIG=/root/.m2 \
    MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"

RUN apt-get update && apt-get install -y "curl=7.52.1-5+deb9u9" \
    && mkdir -p /usr/share/maven /usr/share/maven/ref \
    && curl -fsSL -o /tmp/apache-maven.tar.gz \
       "https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" \
    && echo "fae9c12b570c3ba18116a4e26ea524b29f7279c17cbaadc3326ca72927368924d9131d11b9e851b8dc9162228b6fdea955446be41207a5cfc61283dd8a561d2f  /tmp/apache-maven.tar.gz" \
       | sha512sum -c - \
    && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
    && rm -rf /tmp/apache-maven.tar.gz \
       /var/cache/* /var/lib/apt/lists/* /var/log/apt/*

RUN apt-get update && apt-get autoremove -y \
    && apt-get install -y "g++" "zlib1g-dev" \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/apt/*

VOLUME ["/root/.m2"]
WORKDIR /work

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh", "mvn"]
CMD ["-version"]
