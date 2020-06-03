FROM anapsix/alpine-java:latest

RUN mkdir app 
WORKDIR "/app" 
COPY target/docker-kafka-streams-1.0.jar .
COPY init.sh .
RUN ["chmod", "+x", "/app/init.sh"]

EXPOSE 8080
CMD ["sh", "init.sh"]
