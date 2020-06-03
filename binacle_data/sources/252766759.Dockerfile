FROM centos:7  
# This is a centos 7 workstation that can be deployed in cloud environments  
# for troublesoohting  
# Add the following repo :  
# Install the following commands : ss ip nmap  
RUN mkdir /build  
ADD ./files-build/ /build/  
RUN chmod --recursive go-rwx /build  
RUN yum install -y epel-release  
RUN /bin/bash /build/prepare  
RUN yum update  
  
# keep your container alive until stop is sent. Using trap and  
# wait will make your container react immediately.  
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"  

