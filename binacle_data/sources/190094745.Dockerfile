FROM registry.opensource.zalan.do/stups/openjdk:latest

EXPOSE 8085

COPY target/zmon-scheduler-1.0-SNAPSHOT.jar /zmon-scheduler.jar

CMD java $JAVA_OPTS $(java-dynamic-memory-opts) -jar zmon-scheduler.jar
