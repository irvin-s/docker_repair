FROM mongo:3.2.10  
COPY start-replication.sh /tmp/start-replication.sh  
CMD /tmp/start-replication.sh $REPLICAS_NUMBER $REPLICASET_NAME $NODE_PREFIX  

