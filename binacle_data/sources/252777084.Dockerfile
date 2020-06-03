FROM node:4.4.3  
  
RUN apt-get update \  
&& apt-get install -y ruby sudo \  
&& gem install dpl heroku-api rendezvous \  
&& wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh \  
&& heroku --version \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  

