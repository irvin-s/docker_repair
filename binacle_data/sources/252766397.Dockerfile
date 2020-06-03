FROM debian:jessie  
  
MAINTAINER anders@brander.dk  
  
COPY agento_0.0-20161108-1411-37b060e_amd64.deb /  
RUN dpkg -i /agento_0.0-20161108-1411-37b060e_amd64.deb \  
&& rm /agento_0.0-20161108-1411-37b060e_amd64.deb  
  
RUN mkdir -p /var/lib/agento/  
  
VOLUME ["/host/proc", "/host/sys"]  
  
ENV AGENTO_PROC_PATH /host/proc  
ENV AGENTO_SYSFS_PATH /host/sys  
  
ENTRYPOINT ["/usr/sbin/agento"]  

