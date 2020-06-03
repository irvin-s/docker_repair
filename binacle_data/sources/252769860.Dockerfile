FROM jenkinsci/slave  
  
USER root  
  
RUN apt-get update && apt-get install -y ant ruby  
  
RUN gem install bundler  
  
RUN apt-get update && apt-get install -y docker  
  
USER jenkins  

