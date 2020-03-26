FROM elasticsearch  
MAINTAINER dev@chialab.it  
  
RUN elasticsearch-plugin install x-pack  

