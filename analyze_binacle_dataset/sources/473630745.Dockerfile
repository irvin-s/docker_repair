FROM centos:centos7
RUN yum -y clean all
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install git yum-utils make gcc-c++ tar bzip2 words
RUN yum-config-manager --add-repo https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo
RUN yum -y install apache-maven-3.2.5

RUN git clone https://github.com/apache/incubator-zeppelin /zeppelin


WORKDIR /zeppelin
RUN mvn -DskipTests -Pspark-1.3 -Phadoop-2.4 clean package
ADD zeppelin-env.sh /zeppelin/conf/zeppelin-env.sh
ADD zeppelin-site.xml /zeppelin/conf/zeppelin-site.xml

EXPOSE 8080
EXPOSE 8081

CMD ["bin/zeppelin.sh", "start"]



