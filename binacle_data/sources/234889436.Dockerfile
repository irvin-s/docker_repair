FROM maven:3-jdk-8-onbuild-alpine
EXPOSE 4567

RUN cp ./target/athenaproxy-*-jar-with-dependencies.jar ./athena.jar

CMD java -jar athena.jar
