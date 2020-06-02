FROM area51/java:serverjre-8  
MAINTAINER Peter Mount <peter@retep.org>  
  
ENV NEXUS_VERSION 3.3.1-01  
ENV NEXUS_PORT 8081  
ENV NEXUS_DATA /repository  
  
COPY *.sh /  
  
CMD ["/docker-entrypoint.sh"]  
  
RUN mkdir -p /opt/sonatype ${NEXUS_DATA} &&\  
addgroup -g 1000 nexus &&\  
adduser -h ${NEXUS_DATA} \  
-u 1000 \  
-G nexus \  
-s /bin/false\  
-D nexus &&\  
curl -sSL \  
-o nexus.tgz \  
https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz &&\  
tar xzf nexus.tgz &&\  
mv nexus-${NEXUS_VERSION} /opt/sonatype/nexus &&\  
rm -rf nexus.tgz &&\  
chmod +x /*.sh &&\  
chown nexus:nexus /opt/sonatype -R &&\  
sed \  
-e "s|karaf.home=.|karaf.home=/opt/sonatype/nexus|g" \  
-e "s|karaf.base=.|karaf.base=/opt/sonatype/nexus|g" \  
-e "s|karaf.etc=etc|karaf.etc=/opt/sonatype/nexus/etc|g" \  
-e "s|java.util.logging.config.file=etc|java.util.logging.config.file=/opt/sonatype/nexus/etc|g" \  
-e "s|karaf.data=data|karaf.data=${NEXUS_DATA}|g" \  
-e "s|java.io.tmpdir=data/tmp|java.io.tmpdir=${NEXUS_DATA}/tmp|g" \  
-i /opt/sonatype/nexus/bin/nexus.vmoptions  
  
VOLUME ${NEXUS_DATA}  
  
WORKDIR /opt/sonatype/nexus  
USER nexus  
  
ENV CONTEXT_PATH /  
  
ENV JAVA_MAX_MEM 1200m  
ENV JAVA_MIN_MEM 256m  
  
ENV EXTRA_JAVA_OPTS ""  
#ENV EXTRA_JAVA_OPTS "-Djava.net.preferIPv4Stack=true"  

