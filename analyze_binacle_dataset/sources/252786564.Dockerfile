FROM ubuntu:14.04  
MAINTAINER K.G.R Vamsi <kgrvamsi@yahoo.com>  
  
RUN apt-get update && \  
apt-get -y install git curl build-essential runit && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/  
  
ADD hyperkube /opt/  
  
ADD envvars /opt/envvars  
  
ADD apiserver/* /etc/service/apiserver/  
  
ADD controller-manager/* /etc/service/controller-manager/  
  
ADD scheduler/* /etc/service/scheduler/  
  
ADD etcdserver.sh /opt/etcdserver.sh  
  
RUN chmod 777 /opt/etcdserver.sh  
  
USER root  
  
ENTRYPOINT ["/opt/etcdserver.sh"]  

