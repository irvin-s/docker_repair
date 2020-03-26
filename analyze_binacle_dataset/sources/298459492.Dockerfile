FROM frolvlad/alpine-oraclejdk8:slim
MAINTAINER eastseven <eastseven@foxmail.com>

VOLUME /logs
VOLUME /upload
EXPOSE 8080

ADD target/app.jar app.jar
RUN sh -c 'touch app.jar'
ENV JAVA_OPTS="-Xmx300m -Xms300m"
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar -Duser.timezone=GMT+8 app.jar" ]