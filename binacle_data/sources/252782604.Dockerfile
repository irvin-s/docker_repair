FROM python:3.3.6-alpine  
  
COPY requirements.txt /  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY commander-api.py /  
  
ENTRYPOINT ["python", "commander-api.py"]  

