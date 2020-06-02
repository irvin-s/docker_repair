############################################################  
# Dockerfile to build Data Volume attachable Samba container  
# Based on appcontainers/centos66  
############################################################  
  
# Set the base image to Centos 6.6 Base  
FROM appcontainers/centos66  
  
# File Author / Maintainer  
MAINTAINER Rich Nason richard.na@bbhmedia.com  
  
#*************************  
#* Versions *  
#*************************  
  
  
#**********************************  
#* Override Enabled ENV Variables *  
#**********************************  
ENV SMB_USER samba  
ENV SMB_PASS password  
  
#**************************  
#* Add Required Files *  
#**************************  
ADD smb.conf /tmp/  
ADD runconfig.sh /tmp/  
  
#*************************  
#* Update and Pre-Reqs *  
#*************************  
RUN yum clean all && \  
yum -y update && \  
yum -y install samba4 samba4-client && \  
rm -fr /var/cache/*  
  
  
#*************************  
#* Application Install *  
#*************************  
# Move the Samba Conf file  
RUN mv /etc/samba/smb.conf /etc/samba/smb.conf.orig && \  
mv /tmp/smb.conf /etc/samba/  
  
#************************  
#* Post Deploy Clean Up *  
#************************  
  
  
#**************************  
#* Config Startup Items *  
#**************************  
# Put the services that need to be started into the bashrc file  
RUN echo "service rpcbind start" >> ~/.bashrc && \  
chmod +x /tmp/runconfig.sh && \  
echo "/tmp/./runconfig.sh" >> ~/.bashrc  
  
CMD /bin/bash  
  
  
#****************************  
#* Expose Application Ports *  
#****************************  
# Expose ports to other containers only  
EXPOSE 138/udp  
EXPOSE 139  
EXPOSE 445  
EXPOSE 445/udp  

