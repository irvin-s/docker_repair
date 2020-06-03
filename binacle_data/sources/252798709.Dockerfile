FROM descoped/base  
MAINTAINER Ove Ranheim <oranheim@gmail.com>  
  
ENV GID atlassian  
ENV ATLASSIAN_HOME /var/atlassian-home  
  
ENV MYSQL_DRIVER_VERSION 5.1.41  
RUN DEBIAN_FRONTEND=noninteractive apt-get update  
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y xmlstarlet \  
software-properties-common python-software-properties \  
&& apt-get clean autoclean \  
&& apt-get autoremove --yes \  
&& rm -rf /var/lib/apt/lists/*  
  
ADD common.bash /usr/local/share/atlassian/common.sh  
  
# Add common script functions  
RUN groupadd -r $GID \  
&& chgrp $GID /usr/local/share/atlassian/common.sh \  
&& chmod g+w /usr/local/share/atlassian/common.sh \  
&& mkdir -p $ATLASSIAN_HOME  

