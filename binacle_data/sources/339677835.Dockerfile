FROM ets04uga/jboss:eap-5.1.2
MAINTAINER Eric Stiles <ets04uga@yahoo.com>

#######################################
# environment variables
#

# user information
#ENV USER svc_atg
#ENV USER_HOME_DIR /home/$USER

# environment variable for local location
ENV LOCAL_SCRIPTS scripts
ENV LOCAL_TOOLS tools

# environment variables for installables
ENV BASE_TMP_INSTALL /tmp
ENV BASE_TMP_PACKAGE_INSTALL $BASE_TMP_INSTALL/packages

# environment variables for atg location
ENV BASE_DIR /appl
ENV SCRIPT_DIR /appl

#######################################
# create directories for copying initial copy of packages
RUN mkdir -p $BASE_TMP_PACKAGE_INSTALL

# directory for final install of application created as part of script directory
RUN mkdir -p $SCRIPT_DIR
RUN chmod -R 755 $SCRIPT_DIR

#######################################
# copy ATG
ADD $LOCAL_TOOLS/V35852-01.zip $BASE_TMP_PACKAGE_INSTALL/V35852-01.zip

# unzip oracle zip file for ATG to ATG10.1.2_200RCN.bin
RUN unzip $BASE_TMP_PACKAGE_INSTALL/V35852-01.zip -d $BASE_TMP_INSTALL

# make ATG10.1.2_200RCN.bin executable for install
RUN chmod +x $BASE_TMP_INSTALL/ATG10.1.2_200RCN.bin

#######################################
# copy jdbc driver to jboss location
ADD $LOCAL_TOOLS/ojdbc6.jar /appl/jboss-eap-5.1.2/jboss-as/lib/ojdbc6.jar

#######################################
# DONE

ENV AUTHORIZED_KEYS **None**

EXPOSE 22
CMD ["/run.sh"]
