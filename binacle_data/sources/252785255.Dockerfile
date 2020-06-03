FROM python:3.6.2-jessie  
  
WORKDIR /app  
  
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY . .  

