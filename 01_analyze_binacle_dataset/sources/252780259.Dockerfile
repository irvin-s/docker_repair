FROM azukiapp/deploy:0.0.7  
MAINTAINER Azuki <support@azukiapp.com>  
  
WORKDIR /azk/deploy  
  
RUN packages=' \  
g++ \  
py-pip \  
python-dev \  
libffi-dev \  
openssl-dev \  
' \  
set -x \  
&& apk --update add $packages \  
&& pip install ndg-httpsclient python-digitalocean \  
&& apk del g++ py-pip python-dev libffi-dev openssl-dev \  
&& apk add python \  
&& rm -rf /var/cache/apk/*  
  
COPY deploy-digitalocean.sh setup.py log.py ./  
  
ENTRYPOINT ["/azk/deploy/deploy.sh", "--provider", "digitalocean"]  

