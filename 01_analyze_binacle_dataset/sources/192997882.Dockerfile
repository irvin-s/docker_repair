# Docker container for application in development environment
FROM maven:3.3.3-jdk-8
MAINTAINER Hosuaby <alexey_klenin@hotmail.fr>

# Set environment variables
ENV PORT=8080 \
    SPRING_DATA_MONGODB_URI=mongodb://db:27017/db_teapots

# Exposes port of web application
EXPOSE $PORT

# Volume for directory with project sources
VOLUME /project

# Volume is the work dir
WORKDIR /project

# Launch application with Spring Boot Maven Plugin to enable automatic reloads
CMD mvn spring-boot:run fork
