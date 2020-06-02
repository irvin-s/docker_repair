FROM tomcat

RUN apt-get -qq update
RUN apt-get -qqy install openjdk-7-jdk --fix-missing
RUN apt-get -qqy install maven

COPY . /app
WORKDIR /app
RUN mvn clean package

RUN cp /app/target/*.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
