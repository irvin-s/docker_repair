FROM busybox:latest  
  
ADD set-rate-limit.sh /  
  
CMD /set-rate-limit.sh  

