# docker run -i -t --entrypoint /bin/bash [image]

FROM ubuntu:14.04
MAINTAINER Sergio Morales "sdmoralesma@gmail.com"

#Install latest java9 jdk
RUN export DEBIAN_FRONTEND=noninteractive && \ 
    apt-get update && \
    apt-get install -y software-properties-common python-software-properties && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java9-installer oracle-java9-set-default

# Install Maven
ENV MAVEN_VERSION 3.3.3
RUN wget --quiet -O /tmp/apache-maven-$MAVEN_VERSION.tar.gz http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    tar xzf /tmp/apache-maven-$MAVEN_VERSION.tar.gz -C /opt/ && \
    ln -s /opt/apache-maven-$MAVEN_VERSION /opt/maven && \
    ln -s /opt/maven/bin/mvn /usr/local/bin && \
    rm -f /tmp/apache-maven-$MAVEN_VERSION.tar.gz
ENV MAVEN_HOME /opt/maven

# Install Kulla
RUn export DEBIAN_FRONTEND=noninteractive && \ 
    apt-get install unzip
ENV KULLA_JAR kulla-*.jar
RUN cd /opt && wget --quiet https://adopt-openjdk.ci.cloudbees.com/job/langtools-1.9-linux-x86_64-kulla-dev/lastSuccessfulBuild/artifact/*zip*/archive.zip && \
    unzip archive.zip

ADD repl /opt/repl/
RUN mvn package -q -f /opt/repl/pom.xml

# Run repl
CMD java -jar /opt/repl/target/repl-jar-with-dependencies.jar
