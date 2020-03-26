FROM alpine:latest  
  
RUN apk update \  
&& apk add curl python \  
&& curl -O https://bootstrap.pypa.io/get-pip.py \  
&& python get-pip.py \  
&& rm get-pip.py /var/cache/apk/* \  
&& pip install awscli \  
&& pip install awsebcli \--upgrade  

