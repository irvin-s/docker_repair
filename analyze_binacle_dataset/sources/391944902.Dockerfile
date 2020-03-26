FROM java:8

MAINTAINER "André Luis Gomes <andrelugomes@gmail.com>"

ENV APP /app

COPY . $APP/

WORKDIR $APP

EXPOSE 8080

CMD ["java","-jar","target/jms-spring-1.0.0.jar"]