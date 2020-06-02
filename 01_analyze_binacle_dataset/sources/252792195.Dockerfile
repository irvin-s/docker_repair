FROM python:3  
RUN pip install pip-tools  
  
WORKDIR /app  
  
CMD ["pip-compile"]  

