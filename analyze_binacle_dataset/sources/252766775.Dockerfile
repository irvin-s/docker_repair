FROM ubuntu  
  
RUN apt-get update && apt-get install -y curl wget gettext jq netcat  
  
RUN apt-get install sudo  

