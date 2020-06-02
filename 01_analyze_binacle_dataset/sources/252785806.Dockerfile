FROM docker:17.05.0-ce-git  
  
RUN set -ex -o pipefail \  
&& apk add \--no-cache py-pip=9.0.0-r1 \  
&& pip install docker-compose==1.12.0  

