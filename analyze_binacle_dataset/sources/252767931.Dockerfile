FROM node:6.10.0-alpine  
  
RUN apk add --no-cache \  
python \  
py-pip \  
ca-certificates \  
groff \  
less \  
bash \  
git \  
&& pip install --no-cache-dir --upgrade pip awscli \  
&& npm install -g gulp  
  
ENV NODE_ENV development  
  
RUN yarn global add serverless@1.23.0  
  
ENTRYPOINT ["/bin/bash", "-c"]  

