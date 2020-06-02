FROM cockroachdb/cockroach  
  
ADD run.sh /run.sh  
  
ENTRYPOINT ["/run.sh"]  

