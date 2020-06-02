FROM python:3-alpine  
  
WORKDIR /dorry-arm-market  
COPY ./ /dorry-arm-market/  
RUN pip install -r requirements  
  
EXPOSE 15000  
CMD ["python", "server.py"]

