FROM node  
  
RUN apt-get update  
RUN apt-get install libgnome-keyring-dev -y  
  
RUN npm install -g semantic-release-cli  
  
ENTRYPOINT /bin/bash  

