FROM elasticsearch:5.3  
MAINTAINER akitanak  
  
RUN bin/elasticsearch-plugin install analysis-kuromoji  

