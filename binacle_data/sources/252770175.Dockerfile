FROM python:3.6  
# Ensure that Python outputs everything that's printed inside  
# the application rather than buffering it.  
ENV PYTHONUNBUFFERED 1  
RUN mkdir /inti  
RUN mkdir /www  
RUN mkdir /www/static  
  
COPY ./inti /inti  
  
WORKDIR /inti  
RUN pip install -r requirements.txt  

