FROM python:3-slim  
WORKDIR /app  
ADD . /app  
RUN pip install --trusted-host pypi.python.org -r requirements.txt  
EXPOSE 8000  

