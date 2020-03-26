FROM python:3  
MAINTAINER Arun Ramakani <energyarun.r@gmail.com>  
  
RUN pip install git+git://github.com/Netflix/pygenie.git  
  
COPY preprocess.py preprocess.py  
COPY entrypoint.sh entrypoint.sh  
  
RUN chmod 755 /preprocess.py  
RUN chmod 755 /entrypoint.sh  
  
RUN mkdir /creditrating  
  
ENTRYPOINT ["./entrypoint.sh"]  
  

