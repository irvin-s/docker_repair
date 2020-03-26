FROM boritzio/docker-mesosphere-base:v1.1.0  
EXPOSE 5050  
VOLUME ["/config"]  
  
ADD start.sh /etc/my_init.d/mesos-master.sh  

