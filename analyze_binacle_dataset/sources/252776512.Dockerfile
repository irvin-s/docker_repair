FROM boritzio/docker-base-java  
  
RUN apt-get update && apt-get install -y zookeeper=3.4.* \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ADD zoo.cfg /tmp/zoo.cfg  
ADD jaas.conf /tmp/jaas.conf  
  
EXPOSE 2181 2888 3888  
VOLUME ["/data", "/data-log" , "/secrets"]  
  
ADD setup.sh /etc/my_init.d/zookeeper.sh  
  

