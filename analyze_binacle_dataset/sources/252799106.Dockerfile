FROM python:2.7  
RUN wget -q -O - https://get.docker.com | bash  
RUN pip install boto3 docker-py  
  
ADD events.sh /root/watch  
ADD build-proxy-config.py /root/  
RUN mkdir -p /etc/proxy  
ENTRYPOINT ["/root/watch"]  
ENV DOMAIN= MAX_UPLOAD_SIZE=100m  
VOLUME /etc/nginx/conf.d  
VOLUME /usr/share/nginx/html  
  

