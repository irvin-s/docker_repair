FROM maven:latest

COPY . .

RUN mvn package

CMD java -jar ./target/java-fullstack-1.0-SNAPSHOT.jar