FROM frolvlad/alpine-oraclejdk8:slim
VOLUME /tmp
LABEL Vendor="EasyFrame" easyframe-serv="ef-hystrixdashboard"
ADD target/easyframe-hystrix-dashboard-master-SNAPSHOT-exec.jar hystrix-dashboard.jar
RUN sh -c 'touch /hystrix-dashboard.jar'

ENV JAVA_OPTS="-server -Xmx512m -Xms512m -XX:NewRatio=1 -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 \
-XX:+UseCMSInitiatingOccupancyOnly -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:ReservedCodeCacheSize=128M \
-XX:MaxTenuringThreshold=6 -XX:+ExplicitGCInvokesConcurrent -Duser.timezone=Asia/Shanghai"

ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /hystrix-dashboard.jar" ]