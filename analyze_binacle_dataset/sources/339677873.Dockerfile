FROM tutum/centos:centos5
MAINTAINER Gary Deer

#######################################
# install necessary OS packages
RUN yum -y install wget && \
    yum -y install sudo && \
    yum -y install unzip

#######################################
# environment variables
#

# user information
#ENV USER svc_jboss
#ENV USER_HOME_DIR /home/$USER

# environment variable for local location
ENV LOCAL_SCRIPTS scripts
ENV LOCAL_TOOLS tools

# environment variables for installables
ENV BASE_TMP_INSTALL /tmp

# environment variables for install location
ENV BASE_DIR /appl

#######################################
# create directories
RUN mkdir $BASE_DIR
RUN chmod 777 $BASE_DIR

#######################################
# create user

#Doesn't seem to work in docker
#RUN useradd -p $(openssl passwd -1 $USER) $USER
#RUN useradd -p '$1$G/7MztKx$k7Kfi52IKw4g9ZWsN/oYM.' $USER
#RUN useradd -p testing	$USER

ADD $LOCAL_SCRIPTS/modsudoers.sh $BASE_TMP_INSTALL/modsudoers.sh

# provide sudoers access to user
RUN source $BASE_TMP_INSTALL/modsudoers.sh

#######################################
# Download java from Oracle
ENV JDK_URL http://download.oracle.com/otn-pub/java/jdk/6u38-b05/jdk-6u38-linux-x64-rpm.bin
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -P /tmp $JDK_URL
RUN chmod a+x $BASE_TMP_INSTALL/jdk-6u38-linux-x64-rpm.bin*

# Install jdk.  home is /usr/java/jdk1.6.0_38/
RUN $BASE_TMP_INSTALL/jdk-6u38-linux-x64-rpm.bin*

#######################################
# Install JBoss
#
# Add jboss package to container
ADD $LOCAL_TOOLS/jboss-eap-5.1.2.zip $BASE_TMP_INSTALL/jboss-eap-5.1.2.zip

# Unzip server to location
RUN unzip -q $BASE_TMP_INSTALL/jboss-eap-5.1.2.zip -d $BASE_DIR

# Create simple link for ease of use
RUN ln -s $BASE_DIR/jboss-eap-5.1.2 $BASE_DIR/jboss

RUN chown -R $USER:$USER $BASE_DIR 

#######################################
# Cleanup
RUN rm -rf $BASE_TMP_INSTALL/*

# Can delete yum installs but am not doing it for standards tools 
# used across images
#RUN yum -y remove wget

#######################################
# DONE

ENV AUTHORIZED_KEYS **None**

EXPOSE 22 
EXPOSE 8080

CMD ["/run.sh"]


