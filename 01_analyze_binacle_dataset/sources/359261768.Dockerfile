FROM jenkins
MAINTAINER Sven Dowideit <SvenDowideit@docker.com>

RUN apt-get update && apt-get install -yq make
RUN curl -L https://github.com/docker/compose/releases/download/1.5.0rc1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

VOLUME /var/jenkins_home

COPY config.xml /var/jenkins_home/

RUN mkdir -p /var/jenkins_home/users/svendowideit/
COPY svendowideit.xml /var/jenkins_home/users/svendowideit/config.xml

# use the full tar file
COPY leeroy.tar /var/jenkins_home/
RUN mkdir -p /var/jenkins_home/jobs/ \
	&& cd /var/jenkins_home/jobs/ \
	&& tar xvf ../leeroy.tar

USER root

ENV JAVA_OPTS="-Xmx8192m"
ENV JENKINS_OPTS="--handlerCountStartup=100 --handlerCountMax=300 --debug=9"

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

ADD https://get.docker.com/builds/Linux/x86_64/docker-latest /usr/bin/docker
RUN chmod 755 /usr/bin/docker
COPY setup-docker-and-start-jenkins.sh /
ENTRYPOINT ["/setup-docker-and-start-jenkins.sh"]

# Stay as root so we can addthe docker group as needed
