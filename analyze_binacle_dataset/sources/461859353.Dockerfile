FROM java:8
MAINTAINER qilong zhao

ADD @project.build.finalName@.jar ./opt/app.jar

RUN sh -c 'touch ./opt/app.jar'
EXPOSE 7070
CMD ["java","-Djava.security.egd=file:/dev/./urandom", "-Dspring.profiles.active=@env@", "-jar", "./opt/app.jar"]