FROM jenkins

# install ansible & packer
USER root
RUN apt-get update && apt-get install -y ansible packer --no-install-recommends && rm -rf /var/lib/apt/lists/*

# install docker
RUN apt-get update && apt-get dist-upgrade -y && apt-get install apt-transport-https ca-certificates -y && echo deb https://apt.dockerproject.org/repo debian-jessie main > /etc/apt/sources.list.d/docker.list && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && apt-get update && apt-get install -y docker-engine && echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && rm -rf /var/lib/apt/lists/*

# install plugins
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
