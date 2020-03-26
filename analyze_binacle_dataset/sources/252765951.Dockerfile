FROM elasticsearch:1.7  
# Install gui plugin  
RUN plugin --install mobz/elasticsearch-head  
  

