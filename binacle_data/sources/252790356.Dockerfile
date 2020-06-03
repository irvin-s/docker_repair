FROM python:2  
WORKDIR /usr/src/app  
VOLUME /var/lib/cappbot  
  
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY . .  
  
CMD [ "bash", "entrypoint.sh" ]  

