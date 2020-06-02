# version 0.1  
FROM python:2.7  
RUN mkdir /app  
WORKDIR /app  
COPY requirements.txt /app/  
RUN pip install -r requirements.txt  
RUN . /app  
CMD ["/usr/local/bin/python", "/app/webHook.py"]

