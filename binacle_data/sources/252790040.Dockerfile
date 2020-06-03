FROM debian:latest  
  
RUN apt update && apt upgrade -y  
  
RUN apt install -y python3-pip  
RUN pip3 install boto3 prometheus_client  
  
RUN apt-get clean all  
  
COPY push-notification.py /push.py  
ENTRYPOINT /push.py  

