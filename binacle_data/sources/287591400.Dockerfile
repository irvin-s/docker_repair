FROM java:8

# author infomation
MAINTAINER wikift

# create wikift application dir
RUN mkdir /wikift

# set volume to /wikift
VOLUME /wikift

# add wikift config to container
ADD wikift.example.conf /etc/wikift/wikift.conf

# rename wikift server file
ADD wikift-server-1.4.0.jar /wikift/wikift-server.jar

RUN sh -c 'touch /wikift-server.jar'

ENV JAVA_OPTS=""

ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /wikift/wikift-server.jar" ]