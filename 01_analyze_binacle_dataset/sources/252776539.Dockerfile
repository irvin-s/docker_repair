FROM docker:latest  
  
ADD reset_agent.sh /usr/local/bin/  
  
CMD ["reset_agent.sh"]  

