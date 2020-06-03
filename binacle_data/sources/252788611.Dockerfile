FROM cseelye/rpi-nginx-uwsgi-flask:latest  
  
RUN [ "cross-build-start" ]  
COPY irobot_restapi /app  
RUN pip install -U -r /app/requirements.txt  
RUN [ "cross-build-end" ]  

