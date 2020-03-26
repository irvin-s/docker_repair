FROM elcolio/etcd  
  
ADD ./pit-start.sh /  
RUN chmod +x /pit-start.sh

