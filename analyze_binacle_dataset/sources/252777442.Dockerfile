FROM debian  
  
RUN apt-get update -qq  
RUN apt-get install -yq \  
wget \  
curl \  
sudo \  
ruby  
  
RUN wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh  

