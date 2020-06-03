FROM tutum/centos:centos6
MAINTAINER Eric Stiles <ets04uga@yahoo.com>

#WORKDIR /tmp/

#######################################
#
# folders located outside the container to get necessary dependencies
#
ENV REMOTE_PACKAGES_PATH installables
ENV REMOTE_SCRIPTS_PATH scripts
ENV REMOTE_SUPPORTS_PATH support

# folders for copying dependencies into initially
ENV BASE_CONTAINER_TMP_PATH /tmp/endeca
ENV BASE_CONTAINER_PACKAGES_PATH $BASE_CONTAINER_TMP_PATH/packages

# folders for final installation of endeca programs
ENV BASE_INSTALL_PATH /opt
ENV BASE_ENDECA_PATH $BASE_INSTALL_PATH/endeca
ENV BASE_INSTALL_CUSTOM_SCRIPT_PATH $BASE_ENDECA_PATH/bin

#######################################
# install necessary OS packages
RUN yum -y install openssh-server epel-release && \
    yum -y install openssh-clients && \
    yum -y install wget && \
    yum -y install nc && \
    yum -y install sudo && \
    yum -y install which && \
    yum -y install libaio && \
    yum -y install pwgen && \
    yum -y install glibc.i686 && \
    yum -y install unzip.x86_64 && \
    yum -y install tar && \
    rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM yes/g" /etc/ssh/sshd_config

#######################################
# create directories for copying initial endeca packages
RUN mkdir -p $BASE_CONTAINER_PACKAGES_PATH
RUN chmod -R 755 $BASE_CONTAINER_TMP_PATH

# directory for final install of endeca
RUN mkdir -p $BASE_INSTALL_CUSTOM_SCRIPT_PATH
#RUN chmod 755 /opt/endeca/bin/*.sh

#######################################
# start copying across all endeca packages
#
#OCplatformservices11.1.0-Linux64.bin
ADD $REMOTE_PACKAGES_PATH/V45999-01.zip $BASE_CONTAINER_PACKAGES_PATH/V45999-01.zip

#OCmdex6.5.1-Linux64_829811.sh
ADD $REMOTE_PACKAGES_PATH/V46002-01.zip $BASE_CONTAINER_PACKAGES_PATH/V46002-01.zip

# Tools And Frameworks
ADD $REMOTE_PACKAGES_PATH/V46389-01.zip $BASE_CONTAINER_PACKAGES_PATH/V46389-01.zip

#######################################
# Copy script that creates unique password for root and other scripts
ADD $REMOTE_SCRIPTS_PATH/setupEndecaUser.sh $BASE_CONTAINER_TMP_PATH/setupEndecaUser.sh
RUN chmod +x $BASE_CONTAINER_TMP_PATH/setupEndecaUser.sh

#######################################
# Copy silent install scripts
ADD $REMOTE_SUPPORTS_PATH/platformservices-silent.txt $BASE_CONTAINER_TMP_PATH/platformservices-silent.txt

#######################################
#Run commands to create endeca user and modify sudoers
RUN $BASE_CONTAINER_TMP_PATH/setupEndecaUser.sh

#######################################
# Unzip all packages to get install scripts and files
RUN unzip $BASE_CONTAINER_PACKAGES_PATH/V45999-01.zip -d $BASE_CONTAINER_TMP_PATH
RUN unzip $BASE_CONTAINER_PACKAGES_PATH/V46002-01.zip -d $BASE_CONTAINER_TMP_PATH
RUN unzip $BASE_CONTAINER_PACKAGES_PATH/V46389-01.zip -d $BASE_CONTAINER_TMP_PATH

#######################################
# Set scripts to be executable
RUN chmod +x $BASE_CONTAINER_TMP_PATH/*

#######################################
# Install mdex 6.5.1
RUN $BASE_CONTAINER_TMP_PATH/OCmdex6.5.1-Linux64_829811.sh --silent --target $BASE_INSTALL_PATH

RUN touch /home/endeca/.bashrc
RUN cat $BASE_INSTALL_PATH/endeca/MDEX/6.5.1/mdex_setup_sh.ini >> /home/endeca/.bashrc
RUN source /home/endeca/.bashrc

# Variables needed to install other applications.  List comes from previous mdex_setup_sh.ini script
ENV ENDECA_MDEX_ROOT=/opt/endeca/endeca/MDEX/6.5.1

#######################################
# Install platform services
#
#OCplatformservices11.1.0-Linux64.bin
RUN $BASE_CONTAINER_TMP_PATH/OCplatformservices11.1.0-Linux64.bin --silent --target $BASE_INSTALL_PATH < $BASE_CONTAINER_TMP_PATH/platformservices-silent.txt

RUN cat $BASE_INSTALL_PATH/endeca/PlatformServices/workspace/setup/installer_sh.ini >> /home/endeca/.bashrc
#RUN source /home/endeca/.bashrc

#RUN cat $BASE_INSTALL_PATH/endeca/PlatformServices/workspace/setup/installer_sh.ini

# Variables needed to install other applications.  List comes from previous mdex_setup_sh.ini script
ENV VERSION=11.1.0
ENV BUILD_VERSION=11.1.0.842407
ENV ARCH_OS=x86_64pc-linux
ENV PRODUCT=IAP
ENV ENDECA_INSTALL_BASE=/opt

#  Environment variables required to run the Endeca Platform Services software.
ENV ENDECA_ROOT=/opt/endeca/PlatformServices/11.1.0
ENV PERLLIB=$ENDECA_ROOT/lib/perl:$ENDECA_ROOT/lib/perl/Control:$ENDECA_ROOT/perl/lib:$ENDECA_ROOT/perl/lib/site_perl:$PERLLIB
ENV PERL5LIB=$ENDECA_ROOT/lib/perl:$ENDECA_ROOT/lib/perl/Control:$ENDECA_ROOT/perl/lib:$ENDECA_ROOT/perl/lib/site_perl:$PERL5LIB
ENV ENDECA_CONF=/opt/endeca/PlatformServices/workspace

#  ENDECA_REFERENCE_DIR points to the directory the reference implementations
#  are installed in.  It is not required to run any Oracle Commerce software.
ENV ENDECA_REFERENCE_DIR=/opt/endeca/PlatformServices/reference

#######################################
# install Tools and Frameworks
#
# set prerequisite environment variables.
#ENV ENDECA_TOOLS_ROOT /usr/local/endeca/ToolsAndFrameworks/<version>
#ENV ENDECA_TOOLS_CONF /usr/local/endeca/ToolsAndFrameworks/<version>/server/workspace

#RUN dd if=/dev/zero of=/swapfile bs=1M count=1024
#RUN mkswap /swapfile
#RUN chown root:root /swapfile
#RUN chmod 0600 /swapfile
#RUN swapon /swapfile
#RUN /swapfile    swap    swap   defaults 0 0

#RUN free -m

#RUN chown -R endeca.endeca $ENDECA_INSTALL_BASE


#Tools And Frameworks install
RUN chmod -R 777 $BASE_INSTALL_PATH
USER endeca
RUN $BASE_CONTAINER_TMP_PATH/cd/Disk1/install/silent_install.sh $BASE_CONTAINER_TMP_PATH/cd/Disk1/install/silent_response.rsp ToolsAndFrameworks-ets $BASE_INSTALL_PATH/ToolsAndFrameworks-ets2 admin



#############################################################################


#ADD scripts/setup*.sh /
#ADD scripts/start.sh /appl/endeca/bin/
#ADD scripts/shutdown.sh /appl/endeca/bin/
#ADD scripts/captureEndecaLogs.sh /appl/endeca/bin/
#ADD scripts/installDiscoverApp.sh /appl/endeca/bin/

#######################################
# Set properties for scripts to be executable
#RUN chmod +x /*.sh
#RUN chmos +x /appl/endeca/bin/





#text file used for silent install of platform services
#ADD tools/platformservices-silent.txt /tmp/endeca/platformservices-silent.txt

#cas-3.1.1-x86_64pc-linux.sh
#ADD tools/V35739-01.zip /tmp/endeca/packages/V35739-01.zip

#text file used or silent install of platform services
#ADD tools/cas-silent.txt /tmp/endeca/cas-silent.txt

#gs_3.1.1.6904_linux.zip 
#ADD tools/V35740-01.zip /tmp/endeca/packages/V35740-01.zip

#mdex_6.4.0.692722_x86_64pc-linux.sh
#presAPI_6.4.0.692722_x86_64pc-linux.tgz
#ADD tools/V35742-01.zip /tmp/endeca/packages/V35742-01.zip

#xmgr_3.1.1.6904_linux.zip 
#ADD tools/V35744-01.zip /tmp/endeca/packages/V35744-01.zip

#relevancy ranking tool
#ADD tools/V31171-01.zip /tmp/endeca/packages/V31171-01.zip

#######################################
# Unzip all packages to get install scripts and files
#RUN unzip /tmp/endeca/packages/V45999-01.zip -d /tmp/endeca
#RUN unzip /tmp/endeca/packages/V35739-01.zip -d /tmp/endeca
#RUN unzip /tmp/endeca/packages/V35740-01.zip -d /tmp/endeca
#RUN unzip /tmp/endeca/packages/V35742-01.zip -d /tmp/endeca
#RUN unzip /tmp/endeca/packages/V35744-01.zip -d /tmp/endeca
#RUN unzip /tmp/endeca/packages/V31171-01.zip -d /tmp/endeca

# set permissions of scripts to run
#RUN chmod +x /tmp/**/*.sh

#######################################
# install mdex
#RUN /tmp/endeca/mdex_6.4.0.692722_x86_64pc-linux.sh --target /appl

# copy mdex environment variables to .bashrc
#RUN /setup2.sh

# set mdex environment variables for rest of install
#ENV ENDECA_MDEX_ROOT=/appl/endeca/MDEX/6.4.0
#ENV PATH=$ENDECA_MDEX_ROOT/bin:$PATH

#######################################
# install platform services
#RUN /tmp/endeca/platformservices_613654721_x86_64pc-linux.sh --silent --target /appl < /tmp/endeca/platformservices-silent.txt

# copy platform services environment variables to .bashrc
#RUN /setup3.sh

# set platform services variables for rest of install
#ENV VERSION=6.1.3
#ENV BUILD_VERSION=6.1.3.654721
#ENV ARCH_OS=x86_64pc-linux
#ENV PRODUCT=IAP
#ENV ENDECA_INSTALL_BASE=/appl
#ENV ENDECA_ROOT=/appl/endeca/PlatformServices/6.1.3
#ENV PERLLIB=$ENDECA_ROOT/lib/perl:$ENDECA_ROOT/lib/perl/Control:$ENDECA_ROOT/perl/lib:$ENDECA_ROOT/perl/lib/site_perl:$PERLLIB
#ENV PERL5LIB=$ENDECA_ROOT/lib/perl:$ENDECA_ROOT/lib/perl/Control:$ENDECA_ROOT/perl/lib:$ENDECA_ROOT/perl/lib/site_perl:$PERL5LIB
#ENV PATH=$ENDECA_ROOT/bin:$ENDECA_ROOT/perl/bin:$ENDECA_ROOT/utilities:$PATH
#ENV ENDECA_CONF=/appl/endeca/PlatformServices/workspace

#  ENDECA_REFERENCE_DIR points to the directory the reference implementations
#  are installed in.  It is not required to run any Endeca software.
#ENV ENDECA_REFERENCE_DIR=/appl/endeca/PlatformServices/reference

#######################################
# install Tools and Frameworks
#
# unip ToolsAndFrameworks
#RUN unzip /tmp/endeca/xmgr_3.1.1.6904_linux.zip -d /appl/endeca/

# copy tools and frameworks environment variables to .bashrc
#RUN /setup4.sh

# set tools and frameworks variables for rest of install
#ENV ENDECA_TOOLS_ROOT=/appl/endeca/ToolsAndFrameworks/3.1.1/
#ENV ENDECA_TOOLS_CONF=/appl/endeca/ToolsAndFrameworks/3.1.1/server/workspace
#echo 'ENDECA_TOOLS_ROOT=/appl/endeca/ToolsAndFrameworks/3.1.1/' >> /home/endeca/.bashrc
#echo 'ENDECA_TOOLS_CONF=/appl/endeca/ToolsAndFrameworks/3.1.1/server/workspace' >> /home/endeca/.bashrc

#######################################
# install CAS
#RUN /tmp/endeca/cas-3.1.1-x86_64pc-linux.sh --silent --target /appl < /tmp/endeca/cas-silent.txt

#######################################
# install relevancy evaluator
#RUN mv /tmp/endeca/Endeca/Solutions /appl/endeca

#RUN cp /appl/endeca/ToolsAndFrameworks/3.1.1/assembler/lib/endeca_navigation-6.4.0.jar /appl/endeca/Solutions/relrankEvaluator-2.1.2/relrankEvaluator/WEB-INF/lib/endeca_navigation.jar

# write context into relrankEvaluator.xml file
#RUN /setup5.sh

# place correct extensions file
#ADD tools/ws-extensions.xml /appl/endeca/ToolsAndFrameworks/3.1.1/server/workspace/conf/ws-extensions.xml

# place correct menu items
#ADD tools/ws-mainMenu.xml /appl/endeca/ToolsAndFrameworks/3.1.1/server/workspace/conf/ws-mainMenu.xml

#######################################
# create apps directory
#RUN mkdir /appl/endeca/apps

#######################################
# set user and permissions to endeca
#RUN chown -R endeca.endeca /appl/endeca/

#######################################
# install is done start cleanup to remove initial packages
#RUN rm -rf /tmp/endeca
##RUN rm setup*.sh

#RUN printenv

#ENV AUTHORIZED_KEYS **None**

#EXPOSE 22
USER root
CMD ["/run.sh"]
