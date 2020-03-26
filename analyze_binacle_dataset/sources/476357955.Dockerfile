#######################################################################
#                                                                     #
# Creates a base CentOS image with JBoss Fuse						  #
#                                                                     #
#######################################################################
FROM    centos:centos6

MAINTAINER tqvarnst <tqvarnst@redhat.com>

##########################################################
# Install Java JDK, SSH and other useful cmdline utilities
##########################################################
RUN yum -y install java-1.7.0-openjdk-devel which telnet unzip openssh-server sudo openssh-clients iputils iproute httpd-tools wget; yum clean all
ENV JAVA_HOME /usr/lib/jvm/jre

############################################
# Install Maven
############################################

RUN wget -O /etc/yum.repos.d/epel-apache-maven.repo http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo
RUN yum -y install apache-maven

############################################
# Install Git
############################################

RUN yum -y install git

# Set root password
RUN echo "root:redhat-123" | /usr/sbin/chpasswd

# Create jboss user to run JBoss Fuse
RUN useradd -m -d /home/jboss -p jboss-123 jboss 

############################################
# Install JBoss Fuse	
############################################
USER jboss

ENV HOME /home/jboss
WORKDIR $HOME
RUN mkdir tmp && mkdir .m2
ADD settings.xml $HOME/.m2/
ADD jboss-fuse-*.zip $HOME/

# The following section unzip's fuse and removes the top level dir since it contains a build number
RUN /usr/bin/unzip -q jboss-fuse-*.zip -d tmp
RUN mv tmp/jboss-fuse-*redhat-*/ fuse

ENV FUSE_HOME $HOME/fuse


# Create a admin user
#	Force a new line
RUN echo "" >> $FUSE_HOME/etc/users.properties
# 	Add a admin user
RUN echo "admin=admin-123,admin" >> $FUSE_HOME/etc/users.properties


#RUN $FUSE_HOME/bin/start

#RUN $FUSE_HOME/bin/client -r 3 -d 20 -u admin -p admin-123 'fabric:create --wait-for-provisioning'

#######################################################################                               
# Clean up															  #
#######################################################################
RUN rm -rf $HOME/tmp
RUN rm -f jboss-fuse-*.zip

ENTRYPOINT ["/home/jboss/fuse/bin/fuse"]

EXPOSE 8181

