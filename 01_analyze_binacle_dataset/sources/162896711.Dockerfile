# WebApollo
# VERSION 0.1
FROM tomcat:7
ENV DEBIAN_FRONTEND noninteractive

# Taken from https://github.com/carlossg/docker-maven/blob/master/jdk-7/Dockerfile
ENV MAVEN_VERSION 3.2.5
RUN curl -sSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
    && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# TODO: decouple mongodb
RUN apt-get -qq update && apt-get install --no-install-recommends -y -qq git openjdk-7-jdk mongodb
RUN git clone https://github.com/protegeproject/webprotege /webprotege && \
	cd /webprotege && \
	git checkout 922a484079ac560d685a82a8ae58c4b8b270030f

RUN cd /webprotege && mvn install

RUN rm -rf /usr/local/tomcat/webapps/ROOT/* \
    && mv /webprotege/target/webprotege-2.6.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT/ \
    && cd /usr/local/tomcat/webapps/ROOT/ \
    && jar -xvf webprotege-2.6.1-SNAPSHOT.war


#COPY ./startup.sh /startup.sh
#RUN chmod +x /startup.sh
#CMD ["/startup.sh"]
