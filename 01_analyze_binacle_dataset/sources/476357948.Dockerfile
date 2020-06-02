#######################################################################
#                                                                     #
# Creates a base CentOS image with Jenkins							  #
#                                                                     #
#######################################################################

# Use the centos base image
FROM centos:centos6
MAINTAINER Thomas Qvarnstrom <tqvarnst@redhat.com>


USER root
# Update the system
RUN yum -y update;yum clean all


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

