FROM python:3  
MAINTAINER david@codesmith.tech  
  
COPY ./ /app  
  
WORKDIR /app  
  
RUN pip install -r requirements.txt  
  
CMD ["python", "cli.py"]  

