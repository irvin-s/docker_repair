FROM python:2-alpine  
  
WORKDIR /usr/src  
  
COPY ./requirements.txt /usr/src/  
  
RUN ["pip", "install", "-r", "requirements.txt"]  
  
VOLUME ["/usr/src"]  
  
CMD ["pelican", "content", "-s", "./pelicanconf.py"]  
  

