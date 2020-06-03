FROM ubuntu:trusty

MAINTAINER Larry Cai <larry.caiyu@gmail.com>

RUN apt-get update  && apt-get install -qqy curl openjdk-7-jdk groovy && rm -rf /var/lib/apt/lists/*

ENV JENKINS_HOME /opt/jenkins/data
ENV JENKINS_MIRROR http://mirrors.jenkins-ci.org

# install jenkins.war and plugins

RUN mkdir -p $JENKINS_HOME/plugins 

RUN curl -o /opt/jenkins/jenkins.war -L $JENKINS_MIRROR/war-stable/latest/jenkins.war

ENV REFRESHED_AT 2015-06-24

RUN for plugin in groovy metrics;\
    do curl -f -o $JENKINS_HOME/plugins/${plugin}.hpi \
       -L $JENKINS_MIRROR/plugins/${plugin}/latest/${plugin}.hpi ; done

ADD JENKINS_HOME $JENKINS_HOME

RUN chmod +x $JENKINS_HOME/start.sh

# start script

ADD . /app

EXPOSE 8080

CMD [ "/opt/jenkins/data/start.sh" ]