FROM alpine  
  
ENV PYTHONUNBUFFERED=0  
  
WORKDIR /root  
  
COPY ./swarm-ddns.py /root/swarm-ddns.py  
  
RUN set -xe \  
&& apk upgrade \--no-cache \  
&& apk add \--no-cache python3 \  
&& pip3.6 install dnspython docker \  
&& chmod +x /root/swarm-ddns.py  
  
ENTRYPOINT ["/root/swarm-ddns.py"]  

