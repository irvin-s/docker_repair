FROM centos

# telnet is required by some fabric command. without it you have silent failures
RUN yum install -y java-1.7.0-openjdk java-1.7.0-openjdk-devel which telnet unzip openssh-server sudo openssh-clients
# enable no pass and speed up authentication
RUN sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/;s/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config

# enabling sudo group
RUN echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers
# enabling sudo over ssh
RUN sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers

# add a user for the application, with sudo permissions
#RUN useradd -m fabric8 ; echo fabric8: | chpasswd ; usermod -a -G wheel fabric8

# assigning higher default ulimits
# unluckily this is not very portable. these values work only if the user running docker daemon on the host has his own limits >= than values set here
# if they are not, the risk is that the "su fuse" operation will fail
#RUN echo "fabric8                -       nproc           4096" >> /etc/security/limits.conf
#RUN echo "fabric8                -       nofile           4096" >> /etc/security/limits.conf

# command line goodies
RUN echo "export JAVA_HOME=/usr/lib/jvm/jre" >> /etc/profile
RUN echo "alias ll='ls -l --color=auto'" >> /etc/profile
RUN echo "alias grep='grep --color=auto'" >> /etc/profile


WORKDIR /home/fabric8

ADD http://central.maven.org/maven2/org/jolokia/jolokia-jvm/1.3.1/jolokia-jvm-1.3.1-agent.jar /home/fabric8/jolokia-agent.jar

RUN mkdir lib
RUN mkdir classes
RUN mkdir etc
RUN mkdir logs

ADD log4j.properties /home/fabric8/classes/
ADD startup.sh /home/fabric8/
RUN chmod +x startup.sh 


ENV JAVA_HOME /usr/lib/jvm/jre
ENV FABRIC8_JAVA_AGENT -javaagent:jolokia-agent.jar=host=0.0.0.0
ENV FABRIC8_JVM_ARGS -Dlog4j.configuration=etc/log4j.properties
#ENV FABRIC8_MAIN_ARGS

#RUN chown -R fabric8:fabric8 /home/fabric8

# TODO changing the user causes derived containers to not use the correct user
#USER fabric8

# these are for containers building from this container
#ONBUILD chown -R fabric8:fabric8 /home/fabric8/lib/*
#ONBUILD USER fabric8
#ONBUILD WORKDIR /home/fabric8

EXPOSE 22 8080 8778

CMD /home/fabric8/startup.sh
