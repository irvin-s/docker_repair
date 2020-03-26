FROM ubuntu:16.04
MAINTAINER Seshagiri Sriram <seshagirisriram@gmail.com>

RUN addgroup jenkins_demo && adduser --home /home/jenkins_demo \
    --shell /bin/bash --ingroup jenkins_demo --disabled-password \
	--quiet --gecos "" jenkins_demo 
RUN mkdir /root/.ssh && chmod 700 /root/.ssh && chown 700 /root/.ssh
COPY id_rsa.pub /root/.ssh 
COPY id_rsa /root/.ssh 
RUN chmod 600 /root/.ssh/id_rsa \
    && chmod 644 /root/.ssh/id_rsa.pub \
	&& chown root:root /root/.ssh/id_rsa*
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
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/<!-- interactiveMode/<localRepository>\/repos<\/localRepository><!-- interactiveMode/' /usr/share/maven/conf/settings.xml


# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]