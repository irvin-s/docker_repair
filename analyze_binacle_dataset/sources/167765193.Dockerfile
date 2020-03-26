FROM   evgenyg/ansible
ADD    playbooks /playbooks
RUN    ansible-playbook /playbooks/jenkins-ubuntu.yml -c local
EXPOSE 8080
CMD    JAVA_HOME=/usr/lib/jvm/java-7-oracle JENKINS_HOME=/var/lib/jenkins /usr/bin/java -Djava.awt.headless=true -jar /usr/share/jenkins/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080 --ajp13Port=-1
