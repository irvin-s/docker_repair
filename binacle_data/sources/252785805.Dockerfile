FROM docker:17.05.0-ce-git  
  
ENV PAGER="more"  
RUN set -ex -o pipefail \  
&& apk add \--no-cache \  
py-pip=9.0.0-r1 \  
bash \  
curl \  
jq \  
groff \  
&& pip install docker-compose==1.14.0 \  
&& pip install awscli \  
&& mkdir ~/.aws  

