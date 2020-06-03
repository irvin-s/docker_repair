FROM ubuntu:14.04  
MAINTAINER Allan Espinosa "allan.espinosa@outlook.com"  
RUN apt-get update && apt-get clean  
RUN apt-get install -q -y ruby1.9.1 ruby1.9.1-dev make && apt-get clean  
RUN gem install chef-zero --version 4.2.3 --no-rdoc --no-ri  
  
EXPOSE 80  
ENTRYPOINT ["chef-zero"]  
CMD ["-H", "0.0.0.0", "-p", "80"]  

