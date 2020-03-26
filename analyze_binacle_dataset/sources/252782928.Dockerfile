FROM elasticsearch  
  
ADD es_cluster.sh .  
  
CMD ["./es_cluster.sh"]  

