FROM frolvlad/alpine-oraclejdk8:slim
VOLUME /tmp
LABEL Vendor="EasyFrame" easyframe-serv="ef-hystrixturbine"
ADD target/easyframe-hystrix-turbine-master-SNAPSHOT-exec.jar hystrix-turbine.jar
RUN sh -c 'touch /hystrix-turbine.jar'

ENV JAVA_OPTS="-server -Xmx512m -Xms512m -XX:NewRatio=1 -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 \
-XX:+UseCMSInitiatingOccupancyOnly -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:ReservedCodeCacheSize=128M \
-XX:MaxTenuringThreshold=6 -XX:+ExplicitGCInvokesConcurrent -Duser.timezone=Asia/Shanghai"

ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /hystrix-turbine.jar" ]