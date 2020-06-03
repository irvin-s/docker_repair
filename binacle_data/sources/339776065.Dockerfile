# Docker file inspired by 
# https://github.com/Cantara/maven-infrastructure/blob/master/jenkins/Dockerfile
# https://registry.hub.docker.com/u/sonatype/nexus/dockerfile/

FROM cantara/debian-sid-zulu-jdk8
#FROM cantara/alpine-zulu-jdk8

MAINTAINER erik-dev@fjas.no

### Install Nexus 
ENV SONATYPE_WORK /sonatype-work/nexus
ENV NEXUS_DL_URL http://download.sonatype.com/nexus/oss/nexus-2.12.1-01-bundle.tar.gz 
ENV NEXUS_VERSION 2.12.1-01


RUN mkdir -p /opt/sonatype/nexus \
  && curl --fail --silent --show-error --location --retry 3 $NEXUS_DL_URL \
  | tar xzf - -C /tmp nexus-${NEXUS_VERSION} \
  && mv /tmp/nexus-${NEXUS_VERSION}/* /opt/sonatype/nexus/ \
  && rm -rf /tmp/nexus-${NEXUS_VERSION}

# debian 
RUN adduser --system -u 1001 nexus
# alpinelinx 
#RUN adduser -S -u 1001 -s /bin/false nexus

EXPOSE 8081
WORKDIR /opt/sonatype/nexus
USER nexus
ENV CONTEXT_PATH /
ENV MAX_HEAP 768m
ENV MIN_HEAP 256m
ENV JAVA_OPTS -server -Djava.net.preferIPv4Stack=true
ENV LAUNCHER_CONF ./conf/jetty.xml ./conf/jetty-requestlog.xml
CMD java \
  -Dnexus-work=${SONATYPE_WORK} -Dnexus-webapp-context-path=${CONTEXT_PATH} \
  -Xms${MIN_HEAP} -Xmx${MAX_HEAP} \
  -cp 'conf/:lib/*' \
  ${JAVA_OPTS} \
  org.sonatype.nexus.bootstrap.Launcher ${LAUNCHER_CONF}

