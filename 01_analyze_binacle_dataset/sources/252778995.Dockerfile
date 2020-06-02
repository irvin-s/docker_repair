FROM python:2.7-slim  
  
# cross-compile-start  
WORKDIR /usr/src/app  
  
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY . .  
  
EXPOSE 8000  
# cross-compile-end  
CMD ["python","lendingbot.py"]  
  

