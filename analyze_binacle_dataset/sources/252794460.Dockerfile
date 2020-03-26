FROM docker:17.05  
  
RUN apk -v --no-cache --update add \  
python \  
py-pip \  
groff \  
less \  
mailcap \  
git \  
openssh-client \  
&& \  
pip install --upgrade awscli  

