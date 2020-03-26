FROM lmenezes/elasticsearch-kopf  
  
ADD run.sh /tmp/run.sh  
  
ENTRYPOINT ["/tmp/run.sh"]  

