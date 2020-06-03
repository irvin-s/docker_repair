FROM centos

ADD http://repo.maven.apache.org/maven2/org/apache/tomcat/tomcat/8.0.33/tomcat-8.0.33.tar.gz /var/tomcat.tar.gz
ADD http://repository.primefaces.org/org/primefaces/showcase/5.3/showcase-5.3.war /var/showcase.war

RUN yum install -y java-1.8.0-openjdk-devel && \
    tar zxvf /var/tomcat.tar.gz && \
    mv apache-tomcat-8.0.33 /opt/tomcat && \
    mv /var/showcase.war /opt/tomcat/webapps

ENV JAVA_HOME=/usr/lib/jvm/java

WORKDIR /opt/tomcat

ENTRYPOINT ["./bin/catalina.sh", "run"]
