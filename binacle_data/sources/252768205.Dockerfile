FROM jenkins/jenkins  
  
USER root  
  
RUN apt update \  
&& apt install -y graphviz  
  
USER jenkins  

