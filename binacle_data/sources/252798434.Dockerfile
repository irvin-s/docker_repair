FROM ubuntu:16.04  
RUN apt-get update  
  
RUN apt-get install curl -y  
  
RUN cd ~ && ls  
  
RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh  
  
RUN bash nodesource_setup.sh && apt-get install nodejs -y  
  
RUN apt-get install -y git git-core  
  
ADD start.sh /tmp/  
  
RUN chmod +x /tmp/start.sh  
  
CMD ./tmp/start.sh  
  

