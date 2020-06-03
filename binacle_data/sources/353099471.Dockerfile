FROM ubuntu:14.04
MAINTAINER name <email@domain.com>

# Environment variables
ENV vsts_username ""
ENV vsts_password ""
ENV vsts_url ""
ENV vsts_agentname $HOSTNAME
ENV vsts_agentpool default
ENV vsts_service_username vsoservice
ENV vsts_service_password vsoservice
ENV LANG en_US.UTF-8

# Set locale
RUN locale-gen en_US.UTF-8

# Add repo source and update package listing
RUN sh -c 'echo "deb [arch=amd64] http://apt-mo.trafficmanager.net/repos/dotnet/ trusty main" > /etc/apt/sources.list.d/dotnetdev.list'
RUN apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893
RUN apt-get update

# Install dependencies
RUN apt-get install -y libicu52 dotnet=1.0.0.001598-1 expect git curl

# Create VSTS agent build directories
RUN mkdir -p /opt/buildagent
RUN mkdir -p /opt/buildagent/_work
WORKDIR /opt/buildagent

# Install VSTS agent
RUN curl -kSLO https://github.com/Microsoft/vsts-agent/releases/download/v0.7/vsts-agent-linux-1.999.0-0405.tar.gz
RUN tar zxvf vsts-agent-linux-1.999.0-0405.tar.gz

# Copy expect file
COPY ConfigureAgent.expect ConfigureAgent.expect

#  Create a service user 
RUN echo "${vsts_service_username}\n${vsts_service_password}\n\n\n\n\n\n\n" | adduser ${vsts_service_username}
RUN su ${vsts_service_username}

# Configure CMD
WORKDIR /opt/buildagent
RUN chown -R ${vsts_service_username} /opt/buildagent
COPY runagent.sh runagent.sh
RUN chmod +x runagent.sh
CMD ["/bin/sh","./runagent.sh"]