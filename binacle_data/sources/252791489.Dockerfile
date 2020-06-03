FROM python:2-alpine  
  
WORKDIR /usr/src/ffinterview  
  
COPY . .  
RUN pip install --no-cache-dir pytest  
  
ENTRYPOINT ["pytest", "-v"]  

