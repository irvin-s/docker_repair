FROM stackbrew/ubuntu:trusty


RUN apt-get update && apt-get -y upgrade && apt-get -y install curl
RUN curl https://monitoring.api.rackspacecloud.com/pki/agent/linux.asc | apt-key add - 
RUN echo "deb http://stable.packages.cloudmonitoring.rackspace.com/ubuntu-14.04-x86_64 cloudmonitoring main" > /etc/apt/sources.list.d/rackspace-monitoring-agent.list
RUN apt-get update && apt-get -y install rackspace-monitoring-agent

