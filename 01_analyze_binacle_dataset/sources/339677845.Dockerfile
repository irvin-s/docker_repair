FROM tutum/centos:centos5
MAINTAINER Eric Stiles <ets04uga@yahoo.com>

#######################################
# install necessary OS packages
RUN yum -y install which && \
    yum -y install libaio && \
    yum -y install glibc.i686 && \
    yum -y install sudo && \
    yum -y install unzip.x86_64

#######################################
# environment variables
#
# environment variable for local location
ENV LOCAL_SCRIPTS scripts
ENV LOCAL_TOOLS tools

# environment variables for installables
ENV BASE_TMP_INSTALL /tmp
ENV BASE_TMP_ENDECA_INSTALL $BASE_TMP_INSTALL/endeca
ENV BASE_TMP_PACKAGE_INSTALL $BASE_TMP_ENDECA_INSTALL/packages

# environment variables for endeca location
ENV BASE_DIR /appl
ENV BASE_ENDECA_DIR $BASE_DIR/endeca
ENV SCRIPT_DIR $BASE_DIR/bin

#######################################
# create directories for copying initial endeca packages
RUN mkdir -p $BASE_TMP_PACKAGE_INSTALL
RUN chmod -R 777 $BASE_TMP_ENDECA_INSTALL

# directory for final install of endeca created as part of script directory
RUN mkdir -p $SCRIPT_DIR
RUN chmod -R 755 $BASE_DIR


#######################################
# Copy script that creates unique password for root and other scripts
ADD $LOCAL_SCRIPTS/modsudoers.sh /
ADD $LOCAL_SCRIPTS/setup*.sh /
ADD $LOCAL_SCRIPTS/start.sh $SCRIPT_DIR/
ADD $LOCAL_SCRIPTS/shutdown.sh $SCRIPT_DIR/
ADD $LOCAL_SCRIPTS/captureEndecaLogs.sh $SCRIPT_DIR/
ADD $LOCAL_SCRIPTS/installDiscoverApp.sh $SCRIPT_DIR/

#######################################
# Set properties for scripts to be executable
RUN chmod +x /*.sh
RUN chmod +x $SCRIPT_DIR

#######################################
#Run commands to create endeca user and modify sudoers
RUN /setup.sh

#######################################
# start copying across all endeca packages
#
#mdex_6.4.0.692722_x86_64pc-linux.sh
#presAPI_6.4.0.692722_x86_64pc-linux.tgz
ADD $LOCAL_TOOLS/V35742-01.zip $BASE_TMP_PACKAGE_INSTALL/V35742-01.zip

#platformservices_613654721_x86_64pc-linux.sh
ADD $LOCAL_TOOLS/V33316-01.zip $BASE_TMP_PACKAGE_INSTALL/V33316-01.zip

#text file used for silent install of platform services
ADD $LOCAL_TOOLS/platformservices-silent.txt $BASE_TMP_ENDECA_INSTALL/platformservices-silent.txt

#cas-3.1.1-x86_64pc-linux.sh
ADD $LOCAL_TOOLS/V35739-01.zip $BASE_TMP_PACKAGE_INSTALL/V35739-01.zip

#text file used or silent install of platform services
ADD $LOCAL_TOOLS/cas-silent.txt $BASE_TMP_ENDECA_INSTALL/cas-silent.txt

#gs_3.1.1.6904_linux.zip 
ADD $LOCAL_TOOLS/V35740-01.zip $BASE_TMP_PACKAGE_INSTALL/V35740-01.zip

#xmgr_3.1.1.6904_linux.zip 
ADD $LOCAL_TOOLS/V35744-01.zip $BASE_TMP_PACKAGE_INSTALL/V35744-01.zip

#relevancy ranking tool
ADD $LOCAL_TOOLS/V31171-01.zip $BASE_TMP_PACKAGE_INSTALL/V31171-01.zip

#######################################
# Unzip all packages to get install scripts and files
RUN unzip $BASE_TMP_PACKAGE_INSTALL/V33316-01.zip -d $BASE_TMP_ENDECA_INSTALL
RUN unzip $BASE_TMP_PACKAGE_INSTALL/V35739-01.zip -d $BASE_TMP_ENDECA_INSTALL
RUN unzip $BASE_TMP_PACKAGE_INSTALL/V35740-01.zip -d $BASE_TMP_ENDECA_INSTALL
RUN unzip $BASE_TMP_PACKAGE_INSTALL/V35742-01.zip -d $BASE_TMP_ENDECA_INSTALL
RUN unzip $BASE_TMP_PACKAGE_INSTALL/V35744-01.zip -d $BASE_TMP_ENDECA_INSTALL
RUN unzip $BASE_TMP_PACKAGE_INSTALL/V31171-01.zip -d $BASE_TMP_ENDECA_INSTALL

# set permissions of scripts to run
RUN chmod +x $BASE_TMP_INSTALL/**/*.sh

#######################################
# install mdex
RUN $BASE_TMP_ENDECA_INSTALL/mdex_6.4.0.692722_x86_64pc-linux.sh --target $BASE_DIR

# copy mdex environment variables to .bashrc
RUN /setup2.sh

# set mdex environment variables for rest of install
ENV ENDECA_MDEX_ROOT $BASE_ENDECA_DIR/MDEX/6.4.0
ENV PATH $ENDECA_MDEX_ROOT/bin:$PATH

#######################################
# install platform services
RUN $BASE_TMP_ENDECA_INSTALL/platformservices_613654721_x86_64pc-linux.sh --silent --target $BASE_DIR < $BASE_TMP_ENDECA_INSTALL/platformservices-silent.txt

# copy platform services environment variables to .bashrc
RUN /setup3.sh

# set platform services variables for rest of install
ENV VERSION 6.1.3
ENV BUILD_VERSION 6.1.3.654721
ENV ARCH_OS x86_64pc-linux
ENV PRODUCT IAP
ENV ENDECA_INSTALL_BASE /appl
ENV ENDECA_ROOT $BASE_ENDECA_DIR/PlatformServices/6.1.3
ENV PERLLIB $ENDECA_ROOT/lib/perl:$ENDECA_ROOT/lib/perl/Control:$ENDECA_ROOT/perl/lib:$ENDECA_ROOT/perl/lib/site_perl:$PERLLIB
ENV PERL5LIB $ENDECA_ROOT/lib/perl:$ENDECA_ROOT/lib/perl/Control:$ENDECA_ROOT/perl/lib:$ENDECA_ROOT/perl/lib/site_perl:$PERL5LIB
ENV PATH $ENDECA_ROOT/bin:$ENDECA_ROOT/perl/bin:$ENDECA_ROOT/utilities:$PATH
ENV ENDECA_CONF $BASE_ENDECA_DIR/PlatformServices/workspace

#  ENDECA_REFERENCE_DIR points to the directory the reference implementations
#  are installed in.  It is not required to run any Endeca software.
ENV ENDECA_REFERENCE_DIR $BASE_ENDECA_DIR/PlatformServices/reference

#######################################
# install Tools and Frameworks
#
# unip ToolsAndFrameworks
RUN unzip $BASE_TMP_ENDECA_INSTALL/xmgr_3.1.1.6904_linux.zip -d $BASE_ENDECA_DIR

# copy tools and frameworks environment variables to .bashrc
RUN /setup4.sh

# set tools and frameworks variables for rest of install
ENV ENDECA_TOOLS_ROOT $BASE_ENDECA_DIR/ToolsAndFrameworks/3.1.1/
ENV ENDECA_TOOLS_CONF $BASE_ENDECA_DIR/ToolsAndFrameworks/3.1.1/server/workspace

#######################################
# install CAS
RUN $BASE_TMP_ENDECA_INSTALL/cas-3.1.1-x86_64pc-linux.sh --silent --target $BASE_DIR < $BASE_TMP_ENDECA_INSTALL/cas-silent.txt

#######################################
# install relevancy evaluator
RUN mv /tmp/endeca/Endeca/Solutions $BASE_ENDECA_DIR

RUN cp $BASE_ENDECA_DIR/ToolsAndFrameworks/3.1.1/assembler/lib/endeca_navigation-6.4.0.jar $BASE_ENDECA_DIR/Solutions/relrankEvaluator-2.1.2/relrankEvaluator/WEB-INF/lib/endeca_navigation.jar

# write context into relrankEvaluator.xml file
RUN /setup5.sh

# place correct extensions file
ADD tools/ws-extensions.xml $BASE_ENDECA_DIR/ToolsAndFrameworks/3.1.1/server/workspace/conf/ws-extensions.xml

# place correct menu items
ADD tools/ws-mainMenu.xml $BASE_ENDECA_DIR/ToolsAndFrameworks/3.1.1/server/workspace/conf/ws-mainMenu.xml

#######################################
# create apps directory
RUN mkdir $BASE_ENDECA_DIR/apps

#######################################
# set user and permissions to endeca
RUN chown -R endeca.endeca $BASE_ENDECA_DIR/

#######################################
# install is done start cleanup to remove initial packages
RUN rm -rf $BASE_TMP_ENDECA_INSTALL
RUN rm setup*.sh

EXPOSE 22
EXPOSE 8500
EXPOSE 8888
CMD ["/run.sh"]
