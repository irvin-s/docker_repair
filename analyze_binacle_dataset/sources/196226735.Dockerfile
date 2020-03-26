############################################################################
# (C) Copyright IBM Corporation 2015.                                      #
#                                                                          #
# Licensed under the Apache License, Version 2.0 (the "License");          #
# you may not use this file except in compliance with the License.         #
# You may obtain a copy of the License at                                  #
#                                                                          #
#      http://www.apache.org/licenses/LICENSE-2.0                          #
#                                                                          #
# Unless required by applicable law or agreed to in writing, software      #
# distributed under the License is distributed on an "AS IS" BASIS,        #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. #
# See the License for the specific language governing permissions and      #
# limitations under the License.                                           #
#                                                                          #
############################################################################

FROM ubuntu:16.04

MAINTAINER Kavitha Suresh Kumar <kavisuresh@in.ibm.com>

RUN apt-get update && apt-get install -y  unzip wget

ARG URL

########################### Installation Manager #########################

# Install Installation Manager
RUN wget -q $URL/agent.installer.lnx.gtk.x86_64_1.8.5.zip -O /tmp/IM.zip \
    && mkdir /tmp/im &&  unzip -qd /tmp/im /tmp/IM.zip \
    && /tmp/im/installc -acceptLicense -accessRights admin \
      -installationDirectory "/opt/IBM/InstallationManager"  \
      -dataLocation "/var/ibm/InstallationManager" -showProgress \
    && rm -fr /tmp/IM.zip /tmp/im

########################### IBM HTTP Server ################################

# Install IBM HTTP Server
RUN mkdir /tmp/ihs \
    && wget -q $URL/was.repo.9000.ihs.zip -O /tmp/ihs.zip  \
    && wget -q $URL/sdk.repo.8030.java8.hpux.zip  -O /tmp/java.zip  \
    && unzip  -qd /tmp/ihs /tmp/ihs.zip \
    && unzip  -qd /tmp/java /tmp/java.zip \
    && rm /tmp/ihs.zip /tmp/java.zip  \
    && /opt/IBM/InstallationManager/eclipse/tools/imcl -showProgress  \
     -acceptLicense  install com.ibm.websphere.IHS.v90 com.ibm.java.jdk.v8  \
     -repositories /tmp/ihs/repository.config,/tmp/java/repository.config  \
     -installationDirectory /opt/IBM/HTTPServer  \
     -properties "user.ihs.httpPort=80,user.ihs.allowNonRootSilentInstall=true"  \
   && rm -fr /tmp/ihs /tmp/java

######################### WebServer Plugins  ##################################

# Install WebServer Plugins
RUN mkdir /tmp/plg  \
    && wget -q $URL/was.repo.9000.plugins.zip -O /tmp/plg.zip  \
    && wget -q $URL/sdk.repo.8030.java8.hpux.zip  -O /tmp/java.zip  \
    && unzip  -qd /tmp/plg /tmp/plg.zip  \
    && unzip  -qd /tmp/java /tmp/java.zip  \
    && rm /tmp/plg.zip /tmp/java.zip  \
    && /opt/IBM/InstallationManager/eclipse/tools/imcl -showProgress   \
     -acceptLicense  install com.ibm.websphere.PLG.v90 com.ibm.java.jdk.v8   \
     -repositories /tmp/plg/repository.config,/tmp/java/repository.config   \
     -installationDirectory /opt/IBM/WebSphere/Plugins  \
    && rm -fr /tmp/plg /tmp/java /opt/IBM/WebSphere/Plugins/java

####################### WebSphere Customization Tools #######################

# Install WebSphere Customization Tools
RUN mkdir /tmp/wct  \
    && wget -q $URL/was.repo.9000.wct.zip -O /tmp/wct.zip  \
    && wget -q $URL/sdk.repo.8030.java8.hpux.zip  -O /tmp/java.zip  \
    && unzip  -qd /tmp/wct /tmp/wct.zip  \
    && unzip  -qd /tmp/java /tmp/java.zip  \
    && rm /tmp/wct.zip  /tmp/java.zip  \
    && /opt/IBM/InstallationManager/eclipse/tools/imcl -showProgress   \
     -acceptLicense  install com.ibm.websphere.WCT.v90 com.ibm.java.jdk.v8   \
     -repositories /tmp/wct/repository.config,/tmp/java/repository.config   \
     -installationDirectory /opt/IBM/WebSphere/Toolbox  \
    && rm -fr /tmp/wct /tmp/java /opt/IBM/WebSphere/Toolbox/java

                                  
CMD ["tar","cvf","/tmp/ihs_plg_wct.tar","/opt/IBM/HTTPServer","/opt/IBM/WebSphere/Plugins","/opt/IBM/WebSphere/Toolbox"]
