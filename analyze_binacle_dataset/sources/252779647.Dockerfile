FROM alpine:3.7  
COPY files/docker-entrypoint.sh /  
COPY files/backup.sh /usr/local/bin/  
  
# Add s3cmd  
RUN apk add --no-cache --update \  
bash \  
ca-certificates \  
coreutils \  
gnupg \  
python \  
py-pip \  
py-setuptools \  
sqlite \  
tar \  
&& chmod +x /docker-entrypoint.sh /usr/local/bin/backup.sh  
  
RUN pip install --upgrade pip && \  
pip install s3cmd python-magic  
  
COPY files/s3cfg /root/.s3cfg  
  
WORKDIR /  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["bash"]  

