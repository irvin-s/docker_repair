FROM openjdk:8-jdk

RUN mkdir /opt/jmx_prometheus

RUN wget http://central.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.7/jmx_prometheus_javaagent-0.7.jar

RUN mv jmx_prometheus_javaagent-0.7.jar /opt/jmx_prometheus/jmx_prometheus_javaagent.jar
