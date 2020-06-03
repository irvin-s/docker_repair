FROM drissamri/java:jre8

MAINTAINER  Driss Amri

ADD target/linkshortener-*.jar /app/linkshortener.jar

EXPOSE 9080

CMD ["java", "-jar", "/app/linkshortener.jar", "--spring.profiles.active=cloud"]