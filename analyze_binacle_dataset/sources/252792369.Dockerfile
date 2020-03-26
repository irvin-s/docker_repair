# Ubuntu 14 64-bit support for 32-bit library is cumbersome  
FROM centos:6  
MAINTAINER Cheewai Lai <clai@csir.co.za>  
  
# Set timezone  
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime  
  
# Actual DRL-IPOPP requirements begins after tar  
RUN yum -y install epel-release && \  
yum update -y && \  
yum install -y \  
curl \  
ftp \  
less \  
vim-minimal \  
wget \  
rsync \  
rsyslog \  
sudo \  
unzip \  
tar \  
libxp6 \  
libXext \  
libXrender \  
libXtst \  
libjvm \  
tcsh \  
bc \  
libaio \  
jemalloc \  
perl \  
file \  
ed && \  
yum clean all  
  
ADD start.sh /start.sh  
RUN chmod 755 /start.sh \  
&& chown root.root /start.sh  
ENTRYPOINT ["/start.sh"]  

