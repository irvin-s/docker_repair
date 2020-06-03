FROM ubuntu:trusty  
  
RUN apt-get update \  
&& apt-get install -y curl \  
&& apt-get install -y git \  
&& curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash - \  
&& apt-get install -y nodejs \  
&& npm install -g grunt-cli \  
&& npm install -g bower  
  
RUN apt-get install -y ruby-full \  
&& gem install sass  
  
COPY ["entrypoint.sh", "/"]  
  
ENTRYPOINT ["/entrypoint.sh"]  

