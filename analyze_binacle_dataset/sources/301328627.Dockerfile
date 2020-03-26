# Data Api vert.x web container
FROM ubuntu:16.04

RUN apt-get update && \
        apt-get install -y openjdk-8-jdk && \
        apt-get install -y ant && \
        apt-get clean;

# Fix certificate issues, found as of
# https://bugs.launchpad.net/ubuntu/+source/ca-certificates-java/+bug/983302
RUN apt-get update && \
        apt-get install ca-certificates-java && \
        apt-get clean && \
        update-ca-certificates -f;

RUN mkdir -p /root/verticle

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV VERTICLE_HOME /root/verticle

# Copy your verticle to the container
COPY bin $VERTICLE_HOME/bin
COPY conf $VERTICLE_HOME/conf
COPY entry $VERTICLE_HOME/entry
COPY lib $VERTICLE_HOME/lib

WORKDIR $VERTICLE_HOME/bin

ENTRYPOINT ["./startup.sh"]
