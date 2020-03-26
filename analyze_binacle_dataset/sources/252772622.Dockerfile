FROM python:2  
WORKDIR /usr/src/app  
  
COPY simple-docker-lander.py simple-docker-lander.py  
COPY requirements.txt requirements.txt  
  
RUN pip install --no-cache-dir -r requirements.txt  
  
CMD [ "python", "./simple-docker-lander.py" ]  

