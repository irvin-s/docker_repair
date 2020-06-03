FROM registry.access.redhat.com/rhel7/rhel

ENV JENKINS_SWARM_VERSION 2.0
ENV JNLP_SLAVE_VERSION 2.52
ENV HOME /opt/jenkins-slave
ENV MAVEN_VERSION 3.3.3
ENV JAVA_HOME /usr/lib/jvm/java

RUN yum install -y git tar zip unzip which java-1.8.0-openjdk-devel && \
    yum clean all && \
    useradd -u 1001 -r -m -d ${HOME} -s /sbin/nologin -c "Jenkins Slave" jenkins-slave && \
    mkdir -p /opt/jenkins-slave/bin /var/lib/jenkins && \
    curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
      && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
      && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# Copy script
COPY jenkins-slave.sh /opt/jenkins-slave/bin/

# Download plugin and modify permissions
RUN curl --create-dirs -sSLo /opt/jenkins-slave/bin/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar http://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar \
  && curl --create-dirs -sSLo /opt/jenkins-slave/bin/slave.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/$JNLP_SLAVE_VERSION/remoting-$JNLP_SLAVE_VERSION.jar \
  && chmod -R 775 /opt/jenkins-slave /var/lib/jenkins && \
  chown -R jenkins-slave:root /opt/jenkins-slave /var/lib/jenkins

WORKDIR /var/lib/jenkins

VOLUME /var/lib/jenkins

USER 1001

ENTRYPOINT ["/opt/jenkins-slave/bin/jenkins-slave.sh"]
