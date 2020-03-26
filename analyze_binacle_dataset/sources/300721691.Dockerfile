FROM frolvlad/alpine-oraclejdk8:slim
VOLUME /tmp
LABEL Vendor="EasyFrame" easyframe-serv="ef-dataflowshell"
ADD target/easyframe-dataflow-shell-master-SNAPSHOT-exec.jar dataflowshell.jar
RUN sh -c 'touch /dataflowshell.jar'

ENV JAVA_OPTS="-server -Xmx512m -Xms512m -XX:NewRatio=1 -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 \
-XX:+UseCMSInitiatingOccupancyOnly -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:ReservedCodeCacheSize=128M \
-XX:MaxTenuringThreshold=6 -XX:+ExplicitGCInvokesConcurrent -Duser.timezone=Asia/Shanghai"

ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /dataflowshell.jar" ]