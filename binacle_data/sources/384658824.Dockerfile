FROM centos:7
MAINTAINER Istvan Szukacs <leccine@gmail.com>
RUN curl -vjkL -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31-linux-x64.rpm > jdk-8u31-linux-x64.rpm
RUN rpm -i jdk-8u31-linux-x64.rpm
RUN yum -y update; yum clean all;
EXPOSE 8080
ADD target/shovel-0.9.1-standalone.jar /srv/shovel-0.9.1-standalone.jar
ADD conf/app.edn /srv/conf/app.edn
RUN cat /srv/conf/app.edn
CMD ["java", "-jar", "/srv/shovel-0.9.1-standalone.jar", "print-config", "--config-file", "/srv/conf/app.edn"]
