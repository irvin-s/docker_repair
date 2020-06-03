FROM ubuntu:trusty

MAINTAINER Larry Cai <larry.caiyu@gmail.com>

ENV REFRESHED_AT 2014-11-03

RUN apt-get update  && apt-get install -qqy curl openjdk-6-jdk

ENV JENKINS_HOME /opt/jenkins/data
ENV JENKINS_MIRROR http://mirrors.jenkins-ci.org

# install jenkins.war and plugins

RUN mkdir -p $JENKINS_HOME/plugins $JENKINS_HOME/jobs/craft
RUN curl -sf -o /opt/jenkins/jenkins.war -L $JENKINS_MIRROR/war-stable/latest/jenkins.war

RUN for plugin in chucknorris greenballs scm-api git-client ansicolor description-setter \
    envinject job-exporter git ws-cleanup ;\
    do curl -sf -o $JENKINS_HOME/plugins/${plugin}.hpi \
       -L $JENKINS_MIRROR/plugins/${plugin}/latest/${plugin}.hpi ; done

# ADD sample job craft

ADD craft-config.xml $JENKINS_HOME/jobs/craft/config.xml

# start script

ADD ./start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 8080

CMD [ "/usr/local/bin/start.sh" ]