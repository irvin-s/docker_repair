FROM elixir:1.6.1  
# Install system dependencies  
RUN apt-get update \  
&& apt-get install -y apt-transport-https \  
lsb-release \  
curl  
  
# Install Node  
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -  
RUN apt-get update -qy \  
&& apt-get install -y nodejs  
  
# Install app dependencies  
RUN mix local.hex --force  
RUN mix local.rebar --force  
RUN npm i -g yarn  
  
# Install Heroku  
RUN wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh  

