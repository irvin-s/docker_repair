FROM centos:7  
  
MAINTAINER linuxer (at) quantentunnel.de  
  
RUN yum install -y epel-release \  
&& yum install -y \  
bc \  
bison \  
bzip2 \  
dialog \  
file \  
flex \  
gcc \  
gcc-c++ \  
gettext \  
gettext-devel \  
joe \  
less \  
make \  
ncurses-devel \  
openssh-server \  
patch \  
quilt \  
screen \  
texinfo \  
wget \  
which \  
&& yum clean all  
  
CMD /bin/bash  
  

