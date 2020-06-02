FROM fedora:27  
LABEL MAINTAINER chrisdower@chrisdower.xyz  
LABEL ConfigurationVersion=2017011100  
  
LABEL RUN="build . -t registry.complexity/fedora-base:latest"  
USER root  
  
RUN echo "deltarpm=0" >> /etc/dnf/dnf.conf \  
&& dnf -y --setopt=tsflags=nodocs update \  
&& dnf -y --setopt=tsflags=nodocs install ssmtp wget curl \  
git tar mariadb iputils iproute file nc procps-ng cronie \  
xz patch redhat-rpm-config findutils compat-openssl10 \  
hostname gnupg2 mailx subversion pigz htop less bind-utils \  
make ssmtp libcurl \  
&& dnf clean all \  
&& chmod -v a+rx /etc/ssmtp  
  
ENV TERM xterm-256color  
  
CMD [ "sleep", "3600"]  

