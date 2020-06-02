FROM java:8-jre

MAINTAINER jerrychir <jerrychir@163.com>

VOLUME /tmp

ADD sangoes-uc.jar app.jar

RUN bash -c 'touch /app.jar'

ENTRYPOINT ["java","-Xmx3000m","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]


EXPOSE 8080