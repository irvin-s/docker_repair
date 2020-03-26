#######################################################################
#                                                                     #
# Creates a base CentOS image with JBoss EAP 6.3 					  #
#                                                                     #
#######################################################################
FROM    centos:centos6

MAINTAINER ssadeghi <ssadeghi@redhat.com>
MAINTAINER tqvarnst <tqvarnst@redhat.com>

# Update the system and Install necessary RPMs
RUN yum -y install java-1.7.0-openjdk-devel unzip

# Make sure JAVA_HOME is set
ENV JAVA_HOME /usr/lib/jvm/jre

# Set root password
RUN echo "root:redhat" | /usr/sbin/chpasswd

# Create user to run JBoss EAP
RUN useradd -m -d /home/jbosseap -p jbosseap jbosseap 

#######################################################################                                                                     #
# Install JBoss EAP													  #                                                                     #
#######################################################################
USER jbosseap

ENV HOME /home/jbosseap
RUN mkdir $HOME/eap && \
 mkdir $HOME/tmp
   
ADD . $HOME/tmp/

RUN /usr/bin/unzip -q $HOME/tmp/jboss-eap-6.3.*.zip -d $HOME/eap

ENV JBOSS_HOME $HOME/eap/jboss-eap-6.3

RUN $JBOSS_HOME/bin/add-user.sh -g admin -u admin -p admin-123 -s

#######################################################################                                                                     #
# Clean up															  #                                                                     #
#######################################################################
RUN rm $HOME/tmp/*

CMD $HOME/eap/jboss-eap-6.3/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0

EXPOSE 8080 9990 9999

