FROM ubuntu  
MAINTAINER Christian Lück <christian@lueck.tv>  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \  
git curl  
  
RUN git clone https://github.com/hodgesmr/FindGitHubEmail.git  
  
WORKDIR FindGitHubEmail  
  
ENTRYPOINT ["bash", "findGitHubEmail"]  

