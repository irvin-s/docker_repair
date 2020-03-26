FROM node:8  
RUN apt-get update \  
&& apt-get install -y ruby-dev rubygems \  
&& gem update \  
&& gem install sass \  
&& apt-get clean && apt-get purge  

