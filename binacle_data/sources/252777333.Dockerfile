FROM ubuntu:14.04  
MAINTAINER "Claus Strasburger <c@cfs.im>"  
ENV DEBIAN_FRONTEND noninteractive  
  
# defaults for debify  
ENV APTLY_DISTRIBUTION testing  
ENV APTLY_COMPONENT main  
ENV KEYSERVER keyserver.ubuntu.com  
  
ENV GNUPGHOME /.gnupg  
  
# install aptly  
RUN echo deb http://repo.aptly.info/ squeeze main >> /etc/apt/sources.list  
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 9E3E53F19C7DE460  
RUN apt-get update && \  
apt-get install -y aptly && \  
apt-get clean  
  
ADD debify.sh /debify.sh  
ADD entrypoint.sh /entrypoint.sh  
ADD aptly.conf /root/.aptly.conf  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["/debify.sh"]  

