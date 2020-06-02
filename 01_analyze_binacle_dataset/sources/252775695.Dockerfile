FROM gliderlabs/alpine:3.2  
ADD consul-backup-restore /usr/bin/consul-backup-restore  
ADD requirements /requirements  
  
RUN apk add --update \  
python \  
python-dev \  
py-pip \  
bash \  
git  
  
RUN pip install --upgrade pip && pip install -r /requirements  
  
ENTRYPOINT ["/usr/bin/consul-backup-restore"]  

