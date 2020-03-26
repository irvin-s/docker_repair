FROM debian:jessie  
MAINTAINER Daniel Guerra  
RUN apt-get -yy update  
RUN apt-get -yy install curl debootstrap  
ADD build-kali.sh /bin/build-kali.sh  
RUN chmod a+x /bin/build-kali.sh  
VOLUME ["/mnt"]  
CMD /bin/build-kali.sh  

