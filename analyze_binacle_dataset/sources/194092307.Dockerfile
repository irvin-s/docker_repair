FROM openjdk:8-jre

ADD cache/ /app/cache
ADD target/titan-1.0.jar /app/titan-1.0.jar
ADD config/ /app/config

WORKDIR /app

ENTRYPOINT ["java", "-jar", "/app/titan-1.0.jar"]
