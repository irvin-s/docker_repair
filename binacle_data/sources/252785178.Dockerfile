# Hbase  
#  
# VERSION 20160613_1  
FROM cogfor/jdk-oracle:latest  
  
MAINTAINER Rene Nederhand <rene@cogfor.com>  
  
# Set correct environment variables.  
ENV HOME /root  
ENV DEBIAN_FRONTEND noninteractive  
  
# Regenerate SSH host keys. baseimage-docker does not contain any, so you  
# have to do that yourself. You may also comment out this instruction; the  
# init system will auto-generate one during boot.  
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh  
  
# Use baseimage-docker's init system.  
CMD ["/sbin/my_init"]  
  
RUN mkdir /hbase-setup  
WORKDIR /hbase-setup  
  
# Hbase installation  
ADD ./install-hbase.sh /hbase-setup/  
RUN ./install-hbase.sh  
  
# Configure Hbase  
RUN /opt/hbase/bin/hbase-config.sh  
ADD hbase-site.xml /opt/hbase/conf/hbase-site.xml  
  
# Create Hbase service  
RUN mkdir /etc/service/hbase  
COPY start-pseudo-distributed.sh /etc/service/hbase/run  
RUN chmod +x /etc/service/hbase/run  
  
# zookeeper  
EXPOSE 2181  
# HBase Master API port  
EXPOSE 60000  
# HBase Master Web UI  
EXPOSE 60010  
# Regionserver API port  
EXPOSE 60020  
# HBase Regionserver web UI  
EXPOSE 60030  
WORKDIR /opt/hbase/bin  
  
ENV PATH=$PATH:/opt/hbase/bin  
  

