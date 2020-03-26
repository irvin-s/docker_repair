#rename to Dockerfile when building
FROM windowsservercore


ENV vso_username="user" 
ENV vso_password="password" 
ENV vso_url="https://server.visualstudio.com" 
ENV vso_agentname=$COMPUTERNAME 
ENV vso_agentpool=default 

COPY . /agent
WORKDIR /agent


