FROM garland/aws-cli-docker:latest  
  
# Install the entrypoint script  
COPY docker-entrypoint.sh /docker-entrypoint.sh  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["sync"]  
  

