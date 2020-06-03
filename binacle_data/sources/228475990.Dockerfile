FROM java:8-jre-alpine
VOLUME /tmp

ENV APP_HOME /usr/local/app

RUN mkdir -p "$APP_HOME"
WORKDIR $APP_HOME

ADD app.jar app.jar
RUN sh -c "touch app.jar"
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","app.jar"]
EXPOSE 8080