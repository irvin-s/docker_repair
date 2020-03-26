FROM java:8
MAINTAINER Stephen Judd "stephen.judd@opencredo.com"

EXPOSE 8095

ADD target/books-example-1.0-SNAPSHOT.jar /application.jar

CMD java -jar /application.jar
