FROM java:8
RUN ["mkdir", "/jandy"]
COPY ./jandy-server/target/jandy-server-*.jar /jandy/jandy-server.jar
WORKDIR /jandy
ENTRYPOINT ["java", "-jar", "jandy-server.jar"]
