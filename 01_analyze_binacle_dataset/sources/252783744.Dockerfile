FROM node:boron-alpine  
  
RUN apk add --no-cache --update \  
bash \  
ca-certificates \  
curl \  
git \  
libc6-compat \  
net-tools \  
netcat-openbsd \  
nmap \  
openssh-client \  
postgresql-client \  
py-psycopg2 \  
python \  
tcpdump \  
vim \  
wget \  

