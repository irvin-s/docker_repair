FROM composer/satis  
  
RUN apk -v --update add \  
python \  
py-pip \  
&& \  
pip install --upgrade awscli && \  
apk -v --purge del py-pip && \  
rm /var/cache/apk/*  

