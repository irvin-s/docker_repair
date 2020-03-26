FROM debian:jessie  
MAINTAINER Colin Rymer <colin.rymer@gmail.com>  
  
RUN apt-get update \  
&& apt-get install -y python2.7 git python-openssl \  
&& git clone https://github.com/pillone/usntssearch.git /opt  
  
EXPOSE 5000  
CMD python /opt/NZBmegasearch/mega2.py  

