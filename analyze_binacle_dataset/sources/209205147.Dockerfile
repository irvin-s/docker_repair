FROM ubuntu:16.04
MAINTAINER Seshagiri Sriram <seshagirisriram@gmail.com>


ENV NOTVISIBLE "in users profile"
RUN addgroup jenkins_demo && adduser --home /home/jenkins_demo \
    --shell /bin/bash --ingroup jenkins_demo --disabled-password \
	--quiet --gecos "" jenkins_demo 
RUN apt-get update && apt-get install -y \
    openssh-server \ 
	openjdk-8-jdk \
	ant \
	maven \ 
	git \
    && rm -rf /var/lib/apt/lists/* \
 	&& mkdir /var/run/sshd \
	&& mkdir /repos 

RUN echo 'root:screencast' | chpasswd
RUN echo 'jenkins_demo:password'|chpasswd 
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config &&  sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && sed -i 's/<!-- interactiveMode/<localRepository>\/repos<\/localRepository><!-- interactiveMode/' /usr/share/maven/conf/settings.xml

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
