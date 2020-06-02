FROM tutum/centos:centos5
MAINTAINER Eric Stiles

#######################################
# install necessary OS packages
RUN yum -y install wget && \
    yum -y install sudo && \
    yum -y install unzip

#######################################
# environment variables
#

# user information
#ENV USER svc_oracle
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

ADD $LOCAL_SCRIPTS/modsudoers.sh $BASE_TMP_INSTALL/modsudoers.sh

# provide sudoers access to user
RUN source $BASE_TMP_INSTALL/modsudoers.sh

#######################################
# Copy Oracle files
ADD $LOCAL_TOOLS/p13390677_112040_Linux-x86-64_1of7.zip $BASE_TMP_INSTALL/p13390677_112040_Linux-x86-64_1of7.zip
ADD $LOCAL_TOOLS/p13390677_112040_Linux-x86-64_2of7.zip $BASE_TMP_INSTALL/p13390677_112040_Linux-x86-64_2of7.zip

# Unzip server to location
RUN unzip -q $BASE_TMP_INSTALL/p13390677_112040_Linux-x86-64_1of7.zip -d $BASE_DIR
RUN unzip -q $BASE_TMP_INSTALL/p13390677_112040_Linux-x86-64_2of7.zip -d $BASE_DIR

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


