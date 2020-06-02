FROM ubuntu:trusty

MAINTAINER Larry Cai <larry.cai@gmail.com>

RUN apt-get update  && apt-get install -qqy curl openjdk-7-jdk groovy && rm -rf /var/lib/apt/lists/*

ENV JENKINS_HOME /opt/jenkins/data
ENV JENKINS_MIRROR http://mirrors.jenkins-ci.org

# install jenkins.war and plugins

RUN mkdir -p $JENKINS_HOME/plugins 

RUN curl -o /opt/jenkins/jenkins.war -L $JENKINS_MIRROR/war-stable/latest/jenkins.war

ENV REFRESHED_AT 2015-06-26

# git environment
RUN for plugin in git scm-api git-client credentials credentials-binding workflow-step-api plain-credentials;\
    do curl -f -o $JENKINS_HOME/plugins/${plugin}.hpi \
       -L $JENKINS_MIRROR/plugins/${plugin}/latest/${plugin}.hpi ; done
	   
RUN for plugin in job-dsl config-file-provider groovy-postbuild groovy junit testng-plugin claim;\
    do curl -f -o $JENKINS_HOME/plugins/${plugin}.hpi \
       -L $JENKINS_MIRROR/plugins/${plugin}/latest/${plugin}.hpi ; done

# more needed plugin 
RUN for plugin in token-macro jquery parameterized-trigger postbuild-task description-setter \
				throttle-concurrents ws-cleanup gerrit-trigger testng-plugin envinject cobertura \
				build-flow-plugin buildgraph-view nested-view global-post-script   \
				ansicolor build-timeout timestamper artifactory;\
    do curl -f -o $JENKINS_HOME/plugins/${plugin}.hpi \
       -L $JENKINS_MIRROR/plugins/${plugin}/latest/${plugin}.hpi ; done
	   
# more needed plugin 
RUN for plugin in progress-bar-column-plugin mock-slave durable-task labeled-test-groups-publisher \
				locks-and-latches build-user-vars-plugin multiple-scms built-on-column \
				config-file-provider junit email-ext sonar;\
    do curl -f -o $JENKINS_HOME/plugins/${plugin}.hpi \
       -L $JENKINS_MIRROR/plugins/${plugin}/latest/${plugin}.hpi ; done	    
	   
# the credentials needs to be later version to satisfied with other plugins
RUN touch $JENKINS_HOME/plugins/credentials.jpi.pinned   
	   
ADD JENKINS_HOME $JENKINS_HOME

RUN chmod +x $JENKINS_HOME/start.sh

# start script

ADD . /app

EXPOSE 8080

CMD [ "/opt/jenkins/data/start.sh" ]