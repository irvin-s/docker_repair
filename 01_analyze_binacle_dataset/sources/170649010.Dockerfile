FROM n3ziniuka5/ubuntu-oracle-jdk:14.04-JDK7
MAINTAINER Victor Uceda (victor.ucedauceda@telefonica.com)

RUN sudo apt-get update
RUN sudo apt-cache search maven
RUN sudo apt-get -y install maven
RUN mvn -version

COPY . /usr/src/app
RUN mvn clean package -X -P generate-autojar-PCE -f /usr/src/app/pom.xml
RUN pwd
RUN ls
RUN ifconfig
WORKDIR /usr/src/app/

EXPOSE 4189
EXPOSE 6666

#RUN java -jar /usr/src/app/target/PCE-jar-with-dependencies.jar /usr/src/app/src/test/resources/PCEServerConfiguration_SSON_Line.xml
