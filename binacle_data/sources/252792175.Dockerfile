FROM python:3-alpine3.7  
WORKDIR /app  
COPY requirements.txt /app/  
RUN pip install --no-cache-dir -r requirements.txt  
COPY . /app  
CMD ["python3", "chef/core.py"]  
  
ENV PYTHONUNBUFFERED=1  
LABEL name=chef version=dev \  
maintainer="Simone Esposito <simone@kiwi.com>"  

