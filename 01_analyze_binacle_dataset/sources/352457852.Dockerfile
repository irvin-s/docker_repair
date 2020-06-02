# This image will be based on an image configured with Java 8
FROM java:8

MAINTAINER Victor Ferrer <vferrer2005@gmail.com>

# This is the directory used by Tomcat to deploy the app 
VOLUME /tmp

# This will add our jar as executable with the alias "app.jar"
ADD stokker-0.0.1-SNAPSHOT.jar app.jar

# Done to update the file timestamp
RUN bash -c 'touch /app.jar'

# urandom property modified for a faster startup (!!??)
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

# This will expose the internal 8080 port to the outside if -P flag is provided
EXPOSE 8080 9200

