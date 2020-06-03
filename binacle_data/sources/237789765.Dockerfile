FROM java:jdk

ENV APP_VERSION 0.1.0

COPY build/libs/chnorr-$APP_VERSION.jar /app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app.jar"]
