FROM ibmjava:8-sfj

# Create app directory
RUN mkdir -p /usr/src/note-java/lib
WORKDIR /usr/src/note-java

# Bundle app source
COPY ./target/note-1.0.0.jar /usr/src/note-java
COPY ./target/lib/*.jar /usr/src/note-java/lib/

EXPOSE 50052
CMD [ "java", "-jar", "note-1.0.0.jar" ]
