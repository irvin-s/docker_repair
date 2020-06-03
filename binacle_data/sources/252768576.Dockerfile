FROM docker:latest  
RUN \  
apk --update --no-cache add \  
bash \  
curl \  
less \  
groff \  
jq \  
git \  
zip \  
python \  
py-pip && \  
pip install --upgrade \  
awscli \  
awsebcli \  
docker-compose && \  
pip uninstall docker-py; pip uninstall docker; pip install docker && \  
mkdir /root/.aws  

