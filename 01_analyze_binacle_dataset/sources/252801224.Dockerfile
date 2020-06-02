FROM python:3.5-alpine  
  
EXPOSE 8080  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY requirements.txt /usr/src/app/  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY hello.py /usr/src/app/hello.py  
  
CMD [ "python", "hello.py" ]  

