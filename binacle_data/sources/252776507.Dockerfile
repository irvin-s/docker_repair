FROM boritzio/docker-mesosphere-base  
  
RUN apt-get install -y chronos  
  
ADD start_chronos.sh /etc/my_init.d/chronos.sh  

