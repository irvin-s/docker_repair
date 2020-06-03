FROM debian:stretch  
MAINTAINER "Alan Kent"  
# Install some utilities  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y ocaml sudo supervisor  
  
# Create magento2 user  
ADD create-magento2-user.sh /tmp  
RUN chmod 755 /tmp/create-magento2-user.sh \  
&& bash -x /tmp/create-magento2-user.sh  
  
# SSH  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server \  
&& mkdir /var/run/sshd  
COPY sshd_config /etc/ssh/sshd_config  
  
# Unison  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y make curl unzip  
ADD unison-install.sh /tmp  
RUN chmod 755 /tmp/unison-install.sh \  
&& bash -x /tmp/unison-install.sh  
  
# Service manager  
ADD supervisord.conf /etc  
  
# Entrypoint.  
ADD entrypoint.sh /  
RUN chmod 755 /entrypoint.sh  
  
EXPOSE 22  
EXPOSE 5000  
ENTRYPOINT [ "/entrypoint.sh" ]  

