FROM hazelcast/hazelcast:latest  
ADD hazelcast.xml $HZ_HOME  
CMD ./server.sh  

