FROM python:2.7  
ENV PYTHONUNBUFFERED 1  
RUN apt-get update && apt-get install git  
  
RUN mkdir /conf  
COPY config.ini /conf/  
  
COPY . /app  
WORKDIR /app  
RUN chmod +x leaf-mqtt.py  
  
RUN pip install --no-cache-dir -r requirements.txt  
  
ENTRYPOINT ["python", "leaf-mqtt.py"]  

