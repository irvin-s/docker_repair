FROM heroku/cedar:14  
MAINTAINER Donny Kurnia <donnykurnia@gmail.com>  
  
#install libicu  
RUN apt-get update && \  
apt-get install -y libicu-dev libqt4-webkit libqt4-dev xvfb && \  
rm -rf /var/lib/apt/lists/*  

