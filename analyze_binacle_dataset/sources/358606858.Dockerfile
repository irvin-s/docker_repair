FROM jenkins:1.609.2
MAINTAINER svanoort

# Workflow demo, jenkins host setup

USER root
ENV JENKINS_UC http://jenkins-updates.cloudbees.com

# Google repo install
RUN apt-get install -y curl python && \
    rm -rf /var/lib/apt/lists/*
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /bin/repo \
    && chmod a+x /bin/repo

# Maven install
ENV MAVEN_VERSION 3.3.1
RUN cd /usr/local; wget -O - http://mirrors.ibiblio.org/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xvzf -
RUN ln -sv /usr/local/apache-maven-$MAVEN_VERSION /usr/local/maven

# Keys for gerrit user, passphrase is EMPTY
COPY demo_key_rsa /tmp/
COPY workflow-version.txt /tmp/
COPY plugins.txt /tmp/
RUN sed -i "s/@VERSION@/`cat /tmp/workflow-version.txt`/g" /tmp/plugins.txt
RUN chown jenkins:jenkins /tmp/demo_key_rsa

# Set up jenkins home folder for starting point
ADD jenkins_home /usr/share/jenkins/ref
RUN chown -R jenkins.jenkins /usr/share/jenkins/ref

USER jenkins
RUN /usr/local/bin/plugins.sh /tmp/plugins.txt
CMD /usr/local/bin/jenkins.sh

# Fix for issues with the 'repo' tool needing an ident
RUN git config --global user.email "demouser@example.com" && \
    git config --global user.name "Demo User"

# COPY KEYS FOR USER TO JENKINS DIR
EXPOSE 8080