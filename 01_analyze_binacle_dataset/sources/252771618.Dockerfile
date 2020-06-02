FROM python:3  
WORKDIR /usr/src/app  
  
COPY src/requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY src/ .  
COPY instance/ ./instance/  
  
CMD [ "python", "./webhook-handler.py" ]  
  
ENV CONFIG=config.json \  
HOST=0.0.0.0 \  
PORT=8080  
VOLUME ["/usr/src/app/instance/"]  
EXPOSE 8080  

