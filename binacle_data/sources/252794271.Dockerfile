FROM ubuntu-upstart:14.04  
  
### Update and customize ubuntu packages.  
RUN apt-get update ;\  
apt-get -y upgrade  
RUN apt-get -y purge openssh-server openssh-client ;\  
apt-get -y autoremove  
RUN apt-get -y install vim nano aptitude wget bzip2 bash-completion git ccache  
RUN apt-get -y build-dep libreoffice  
  
### Make some additional system configurations.  
COPY . /tmp/config/  
RUN /tmp/config/sysconfig.sh  
RUN rm -rf /tmp/config/  
  

