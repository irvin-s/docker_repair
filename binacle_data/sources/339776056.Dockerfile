# Docker file inspired by 
## https://github.com/jenkinsci/docker
## https://github.com/docker-library/java/blob/b4a3c296023e590e410f645ab83d3c11a30cf535/openjdk-8-jdk/Dockerfile
## https://github.com/zulu-openjdk/zulu-openjdk/blob/master/debian/8u45-8.7.0.5/Dockerfile
## https://github.com/docker-library/buildpack-deps/blob/a0a59c61102e8b079d568db69368fb89421f75f2/sid/scm/Dockerfile 
## https://github.com/docker-library/buildpack-deps/blob/a0a59c61102e8b079d568db69368fb89421f75f2/sid/curl/Dockerfile

FROM cantara/debian-sid-zulu-jdk8

MAINTAINER erik-dev@fjas.no

# Jenkins is a strange product. It is often necessary to be able to log in to image and fix stuff. 
RUN apt-get update && apt-get install -y --no-install-recommends \
               vim git openssh-client \
        && rm -rf /var/lib/apt/lists/*


# Install StartCom certs
ENV JAVA_HOME /usr/lib/jvm/zulu-8-amd64/
RUN wget --quiet --continue http://www.startssl.com/certs/ca.crt \
	&& keytool -import -trustcacerts -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -noprompt -alias startcom.ca -file ca.crt \
	&& rm ca.crt
RUN wget --quiet --continue https://www.startssl.com/certs/sca.server1.crt \
	&& keytool -import -trustcacerts -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -noprompt -alias startcom.ca.sub.class1 -file sca.server1.crt \ 
	&& rm sca.server1.crt
RUN wget --quiet --continue https://www.startssl.com/certs/sca.server2.crt \ 
	&& keytool -import -trustcacerts -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -noprompt -alias startcom.ca.sub.class2 -file sca.server2.crt \
	&& rm sca.server2.crt
RUN wget --quiet --continue https://www.startssl.com/certs/sca.server3.crt \
        && keytool -import -trustcacerts -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -noprompt -alias startcom.ca.sub.class3 -file sca.server3.crt \
        && rm sca.server3.crt
RUN wget --quiet --continue https://www.startssl.com/certs/sca.server4.crt \
        && keytool -import -trustcacerts -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -noprompt -alias startcom.ca.sub.class4 -file sca.server4.crt \
        && rm sca.server4.crt

### Install maven
ENV MAVEN_VERSION 3.3.3

RUN curl --fail --silent --show-error --location --retry 3 \
    http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
  | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

#CMD ["mvn"]


### Install Jenkins 
ENV JENKINS_HOME /var/jenkins_home

# Jenkins is ran with user `jenkins`, uid = 1000
# If you bind mount a volume from host/vloume from a data container, 
# ensure you use same uid
RUN useradd -d "$JENKINS_HOME" -u 1000 -m -s /bin/bash jenkins

# Jenkins home directoy is a volume, so configuration and build history 
# can be persisted and survive image upgrades
VOLUME /var/jenkins_home

# `/usr/share/jenkins/ref/` contains all reference configuration we want 
# to set on a fresh new installation. Use it to bundle additional plugins 
# or config file with your custom jenkins Docker image.
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d
COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy

# ENV JENKINS_VERSION 1.609.3 
ENV JENKINS_VERSION 1.651.1
#ENV JENKINS_SHA 96ee85602a41d68c164fb54d4796be5d1d9cc5d0
ENV JENKINS_SHA bbfe03f35aad4e76ab744543587a04de0c7fe766

# could use ADD but this one does not check Last-Modified header 
# see https://github.com/docker/docker/issues/8331
RUN curl -L http://mirrors.jenkins-ci.org/war-stable/$JENKINS_VERSION/jenkins.war -o /usr/share/jenkins/jenkins.war
#\
#  && echo "$JENKINS_SHA /usr/share/jenkins/jenkins.war" | sha1sum -c -

ENV JENKINS_UC https://updates.jenkins-ci.org
RUN chown -R jenkins "$JENKINS_HOME" /usr/share/jenkins/ref

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
#EXPOSE 50000

ENV COPY_REFERENCE_FILE_LOG /var/log/copy_reference_file.log
RUN touch $COPY_REFERENCE_FILE_LOG && chown jenkins.jenkins $COPY_REFERENCE_FILE_LOG

USER jenkins

COPY jenkins.sh /usr/local/bin/jenkins.sh
ENTRYPOINT ["/usr/local/bin/jenkins.sh"]

# from a derived Dockerfile, can use `RUN plugin.sh active.txt` to setup /usr/share/jenkins/ref/plugins from a support bundle
COPY plugins.sh /usr/local/bin/plugins.sh


# preconfigure maven location
COPY hudson.tasks.Maven.xml /usr/share/jenkins/ref/hudson.tasks.Maven.xml
## not working properly 
# https://raw.githubusercontent.com/paoloantinori/dockerfiles/master/centos/jenkins/Dockerfile
#RUN printf "<?xml version='1.0' encoding='UTF-8'?> <hudson.tasks.Maven_-DescriptorImpl> <installations> <hudson.tasks.Maven_-MavenInstallation> <name>maven</name> <home>/usr/share/maven2</home> <properties/> </hudson.tasks.Maven_-MavenInstallation> </installations> </hudson.tasks.Maven_-DescriptorImpl>" >>  $JENKINS_HOME/hudson.tasks.Maven.xml ; chown jenkins:jenkins $JENKINS_HOME/hudson.tasks.Maven.xml 

#Ensure JDK path is set
COPY config.xml /usr/share/jenkins/ref/config.xml

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
