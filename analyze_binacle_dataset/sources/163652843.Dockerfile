FROM java:8

MAINTAINER Marcel Birkner <marcel.birkner@codecentric.de>

VOLUME /tmp

ADD target/conference-app*.war app.war

RUN bash -c 'touch /app.war'

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.war"]
