FROM azul/zulu-openjdk:8

WORKDIR /app
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/order-ui-0.0.1-SNAPSHOT.jar"]

ADD build/libs/order-ui-0.0.1-SNAPSHOT.jar /app/
