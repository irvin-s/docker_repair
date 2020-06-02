FROM openjdk:9-jre-slim  
  
ARG ZK_MIRROR=http://mirror.cogentco.com/pub/apache  
ARG ZK_VERSION=3.4.10  
ENV ZK_VERSION $ZK_VERSION  
ARG ZK_SHA1=eb2145498c5f7a0d23650d3e0102318363206fba  
ARG ZK_BASE=/zookeeper  
ARG ZK_DATA=/tmp/zookeeper  
ENV ZK_DATA $ZK_DATA  
  
RUN set -uex; \  
ZK_label="zookeeper-${ZK_VERSION}"; \  
ZK_file="${ZK_label}.tar.gz"; \  
apt-get update; \  
apt-get install bash curl netcat-openbsd -y; \  
curl $ZK_MIRROR/zookeeper/$ZK_label/$ZK_file > /tmp/$ZK_file; \  
shasum=$(sha1sum /tmp/$ZK_file | awk '{print $1}'); \  
[ -n "$shasum" ] && [[ "$shasum" == "$ZK_SHA1" ]] || exit 1; \  
tar -C /tmp -xvzf /tmp/$ZK_file; \  
rm /tmp/$ZK_file; \  
mv /tmp/$ZK_label /zookeeper; \  
rm -rf /zookeeper/src /zookeeper/docs; \  
find /zookeeper/contrib/ -name src -exec rm -rf {} +; \  
cp /zookeeper/conf/zoo_sample.cfg /zookeeper/conf/zoo.cfg; \  
mkdir -p /zookeeper/var; \  
rm -rf /var/lib/lists/*  
  
COPY docker-entrypoint.sh /entrypoint.sh  
COPY check.sh wait.sh /zookeeper/  
RUN chmod 755 /entrypoint.sh /zookeeper/check.sh /zookeeper/wait.sh  
  
LABEL name="deployable/zookeeper" \  
maintainer="Matt Hoyle" \  
version=${ZK_VERSION}  
  
VOLUME ["/zookeeper/conf", "/tmp/zookeeper"]  
  
WORKDIR /zookeeper  
EXPOSE 2181 2888 3888  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["/zookeeper/bin/zkServer.sh", "start-foreground"]  
  

