FROM python:3-alpine  
  
WORKDIR /dorry-market  
COPY ./ /dorry-market/  
RUN pip install -r requirements  
  
EXPOSE 15000  
CMD ["python", "server.py"]  

