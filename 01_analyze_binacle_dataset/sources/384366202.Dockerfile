FROM ubuntu

MAINTAINER ahunnargikar@ebay.com

RUN echo deb http://archive.ubuntu.com/ubuntu precise universe > /etc/apt/sources.list.d/universe.list

RUN apt-get update -qq
RUN apt-get install -qqy iptables ca-certificates lxc

#Install Java & Maven
RUN mkdir -p packages
ADD jdk.tar.gz /packages
ADD maven.tar.gz /packages
ENV JAVA_HOME /packages/jdk
ENV M2_HOME /packages/maven
ENV PATH $JAVA_HOME/bin:$PATH
ENV PATH $M2_HOME/bin:$PATH

#Install packages
RUN apt-get -y install wget curl git-core nano

# This will use the latest public release. To use your own, comment it out...
ADD https://get.docker.io/builds/Linux/x86_64/docker-latest /usr/local/bin/docker

ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/docker /usr/local/bin/wrapdocker
VOLUME /var/lib/docker

#Install & configure Supervisor
RUN apt-get -y install supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#Run Supervisor
CMD ["/usr/bin/supervisord"]