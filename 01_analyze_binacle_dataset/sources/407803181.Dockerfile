FROM openjdk:8u131-jdk-alpine

ADD http://repo2.maven.org/maven2/com/h2database/h2/1.4.196/h2-1.4.196.jar /root/h2-1.4.196.jar
ENV DATA_DIR /opt/h2-data

RUN mkdir -p ${DATA_DIR}

EXPOSE 81 1521

CMD java -cp /root/h2-1.4.196.jar org.h2.tools.Server \
 	-web -webAllowOthers -webPort 81 \
 	-tcp -tcpAllowOthers -tcpPort 9092 \
 	-baseDir ${DATA_DIR}


