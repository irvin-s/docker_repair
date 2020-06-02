# Copyright 2017 Evolved Binary Ltd
# Released under the AGPL v3.0 license

FROM openjdk:8-jdk-slim as jdk
# Remove assistive_technologies capabilities from jdk
# Needs to be done in JDK image and copied over due to lack of shell in the gcr.io/distroless/java
RUN sed -i "s|^assistive_technologies|#assistive_technologies|" /etc/java-8-openjdk/accessibility.properties

FROM gcr.io/distroless/java:latest

MAINTAINER Evolved Binary Ltd <tech@evolvedbinary.com>

ARG VCS_REF
ARG BUILD_DATE

LABEL name="eXist-db Docker with working xslfo module" \
  vendor="Evolved Binary Ltd" \
  org.label-schema.schema-version="1.0" \
  org.label-schema.name="eXist-db Docker with working xslfo module" \
  org.label-schema.vendor="Evolved Binary Ltd" \
  org.label-schema.url="https://exist-db.org" \
  org.label-schema.vcs-url="https://github.com/evolvedbinary/docker-existdb" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.docker.cmd="docker run -it -p 9080:8080 -p 9443:8443"

COPY /target/exist /exist
COPY /target/conf.xml /exist/conf.xml
COPY /target/exist/webapp/WEB-INF/data /exist-data

# Copy over dependancies for Apache FOP, which are lacking from the JRE supplied in gcr.io/distroless/java
# Make sure java versions match both in JDK image and the distroless image
COPY --from=jdk /usr/lib/jvm/java-1.8.0-openjdk-amd64/jre/lib/amd64/libfontmanager.so /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/
COPY --from=jdk /usr/lib/jvm/java-1.8.0-openjdk-amd64/jre/lib/amd64/libjavalcms.so /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/
COPY --from=jdk /usr/lib/x86_64-linux-gnu/liblcms2.so.2.0.8 /usr/lib/x86_64-linux-gnu/liblcms2.so.2
COPY --from=jdk /usr/lib/x86_64-linux-gnu/libfreetype.so.6.12.3 /usr/lib/x86_64-linux-gnu/libfreetype.so.6
COPY --from=jdk /usr/lib/x86_64-linux-gnu/libpng16.so.16.28.0 /usr/lib/x86_64-linux-gnu/libpng16.so.16

# Copy over dependancies for Apache Batik (used by Apache FOP to handle SVG rendering)
COPY --from=jdk /usr/lib/x86_64-linux-gnu/libfontconfig.so.1.8.0 /usr/lib/x86_64-linux-gnu/libfontconfig.so.1
COPY --from=jdk /usr/share/fontconfig /usr/share/fontconfig
COPY --from=jdk /usr/share/fonts/truetype/dejavu /usr/share/fonts/truetype/dejavu
COPY --from=jdk /lib/x86_64-linux-gnu/libexpat.so.1 /lib/x86_64-linux-gnu/libexpat.so.1
COPY --from=jdk /etc/fonts /etc/fonts

# Copy over accessibility.properties from JDK, where assistive_technologies have been removed, or it
# will throw on errors in SVG processing
COPY --from=jdk /etc/java-8-openjdk/accessibility.properties /etc/java-8-openjdk/accessibility.properties

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV EXIST_HOME=/exist
ENV LANG en_GB.UTF-8

EXPOSE 8080
EXPOSE 8443

ENTRYPOINT ["/usr/lib/jvm/java-8-openjdk-amd64/bin/java"]
CMD ["-Dexist.home=/exist", "-Djava.awt.headless=true", "-jar", "/exist/start.jar", "jetty"]