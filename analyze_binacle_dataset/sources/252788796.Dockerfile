FROM couchbase  
  
COPY ./files/configure-node.sh /opt/couchbase  
  
CMD ["/opt/couchbase/configure-node.sh"]  

