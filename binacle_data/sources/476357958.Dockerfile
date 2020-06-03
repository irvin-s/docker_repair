#######################################################################
#                                                                     #
# Creates a base CentOS image with JBoss EAP 6.3 					  #
#                                                                     #
#######################################################################
FROM    centos:centos6

MAINTAINER tqvarnst <tqvarnst@redhat.com>

# Update the system and Install necessary RPMs
RUN yum -y install java-1.7.0-openjdk-devel unzip

# Make sure JAVA_HOME is set
ENV JAVA_HOME /usr/lib/jvm/jre

# Set root password
RUN echo "root:redhat" | /usr/sbin/chpasswd

# Create user to run JBoss EAP
RUN useradd -m -d /home/jdg -p jdg jdg

#######################################################################                                                                     #
# Install JBoss Data grid					      #
#								      #
#######################################################################
USER jdg

ENV HOME /home/jdg
   
ADD jboss-datagrid-6.3.0-server.zip $HOME/

RUN /usr/bin/unzip -q $HOME/jboss-datagrid-6.3.0-server.zip -d $HOME

ENV JDG_HOME $HOME/jboss-datagrid-6.3.0-server

RUN $JDG_HOME/bin/add-user.sh -g admin -u admin -p admin-123 -s

EXPOSE 8080 9990 9999 11222
CMD $JDG_HOME/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0


