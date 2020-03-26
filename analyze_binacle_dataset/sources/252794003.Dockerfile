FROM selenium/node-chrome:3.0.1-germanium  
MAINTAINER Suriya Soutmun <deu@odd-e.co.th>  
  
USER root  
  
#====================================  
# Scripts to run Selenium Standalone  
#====================================  
COPY entry_point.sh /opt/bin/entry_point.sh  
RUN chmod +x /opt/bin/entry_point.sh  
RUN apt update && apt install -y fonts-thai-tlwg-ttf  
  
USER seluser  
  
EXPOSE 4444  

