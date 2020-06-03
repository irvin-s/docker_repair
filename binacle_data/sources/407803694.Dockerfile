FROM openjdk:8u131-jdk-alpine

ADD http://repo2.maven.org/maven2/com/h2database/h2/1.4.196/h2-1.4.196.jar /root/h2-1.4.196.jar

CMD java -cp /root/h2-1.4.196.jar org.h2.tools.Server \
 	-web -webAllowOthers -webPort 81 \
 	-tcp -tcpAllowOthers -tcpPort 9092 \
 	-baseDir /root


