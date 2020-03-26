# Apache Zeppelin on centos 6.6 OS
# docker build -t @rybajs/metal/zeppelin-build .

FROM centos:6.6

MAINTAINER Lucas Bakalian <https://github.com/lucasbak>

WORKDIR /tmp/

RUN yum clean all
RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y wget unzip openssl git rpm tar bzip2 git yum-utils make gcc-c++ tar  words

RUN yum groupinstall -y 'Developement Tools'
RUN yum install -y npm

RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.rpm"
RUN rpm -ivh jdk-7u79-linux-x64.rpm
ENV JAVA_HOME /usr/java/default
RUN java -version

RUN wget http://apache.websitebeheerjd.nl/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.zip
RUN unzip apache-maven-3.3.3-bin.zip
RUN mv apache-maven-3.3.3/ /opt/maven
RUN mkdir -p /root/.m2/
RUN echo "<settings><mirrors><mirror><id>nexus</id><mirrorOf>*</mirrorOf><url>http://10.10.10.1:7444/nexus/content/groups/public</url></mirror></mirrors>><profiles><profile><id>nexus</id><repositories><repository><id>central</id><url>http://central</url><releases><enabled>true</enabled></releases><snapshots><enabled>true</enabled></snapshots></repository></repositories><pluginRepositories><pluginRepository><id>central</id><url>http://central</url><releases><enabled>true</enabled></releases><snapshots><enabled>true</enabled></snapshots></pluginRepository></pluginRepositories></profile></profiles><activeProfiles><activeProfile>nexus</activeProfile></activeProfiles></settings>" > /root/.m2/settings.xml

ENV MAVEN_HOME /opt/maven
ENV PATH $MAVEN_HOME/bin:$PATH
RUN export PATH MAVEN_HOME
RUN export CLASSPATH=.
RUN mvn -version

WORKDIR /tmp/
RUN git clone https://github.com/apache/incubator-zeppelin.git
WORKDIR /tmp/incubator-zeppelin/
RUN git checkout cc3b8c049f2791b97141d8e5ee980db455ef520b
RUN sed -i '/<\/dependencies>/ i <dependency><groupId>sqlline</groupId><artifactId>sqlline</artifactId><version>1.1.9</version></dependency>' phoenix/pom.xml
RUN echo "registry = http://10.10.10.1:7444/nexus/content/groups/npm-all" > ~/.npmrc
RUN sed -i "s/   'karma'/    \/\/'karma'/" zeppelin-web/Gruntfile.js
RUN mvn clean package -X  -Pspark-1.4 -Dspark.version=1.2.1 -Dhadoop.version=2.7.1 -Phadoop-2.6 -Pyarn -DskipTests

WORKDIR /tmp/
RUN mv /tmp/incubator-zeppelin /tmp/zeppelin-build
RUN tar -chzf zeppelin-build.tar.gz zeppelin-build

# Publish package at run time
# eg: `docker run --rm -v /tmp:/target @rybajs/metal/zeppelin-build`
CMD if mountpoint -q /target; then mv /tmp/zeppelin-build.tar.gz /target/zeppelin-build.tar.gz; else echo '/target is not a mountpoint.'; fi
