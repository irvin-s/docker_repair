FROM java:7

ADD ./target/uberjar/cloujera-0.1.0-SNAPSHOT-standalone.jar /srv/cloujera.jar

EXPOSE 8080

CMD ["java", "-jar", "/srv/cloujera.jar"]
