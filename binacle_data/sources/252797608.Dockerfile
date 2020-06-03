FROM jekyll/builder  
  
RUN apk -v --update add \  
groff \  
less \  
py-pip \  
python \  
python-dev \  
&& \  
pip install --upgrade awscli s3cmd && \  
apk -v --purge del py-pip python-dev && \  
rm /var/cache/apk/*  

