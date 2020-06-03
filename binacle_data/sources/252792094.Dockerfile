FROM chasedream/vsts-agent:latest  
  
USER root  
  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
RUN apt-get install -y nodejs  
  
RUN \  
npm install -g grunt \  
&& npm install -g mocha \  
&& npm install -g gulp \  
&& npm install -g webpack  
  
WORKDIR /usr/local/vsts-agent  
  
USER vsts  
  
ENV AGENT_FLAVOR=NodeJS  

