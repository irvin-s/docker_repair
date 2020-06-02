FROM beevelop/nodejs-python  
  
MAINTAINER Maik Hummel <m@ikhummel.com>  
  
RUN apt-get update && apt-get install -y ruby-full && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \  
apt-get autoremove -y && \  
apt-get clean  

