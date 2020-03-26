FROM ubuntu:15.04
MAINTAINER datawarehouse <aus-eng-data-warehouse@rmn.com>

RUN apt-get update
RUN apt-get install -y curl openjdk-7-jdk

RUN mkdir /src
RUN curl -s -o /src/elasticmq-server-0.8.8.jar https://s3-eu-west-1.amazonaws.com/softwaremill-public/elasticmq-server-0.8.8.jar

RUN \
    >> /src/custom.conf echo 'include classpath("application.conf")';\
    >> /src/custom.conf echo '';\
    >> /src/custom.conf echo '// What is the outside visible address of this ElasticMQ node (used by rest-sqs)';\
    >> /src/custom.conf echo 'node-address {';\
    >> /src/custom.conf echo '    protocol = http';\
    >> /src/custom.conf echo '    host = localhost';\
    >> /src/custom.conf echo '    port = 9324';\
    >> /src/custom.conf echo '    context-path = ""';\
    >> /src/custom.conf echo '}';\
    >> /src/custom.conf echo '';\
    >> /src/custom.conf echo 'rest-sqs {';\
    >> /src/custom.conf echo '    enabled = true';\
    >> /src/custom.conf echo '    bind-port = 9324';\
    >> /src/custom.conf echo '    bind-hostname = "0.0.0.0"';\
    >> /src/custom.conf echo '    // Possible values: relaxed, strict';\
    >> /src/custom.conf echo '    sqs-limits = relaxed';\
    >> /src/custom.conf echo '}'

RUN \
    >> /src/logback.xml echo '<configuration>';\
    >> /src/logback.xml echo '    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">';\
    >> /src/logback.xml echo '        <encoder>';\
    >> /src/logback.xml echo '            <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>';\
    >> /src/logback.xml echo '        </encoder>';\
    >> /src/logback.xml echo '    </appender>';\
    >> /src/logback.xml echo '';\
    >> /src/logback.xml echo '    <logger name="org.apache.http" level="INFO"/>';\
    >> /src/logback.xml echo '    <logger name="org.elasticmq" level="DEBUG"/>';\
    >> /src/logback.xml echo '';\
    >> /src/logback.xml echo '    <root level="DEBUG">';\
    >> /src/logback.xml echo '        <appender-ref ref="STDOUT" />';\
    >> /src/logback.xml echo '    </root>';\
    >> /src/logback.xml echo '</configuration>'

EXPOSE 9324

CMD ["java", "-jar", "-Dlogback.configurationFile=/src/logback.xml", "-Dconfig.file=/src/custom.conf", "/src/elasticmq-server-0.8.8.jar"]
