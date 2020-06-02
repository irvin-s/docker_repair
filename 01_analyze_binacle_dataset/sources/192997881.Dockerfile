# Self contained application with MongoDB database
FROM ubuntu:15.04 
MAINTAINER Hosuaby <alexey_klenin@hotmail.fr>

# Package with add-apt-repository command
RUN apt-get install -y software-properties-common

# Install Java 8
RUN add-apt-repository ppa:openjdk-r/ppa \
    && apt-get update \
    && apt-get install -y openjdk-8-jre

# Install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 \
    && echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list \
    && apt-get update \
    && apt-get install -y mongodb-org \
    && mkdir -p /data/db

# Set environment variables
ENV PORT=8080 \
    SPRING_DATA_MONGODB_URI=mongodb://localhost:27017/db_teapots

# Exposed ports
EXPOSE $PORT 27017

# Copy Jar file into container
COPY target/*.jar /app/

# Run MongoDB & application
CMD mongod --fork --syslog \ 
    && java $JAVA_OPTS -Dserver.port=$PORT -jar /app/*.jar
