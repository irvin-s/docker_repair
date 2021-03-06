FROM java:openjdk-8-jre-alpine

# add directly the war
ADD *.war /app.war

RUN sh -c 'touch /app.war'
VOLUME /tmp
CMD ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.war"]

EXPOSE 8080 5701/udp
