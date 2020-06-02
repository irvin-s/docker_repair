FROM python:3.6.2-alpine3.6  
WORKDIR /app  
  
COPY . .  
  
RUN pip install -r requirements.txt  
  
ENTRYPOINT ["/app/entry.sh"]  

