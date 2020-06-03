FROM frolvlad/alpine-oraclejdk8:slim
VOLUME /tmp
LABEL Vendor="EasyFrame" easyframe-serv="ef-configserver"
ADD target/easyframe-config-server-master-SNAPSHOT-exec.jar config-server.jar
RUN sh -c 'touch /config-server.jar'

# Docker for java bug: https://github.com/docker/docker/issues/15020
ENV MALLOC_ARENA_MAX="4"

ENV JAVA_OPTS="-server -Xmx512m -Xms512m -XX:NewRatio=1 -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 \
-XX:+UseCMSInitiatingOccupancyOnly -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:ReservedCodeCacheSize=128M \
-XX:MaxTenuringThreshold=6 -XX:+ExplicitGCInvokesConcurrent -Duser.timezone=Asia/Shanghai"

ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /config-server.jar" ]