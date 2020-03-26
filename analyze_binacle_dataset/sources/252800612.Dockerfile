FROM jenkins:2.46.3  
  
USER root  
  
RUN apt-get update \  
&& apt-get install git-flow \  
&& ln -s /usr/lib/git-core/git-flow /usr/bin/git-flow  
  
USER jenkins  
  

