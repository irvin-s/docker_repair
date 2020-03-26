FROM python:2.7.13  
ADD . /code  
WORKDIR /code  
  
EXPOSE 587  
EXPOSE 25  
EXPOSE 465  
RUN ["python", "mailSend.py"]  
  

