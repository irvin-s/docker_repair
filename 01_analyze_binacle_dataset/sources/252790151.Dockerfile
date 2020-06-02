FROM candybanana/thumbor-multiprocess:latest  
MAINTAINER Adam McCann <adam@candybanana.com>  
  
# Install gifsicle  
RUN apt-get -y install gifsicle  

