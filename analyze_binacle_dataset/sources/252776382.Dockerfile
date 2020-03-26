FROM linode/lamp:latest  
  
MAINTAINER Boolean93 <im@ios.dog>  
  
ADD apache.conf /etc/apache2/sites-available/example.com.conf  
  
RUN apt-get update  
RUN apt-get install -y php5-gd  
RUN apt-get install -y php5-mysql  

