FROM openjdk:8-jdk-alpine

MAINTAINER "Marco Molteni <moltenma@gmail.com>"

ADD server/target/server-0.0.4-SNAPSHOT.war /usr/src/myapp/myApp.war

CMD ["java", "-jar", "/usr/src/myapp/myApp.war"]

####
# build with:
# docker build -t javaee/springdemo .
#
# run with:
# docker run --rm -it -p 80:80  javaee/springdemo
