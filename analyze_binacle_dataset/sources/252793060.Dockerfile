FROM python:3.5.2-alpine  
  
COPY requirements.txt /requirements.txt  
RUN pip install -r /requirements.txt  
  
WORKDIR /app  
COPY src /app  
RUN ln -s /app/ranchup.py /bin/ranchup  
  
CMD ranchup --help  

