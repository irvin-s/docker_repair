FROM hopsoft/graphite-statsd  
  
RUN apt-get -y update \  
&& apt-get -y install nfs-common \  
&& mkdir /efs \  
&& mv /opt /original-opt \  
&& ln -sf /efs/opt /opt  
  
ADD entrypoint.sh /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  

