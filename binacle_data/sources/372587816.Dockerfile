FROM base

RUN apt-get -q -y install openjdk-7-jre-headless && apt-get clean

# Install Jenkins
RUN mkdir /opt/jenkins
RUN wget -q -O /opt/jenkins/jenkins.war http://mirrors.jenkins-ci.org/war/1.550/jenkins.war
RUN chmod -R 644 /opt/jenkins/jenkins.war
ADD start-jenkins.sh /opt/jenkins/start-jenkins.sh
RUN chmod -R 644 /opt/jenkins/start-jenkins.sh
RUN useradd -m -d /var/lib/jenkins -u 1000 jenkins

EXPOSE 8080
CMD ["bash", "/opt/jenkins/start-jenkins.sh"]
