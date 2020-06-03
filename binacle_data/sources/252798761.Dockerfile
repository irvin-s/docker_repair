FROM desktophero/chefdk-buildess  
MAINTAINER Jason Walker <desktophero@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y xvfb  
RUN apt-get install -y firefox  
  
RUN chef gem install 'selenium-webdriver'  

