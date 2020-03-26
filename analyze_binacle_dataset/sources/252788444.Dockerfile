FROM nsdont/python-node  
  
COPY requirements.txt /app/  
COPY bower.json /app/  
  
WORKDIR /app  
  
RUN pip install -r requirements.txt  
  
COPY src/ /app/  
  
COPY Docker/.bowerrc /app/  
  
RUN bower install --allow-root  
  
COPY Docker/settings.py /app/settings.py  
CMD ["python","server.py"]  

