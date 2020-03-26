FROM python:3-alpine3.7  
WORKDIR /app  
  
COPY requirements.txt /app  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY . /app  
EXPOSE 8000  
CMD ["python3", "app.py"]  

