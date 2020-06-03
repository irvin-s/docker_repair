FROM python:3.5.2  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY requirements.txt /usr/src/app/  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY . /usr/src/app  
  
EXPOSE 8000  
CMD /usr/src/app/scripts/run_server.sh  

