FROM ubuntu  
  
MAINTAINER aspgems  
  
RUN apt-get update && apt-get install -y git git-core  
  
RUN mkdir /root/.ssh && echo "StrictHostKeyChecking no" > /root/.ssh/config  
  
RUN mkdir /repo  
WORKDIR /repo  
  
ENTRYPOINT ["git"]  
  

