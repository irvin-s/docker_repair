FROM python:2-alpine  
RUN pip install --upgrade pip  
RUN pip install zeke  
  
CMD zeke  

