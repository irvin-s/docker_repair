FROM docker.internal.kevinlin.info/infra/ci-base:0.1.0

# Install Docker and lint/verification dependencies
RUN apt-get install -y apt-transport-https ca-certificates software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get install -y nginx yamllint python3-pkg-resources docker-ce

# Docker Compose
RUN curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

# Give jenkins permission to invoke Docker
RUN usermod -aG docker jenkins
