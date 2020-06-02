FROM debian:stable  
MAINTAINER Bogdan Mustiata <bogdan.mustiata@gmail.com> github.com/bmst @bmst  
  
# gettext for envsubst  
RUN apt-get update && \  
apt-get -o "Acquire::Retries=10" install -yq samba gettext  
  
ENV STATIC_IP ""  
ADD run.sh /run.sh  
ADD setup-samba-share.sh /setup-samba-share.sh  
ADD samba-share.sh /samba-share.sh  
  
ENTRYPOINT ["/run.sh"]  
  

