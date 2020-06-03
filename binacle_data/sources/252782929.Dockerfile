FROM mongo  
  
ADD mongo_replicate.sh .  
  
CMD ["./mongo_replicate.sh"]  

