#Based on the default node image  
FROM couchbase/server  
  
ADD image_bootstrap.sh .  
ADD couchbase_cluster.sh .  
  
CMD ["./image_bootstrap.sh", "./couchbase_cluster.sh"]  

