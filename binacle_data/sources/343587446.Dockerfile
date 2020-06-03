FROM jenkins

# Setup docker
USER root
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables
    
# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com | sh
RUN gpasswd -a jenkins docker

# Install docker compose
RUN curl -L https://github.com/docker/compose/releases/download/1.5.0rc3/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

# Restore user
USER jenkins

# Install plugins
COPY ./plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

# Import jenkins files
COPY ./jenkins_home /var/jenkins_home

# Declare environment variables
ENV DOCKER_HOST=unix:///var/run/docker.sock
