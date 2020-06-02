FROM colstrom/alpine  
  
RUN package install jq  
  
ENTRYPOINT ["jq"]  
CMD ["-h"]  

