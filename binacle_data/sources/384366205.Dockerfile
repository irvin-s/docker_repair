FROM stackbrew/ubuntu:13.10

MAINTAINER ahunnargikar@ebay.com

RUN apt-get update

#Install Java & Maven
RUN apt-get -y install default-jdk maven

#Install packages
RUN apt-get -y install wget curl git-core nano

# This will use the latest public release. To use your own, comment it out...
ADD https://get.docker.io/builds/Linux/x86_64/docker-latest /usr/local/bin/docker

#Install & configure Supervisor
RUN apt-get -y install supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#Make the Docker binary executable
RUN chmod +x /usr/local/bin/docker

#Run Supervisor
CMD ["/usr/bin/supervisord"]