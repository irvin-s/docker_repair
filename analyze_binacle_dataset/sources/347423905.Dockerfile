# Ref: https://docs.docker.com/engine/reference/builder/

FROM openjdk:11-jre

LABEL maintainer="wclayf@gmail.com"

# Ref: https://docs.docker.com/storage/volumes/

#SubNode needs a temp working folder at runtime, and that's what this is.
RUN mkdir -p /subnode-tmp
RUN echo "SubNode temp folder" > /subnode-tmp/readme.md

#This is specifically for holding the log4j output that SubNode uses
RUN mkdir -p /subnode-log
RUN echo "SubNode log folder" > /subnode-log/readme.md

RUN mkdir -p /dev-resource-base
RUN echo "SubNode resources" > /dev-resource-base/readme.md

#automatically created by docker runtime
WORKDIR /subnode

#If you're not running using a docker network, then this expose command is not needed, but is harmless to have.
EXPOSE 8082
EXPOSE 8181
EXPOSE 8000
EXPOSE 80

ADD target/org.subnode-0.0.1-SNAPSHOT.jar /subnode/subnode.jar
RUN sh -c 'touch /subnode/subnode.jar' 
VOLUME ["/subnode-tmp", "/subnode-log"]
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-jar","/subnode/subnode.jar"]
