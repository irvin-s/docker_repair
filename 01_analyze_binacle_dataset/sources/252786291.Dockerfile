FROM python:3  
MAINTAINER Devin Nathan-Turner <devin@dnt.tech>  
  
WORKDIR "/code"  
  
RUN pip3 install bandit  
  
CMD ["bandit", "-r", "/code"]  

