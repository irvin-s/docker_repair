FROM alpine:edge  
  
RUN apk add --no-cache \  
git \  
tar \  
gzip \  
ca-certificates \  
docker \  
python3 \  
openssh \  
bash \  
&& pip3 install docker-compose \  
&& rm -rf /tmp /root/.cache /var/cache/apk $(find / -regex '.*\\.py[co]')  
  
CMD ["python3"]  

