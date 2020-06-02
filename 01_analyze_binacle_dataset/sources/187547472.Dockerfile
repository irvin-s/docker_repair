FROM ubuntu:trusty

MAINTAINER Larry Cai <larry.caiyu@gmail.com>

ENV REFRESHED_AT 2014-11-24

#RUN rm /etc/apt/sources.list.d/* \
#    && echo "deb http://mirrors.sohu.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list \
#    && echo "deb http://mirrors.sohu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list 

RUN apt-get update  && apt-get install -qqy curl openjdk-6-jdk

ENV JENKINS_HOME /opt/jenkins/data
ENV JENKINS_MIRROR http://mirrors.jenkins-ci.org

# install jenkins.war and plugins
RUN mkdir -p $JENKINS_HOME/plugins

RUN curl -o /opt/jenkins/jenkins.war -L $JENKINS_MIRROR/war-stable/latest/jenkins.war

RUN for plugin in scm-api git-client ansicolor git ssh-slaves ;\
    do curl -sf -o $JENKINS_HOME/plugins/${plugin}.hpi \
       -L $JENKINS_MIRROR/plugins/${plugin}/latest/${plugin}.hpi ; done

RUN curl https://get.docker.io/builds/Linux/x86_64/docker-latest -o /usr/local/bin/docker
RUN chmod +x /usr/local/bin/docker

# ADD JENKINS_HOME 
ADD JENKINS_HOME $JENKINS_HOME
RUN chmod +x $JENKINS_HOME/start.sh

EXPOSE 8080

CMD [ "/opt/jenkins/data/start.sh" ]