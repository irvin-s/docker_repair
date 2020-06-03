FROM jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
USER root

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-1.11.2.tgz && tar --strip-components=1 -xvzf docker-1.11.2.tgz -C /usr/local/bin

RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install ecs-deploy awscli
RUN mkdir /root/.ssh
COPY seed-job.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY cloud.groovy    /usr/share/jenkins/ref/init.groovy.d/
COPY init.groovy     /usr/share/jenkins/ref/init.groovy
COPY jobs/           /usr/share/jenkins/ref/jobs/seed-job/workspace/jobs/
