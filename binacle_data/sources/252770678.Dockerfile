FROM centos:6  
MAINTAINER <af@maeh.org>  
  
COPY ./MAEH.repo /etc/yum.repos.d/  
  
RUN yum -y update && \  
yum -y install daemontools ucspi-tcp djbdns git && \  
useradd -s /bin/false -c 'TinyDNS User' Gtinydns && \  
useradd -s /bin/false -c 'AxfrDNS User' Gaxfrdns && \  
useradd -s /bin/false -c 'DNS Log User' Gdnslog && \  
tinydns-conf Gtinydns Gdnslog /etc/tinydns 0.0.0.0 && \  
axfrdns-conf Gaxfrdns Gdnslog /etc/axfrdns /etc/tinydns 0.0.0.0 && \  
mkdir /etc/service && \  
ln -s /etc/tinydns /etc/service/tinydns && \  
ln -s /etc/axfrdns /etc/service/axfrdns  
  
ADD ./svscan.sh /svscan.sh  
ADD ./dnsdata_update.sh /dnsdata_update.sh  
  
EXPOSE 53/tcp 53/udp  
  
ENTRYPOINT ["/svscan.sh"]  

