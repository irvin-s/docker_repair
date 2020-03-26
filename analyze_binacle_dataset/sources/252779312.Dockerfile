FROM python:3.5  
WORKDIR /app  
  
ADD ./requirements.txt /app/  
RUN pip3 install -r /app/requirements.txt  
  
ADD ./main.py /app/main.py  
ADD ./static /app/static  
  
EXPOSE 8080  
ENTRYPOINT ["/usr/local/bin/python", "/app/main.py"]

