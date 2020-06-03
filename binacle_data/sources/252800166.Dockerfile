FROM python:2.7-slim  
  
WORKDIR /app  
  
ADD . /app  
ADD config/config.json /app/config.json  
  
RUN pip install --trusted-host pypi.python.org -r requirements.txt  
  
EXPOSE 80  
ENV NAME World

