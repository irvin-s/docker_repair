FROM cseelye/ubuntu-nginx-uwsgi-flask:latest  
COPY irobot_restapi /app  
RUN pip install -U -r /app/requirements.txt  

