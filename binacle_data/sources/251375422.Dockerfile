FROM maven:3.3.9-jdk-8

# Create app directory
RUN mkdir -p /usr/src/note-java
WORKDIR /usr/src/note-java

# Bundle app source
COPY . /usr/src/note-java

RUN mvn clean install

EXPOSE 50052
CMD [ "java", "-jar", "./target/note-1.0.0.jar" ]
