FROM maven:3-jdk-8-alpine

RUN mkdir /source
WORKDIR /source
COPY ./payara-micro.jar .
COPY ./pom.xml .
COPY ./src/ ./src/
RUN mvn clean package
RUN mv target/hello-payara.war ROOT.war
RUN java -jar payara-micro.jar --deploy ROOT.war --port '8081' --outputUberJar hello-payara.jar

FROM openjdk:8-jdk-alpine
COPY --from=0 /source/hello-payara.jar /hello-payara.jar
CMD ["java", "-jar", "/hello-payara.jar"]

