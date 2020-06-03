#Based on the default node image  
FROM mongo  
  
ADD image_bootstrap.sh .  
ADD mongo_replicate.sh .  
  
CMD ["./image_bootstrap.sh", "./mongo_replicate.sh"]  

