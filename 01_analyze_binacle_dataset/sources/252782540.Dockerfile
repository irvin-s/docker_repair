FROM nginx:latest  
  
ADD start.sh /  
ADD clarify-search-proxy.conf /  
  
ENV CLARIFY_API_KEY docs-api-key  
  
CMD ["/start.sh"]  
  

