FROM java
MAINTAINER David Flemström <dflemstr@spotify.com>
ENTRYPOINT ["/usr/bin/java", "-jar", "/usr/share/frontend/frontend.jar"]

ADD target/lib /usr/share/frontend/lib
ADD target/frontend.jar /usr/share/frontend/frontend.jar
