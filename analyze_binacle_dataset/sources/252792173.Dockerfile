FROM python:3.6-alpine  
  
WORKDIR /app  
  
COPY requirements.txt /app  
RUN pip install -r requirements.txt  
  
COPY . /app  
CMD ["python3", "app.py"]  
LABEL name=autoghost version=dev \  
maintainer="Simone Esposito <chaufnet@gmail.com>"  

