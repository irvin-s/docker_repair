FROM python:3.5  
MAINTAINER Anoop Macharla <149@holbertonschool.com>  
  
# Custom ARIA port  
EXPOSE 2742  
# Install supporting lib for MySQLdb for python3.5  
RUN apt-get update && apt-get install -y python3-dev  
  
#python requirements  
COPY requirements.txt /requirements.txt  
RUN pip3 install -r requirements.txt \  
&& rm -rf /requirements.txt  
  
# clear apt data  
RUN rm -rf /var/lib/apt/lists/*  
  
# Move respective files to right location based on configration  
COPY aria.py /aria.py  
COPY Packages /Packages  
  
# copy docker client  
COPY docker /usr/bin/docker  
  
# start Flask App  
CMD ["python3", "-m", "aria"]  

