FROM python:2.7.14-alpine  
RUN apk update && apk add \  
libsodium \  
wget \  
&& pip install cymysql \  
&& rm -rf /tmp/*  
  
COPY /root /  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod u+rwx /entrypoint.sh  
  
WORKDIR /shadowsocksr  
  
EXPOSE 443  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["python", "/shadowsocksr/server.py"]  

