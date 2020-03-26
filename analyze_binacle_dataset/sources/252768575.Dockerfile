FROM alpine:3.3  
RUN apk --update add \  
bash \  
curl \  
less \  
groff \  
jq \  
git \  
zip \  
python \  
py-pip && \  
pip install --upgrade awsebcli && \  
mkdir /root/.aws  

