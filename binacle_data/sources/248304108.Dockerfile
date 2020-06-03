FROM maven:alpine
MAINTAINER Denis Carriere <carriere.denis@gmail.com>

# Create app directory
COPY ./OSVUploadr /usr/src/app
WORKDIR /usr/src/app

# Build Package with Maven
RUN mvn package