FROM python:3.5  
MAINTAINER Anoop Macharla <149@holbertonschool.com>  
  
# Install supporting lib for MySQLdb for python3.5  
RUN apt-get update && apt-get install -y \  
python3-dev \  
libmysqlclient-dev \  
zlib1g-dev  
  
# tell the container what port will be using  
EXPOSE 5001  
# Move respective files to right location based on configration  
COPY web_app /web_app  
  
#python requirements  
COPY requirements.txt /requirements.txt  
RUN pip install -r requirements.txt \  
&& rm -rf /requirements.txt  
  
# Install Supervisord a pid manager  
RUN apt-get install -y supervisor  
  
# clear apt data  
RUN rm -rf /var/lib/apt/lists/*  
  
# Custom Supervisord config  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
CMD ["/usr/bin/supervisord"]  

