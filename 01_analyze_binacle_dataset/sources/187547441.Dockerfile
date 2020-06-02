FROM ubuntu:trusty

MAINTAINER Larry Cai <larry.caiyu@gmail.com>

ENV REFRESHED_AT 2016-04-09

#RUN rm /etc/apt/sources.list.d/* \
#    && echo "deb http://mirrors.sohu.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list \
#    && echo "deb http://mirrors.sohu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list

RUN apt-get update  && apt-get install -qqy curl openjdk-7-jdk

ENV JENKINS_HOME /opt/jenkins/data
ENV JENKINS_MIRROR http://mirrors.jenkins-ci.org

# install jenkins.war and plugins
RUN mkdir -p $JENKINS_HOME/plugins

RUN curl -o /opt/jenkins/jenkins.war -L $JENKINS_MIRROR/war-stable/latest/jenkins.war

RUN for plugin in scm-api git-client ansicolor git ssh-slaves ;\
    do curl -sf -o $JENKINS_HOME/plugins/${plugin}.hpi \
       -L $JENKINS_MIRROR/plugins/${plugin}/latest/${plugin}.hpi ; done

RUN curl -sL https://get.docker.io/builds/Linux/x86_64/docker-1.10.3 -o /usr/local/bin/docker &&\
    chmod +x /usr/local/bin/docker
RUN curl -sL https://github.com/docker/compose/releases/download/1.6.2/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose &&\
    chmod +x /usr/local/bin/docker-compose

# ADD JENKINS_HOME
ADD JENKINS_HOME $JENKINS_HOME
RUN chmod +x $JENKINS_HOME/start.sh

EXPOSE 8080

CMD [ "/opt/jenkins/data/start.sh" ]
