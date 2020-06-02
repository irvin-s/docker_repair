FROM openjdk:latest

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app

EXPOSE 8080
CMD [ "java", "-jar", "harambehub.jar" ]
