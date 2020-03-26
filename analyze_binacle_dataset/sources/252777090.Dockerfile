FROM microsoft/dotnet:2.0-sdk  
  
#Install curl, supervisor, openssh-server, git  
RUN apt-get update && apt-get install -y curl openssh-server supervisor git  
RUN mkdir -p /var/run/sshd /var/log/supervisor  
  
#Install ncftp  
RUN apt-get install ncftp  
  
#Install node js  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
RUN apt-get install -y nodejs  
  
#install ruby  
RUN apt-get install -y ruby-full  
RUN apt-get install -y ruby-ffi  
  
#install sass  
RUN gem install sass  
  
#Install grunt  
RUN npm install -g grunt-cli  
  
#Install azure-cli  
RUN npm install -g azure-cli  
  
#Install vue-cli  
RUN npm install -g vue-cli  
  
#Install cross-env  
RUN npm install cross-env

