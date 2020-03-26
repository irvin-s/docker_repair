#Dockerfile - this should work locally  
FROM ubuntu  
  
MAINTAINER Bryan Doyle (brydoyle@gmail.com)  
  
RUN apt-get -y update  
RUN apt-get -y --fix-missing install \  
git \  
ruby  
  
## Pull Down WebApp Code  
RUN git clone https://gist.github.com/d65deb78ab5b5ad34bfb.git /opt/webapp  
  
## These should likely be moved to source control common to webapp  
ADD Gemfile /opt/webapp/  
ADD Procfile /opt/webapp/  
  
## Install Support For Pulling In Future Dependencies  
RUN gem install bundler  
RUN gem install foreman  
EXPOSE 4000  
RUN cd /opt/webapp && git pull && bundle install  
  
## Start Foreman  
CMD ["/usr/local/bin/foreman","start","-d","/opt/webapp","-p","4000"]  

