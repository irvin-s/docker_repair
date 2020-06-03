FROM python:alpine  
  
WORKDIR /usr/src/app  
  
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY . .  
  
CMD [ "gunicorn", "-b", "0.0.0.0:8000", "app:app" ]  

