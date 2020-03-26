FROM jenkins/jnlp-slave:latest  
  
USER root  
RUN apt-get update && apt-get install -y graphviz ghostscript  
USER jenkins  

