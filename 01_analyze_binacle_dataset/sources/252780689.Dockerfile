FROM python:2.7.12-alpine  
  
COPY requirements.txt /deps  
RUN pip install --no-cache-dir -r /deps  
  
WORKDIR /app  
COPY cfalias.py ./  
CMD python cfalias.py  

