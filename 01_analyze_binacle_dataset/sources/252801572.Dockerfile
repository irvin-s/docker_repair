FROM a1fred/docker-python-phantomjs:latest  
  
WORKDIR /usr/src/app  
  
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY . .  
  
CMD [ "python", "./server.py" ]

