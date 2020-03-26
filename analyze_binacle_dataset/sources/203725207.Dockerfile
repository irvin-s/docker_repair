FROM java
MAINTAINER David Flemström <dflemstr@spotify.com>
ENTRYPOINT ["/usr/bin/java", "-jar", "/usr/share/backend/backend.jar"]

ADD target/lib /usr/share/backend/lib
ADD target/backend.jar /usr/share/backend/backend.jar
