FROM ewolff/docker-java
COPY target/microservice-atom-invoicing-0.0.1-SNAPSHOT.jar .
CMD /usr/bin/java -Xmx400m -Xms400m -jar microservice-atom-invoicing-0.0.1-SNAPSHOT.jar
EXPOSE 8080
