FROM jenkins/jenkins:lts

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Dpermissive-script-security.enabled=true"

USER root
RUN apt-get update && \
    apt-get install -y \
      apt-transport-https \
      sudo \
      ca-certificates \
      curl \
      jq \
      python-pip \
      software-properties-common && \
    pip install awscli && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" && \
    apt-get update && \
    apt-get install -y docker-ce && \
    echo '%jenkins ALL=NOPASSWD:/usr/sbin/service *' | tee -a /etc/sudoers && \
    groupdel docker && \
    groupadd -g 497 docker && \
    usermod -aG docker jenkins

COPY --chown=jenkins:jenkins jenkins/plugins.txt /var/jenkins_home/plugins.txt
COPY --chown=jenkins:jenkins jenkins/*.groovy /var/jenkins_home/init.groovy.d/
COPY --chown=jenkins:jenkins jenkins.properties /var/jenkins_home/

USER jenkins
RUN /usr/local/bin/install-plugins.sh < /var/jenkins_home/plugins.txt

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
