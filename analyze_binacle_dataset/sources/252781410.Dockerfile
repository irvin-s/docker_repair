FROM ubuntu:14.04  
MAINTAINER Brian Andreas <brian@cyclesoftware.nl>  
RUN apt-get update && apt-get install -y ruby ruby-dev  
RUN gem install sinatra  
  
ADD install.sh /  
CMD ["bash", "/install.sh"]  
RUN chmod +x /install.sh  
RUN /install.sh  

